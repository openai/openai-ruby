# frozen_string_literal: true

require_relative "model_adapter"

module OpenAI
  module Helpers
    module Beta
      module Agents
        # A completed turn with output hydrated into the requested Ruby model (beta).
        class ParsedTurnResult < TurnResult
          attr_reader :raw_result, :output_parsed

          # @api private
          def initialize(raw_result:, output_parsed:)
            @raw_result = raw_result
            @output_parsed = output_parsed
            super(turn: raw_result.turn, messages: raw_result.messages)
          end
        end

        # Hosted work completed, but its answer did not match the requested model.
        class OutputParseError < OpenAI::Errors::Error
          attr_reader :raw_result

          # @api private
          def initialize(raw_result:)
            @raw_result = raw_result
            super("The completed agent output does not match output_type")
          end
        end

        # @api private
        class OutputParser
          def initialize(model)
            ModelAdapter.validate!(model, parameter: "output_type")

            @model = model
          end

          def prepare_request(params)
            agent = params.fetch(:agent, nil).to_h.transform_keys { _1.is_a?(String) ? _1.to_sym : _1 }
            text = agent.fetch(:text, nil).to_h.transform_keys { _1.is_a?(String) ? _1.to_sym : _1 }
            if text.key?(:format) || text.key?(:format_)
              raise ArgumentError, "output_type cannot be combined with agent.text.format"
            end

            @schema = JSON.parse(JSON.generate(@model.to_json_schema, max_nesting: false), max_nesting: false)
            normalize_references
            params[:agent] = agent.merge(text: text.merge(format: {type: :json_schema, schema: @schema}))
          end

          def parse(result)
            return @result if @result && @result.raw_result.equal?(result)
            raise @error if @error && @error.raw_result.equal?(result)

            first = nil
            result.messages.each do |message|
              message.content.each do |part|
                next unless (part[:type] || (part["type"] if part.is_a?(Hash))).to_s == "output_text"
                text = part[:text] || (part["text"] if part.is_a?(Hash))
                value = JSON.parse(text, symbolize_names: true, max_nesting: false)
                parsed = ModelAdapter.coerce(@model, value, memoize: true)
                raise TypeError, "Output cannot be parsed into output_type" unless parsed
                first ||= parsed
              end
            end

            raise TypeError, "Output does not contain structured text" unless first

            @result = ParsedTurnResult.new(raw_result: result, output_parsed: first)
          rescue StandardError, SystemStackError => error
            raise if error.equal?(@error)
            @error = OutputParseError.new(raw_result: result)
            raise @error, cause: nil
          end

          private

          def resolve(ref)
            return unless ref.is_a?(String) && ref.start_with?("#/")

            URI::RFC2396_PARSER
              .unescape(ref.delete_prefix("#/"))
              .split("/", -1)
              .reduce(@schema) { |node, token| node[token.gsub("~1", "/").gsub("~0", "~")] if node.is_a?(Hash) }
          end

          def normalize_references
            return unless @schema.is_a?(Hash) && @schema["$defs"].is_a?(Hash)
            return if @schema.key?("$ref") && !(@schema.keys - %w[$defs $ref]).empty?
            definitions = @schema.fetch("$defs")
            return if definitions.empty? || !definitions.values.all? { _1.is_a?(Hash) }

            names = {}.compare_by_identity
            definitions.each_value.with_index { |definition, index| names[definition] = "model_#{index}" }
            nodes = schema_nodes
            return unless references_covered?(nodes)
            references = nodes.select { _1.key?("$ref") }
            return if references.empty?
            targets = references.map { resolve(_1["$ref"]) }
            # Native Ruby pointers encode definition names; Agents looks up raw suffixes.
            # Unfamiliar references keep their schema and definition names intact.
            return unless targets.all? { names.key?(_1) }
            root = resolve(@schema["$ref"])
            expand_root = root.is_a?(Hash) && !root.key?("$defs") && (@schema.keys - %w[$defs $ref]).empty?

            references.zip(targets).each do |node, target|
              node["$ref"] = "#/$defs/#{names.fetch(target)}"
              if (node.key?("description") || node.key?("title")) && !node.key?("anyOf")
                node["anyOf"] = [{"$ref" => node.delete("$ref")}]
              end
            end

            @schema["$defs"] = definitions.to_h { |_name, definition| [names.fetch(definition), definition] }
            @schema = @schema.except("$ref").merge(root) if expand_root
          end

          def references_covered?(nodes)
            known = nodes.each_with_object({}.compare_by_identity) { |node, seen| seen[node] = true }
            pending = [@schema]
            until pending.empty?
              value = pending.pop
              case value
              when Hash
                if known[value]
                  unless (value.keys &
                      %w[$id id $anchor $dynamicAnchor $dynamicRef $recursiveAnchor $recursiveRef discriminator])
                      .empty?
                    return false
                  end

                  pending.concat(
                    value.except("$ref", "title", "description", "default", "const", "enum", "examples").values
                  )
                else
                  return false if %w[$ref $dynamicRef $recursiveRef].any? { value[_1].is_a?(String) }
                  pending.concat(value.values)
                end

              when Array
                pending.concat(value)
              when String
                return false if value.start_with?("#/")
              end
            end

            true
          end

          def schema_nodes
            nodes = []
            pending = [@schema]
            until pending.empty?
              node = pending.pop
              next unless node.is_a?(Hash)
              nodes << node
              # Visit schema positions only: defaults, examples and enum values are data.
              %w[properties patternProperties $defs definitions dependentSchemas dependencies].each do |key|
                pending.concat(node[key].values.grep(Hash)) if node[key].is_a?(Hash)
              end

              %w[anyOf allOf oneOf prefixItems].each do |key|
                pending.concat(node[key]) if node[key].is_a?(Array)
              end

              %w[
                items
                additionalProperties
                additionalItems
                contains
                not
                if
                then
                else
                propertyNames
                unevaluatedProperties
                unevaluatedItems
              ]
                .each do |key|
                  pending.concat(node[key].is_a?(Array) ? node[key] : [node[key]]) if node.key?(key)
                end
            end

            nodes
          end

        end
      end
    end
  end
end
