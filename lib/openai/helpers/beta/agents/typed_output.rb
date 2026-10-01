# frozen_string_literal: true

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
            unless model.is_a?(Class) && model < OpenAI::Helpers::StructuredOutput::BaseModel
              raise ArgumentError, "output_type must be an OpenAI::BaseModel subclass"
            end

            @model = model

          end

          def prepare_request(params)
            agent = params.fetch(:agent, nil).to_h.transform_keys { _1.is_a?(String) ? _1.to_sym : _1 }
            text = agent.fetch(:text, nil).to_h.transform_keys { _1.is_a?(String) ? _1.to_sym : _1 }
            if text.key?(:format)
              raise ArgumentError, "output_type cannot be combined with agent.text.format"
            end

            @schema = JSON.parse(JSON.generate(@model.to_json_schema, max_nesting: false), max_nesting: false)
            normalize_references
            @schema = @schema.merge(resolve(@schema.fetch("$ref"))).except("$ref") if @schema.key?("$ref")
            if @schema["type"] != "object" || %w[oneOf anyOf allOf enum not].any? { @schema.key?(_1) }
              raise ArgumentError, "output_type must have an object-root schema without root composition"
            end

            check_schema(@schema)

            params[:agent] = agent.merge(text: text.merge(format: {type: :json_schema, schema: @schema}))
          end

          def parse(result)
            return @result if @result && @result.raw_result.equal?(result)
            raise @error if @error && @error.raw_result.equal?(result)

            value = JSON.parse(result.output_text, symbolize_names: true, max_nesting: false)
            state = OpenAI::Internal::Type::Converter.new_coerce_state(memoize: true)
            parsed = OpenAI::Internal::Type::Converter.coerce(@model, value, state: state)
            unless parsed.is_a?(@model) && state[:exactness][:no].zero?
              raise TypeError, "Output cannot be parsed into output_type"
            end

            @result = ParsedTurnResult.new(raw_result: result, output_parsed: parsed)
          rescue JSON::ParserError, TypeError, RangeError, SystemStackError
            @error = OutputParseError.new(raw_result: result)
            raise @error, cause: nil
          end

          private

          def resolve(ref)
            unless ref.is_a?(String) && ref.start_with?("#/")
              raise ArgumentError, "output_type contains an unsupported schema reference"
            end

            URI::RFC2396_PARSER
              .unescape(ref.delete_prefix("#/"))
              .split("/", -1)
              .reduce(@schema) { |node, token| node.fetch(token.gsub("~1", "/").gsub("~0", "~")) }
          rescue KeyError, NoMethodError
            raise ArgumentError, "output_type contains an unresolved schema reference"
          end

          def normalize_references
            definitions = @schema.fetch("$defs", {})
            names = {}.compare_by_identity
            definitions.each_value.with_index { |definition, index| names[definition] = "model_#{index}" }
            pending = [@schema]
            until pending.empty?
              node = pending.pop
              next unless node.is_a?(Hash)
              pending.concat(node.fetch("properties", {}).values)
              pending.concat(node.fetch("$defs", {}).values)
              pending.concat(node.fetch("anyOf", []))
              pending.concat(node.fetch("prefixItems", []))
              pending << node["items"] if node.key?("items")
              pending << node["additionalProperties"] if node["additionalProperties"].is_a?(Hash)
              next unless node.key?("$ref")
              name = names.fetch(resolve(node["$ref"]))
              node["$ref"] = "#/$defs/#{name}"
              if node.key?("description") || node.key?("title")
                node["anyOf"] = [{"$ref" => node.delete("$ref")}]
              end
            end

            unless definitions.empty?
              @schema["$defs"] = definitions.to_h { |_name, definition| [names.fetch(definition), definition] }
            end
          end

          def check_schema(schema, seen = {}.compare_by_identity)
            return if seen[schema]
            seen[schema] = true
            unsupported = %w[
              unevaluatedProperties
              propertyNames
              minProperties
              maxProperties
              unevaluatedItems
              contains
              minContains
              maxContains
              uniqueItems
              allOf
              oneOf
              not
              dependentRequired
              dependentSchemas
              if
              then
              else
              x-guidance
            ]
            unless schema.is_a?(Hash) && (schema.keys & unsupported).empty?
              raise ArgumentError, "output_type contains unsupported schema constraints"
            end

            if schema.key?("type")
              types = Array(schema["type"])
              if types.empty? || !(types - %w[object array string integer number boolean null]).empty?
                raise ArgumentError, "output_type contains an invalid JSON type"
              end
            end

            if schema.key?("format") &&
               !%w[date-time time date duration email hostname ipv4 ipv6 uuid].include?(schema["format"]) &&
               schema["format"] != ""
              raise ArgumentError, "output_type contains an unsupported string format"
            end

            if schema.key?("enum") && (!schema["enum"].is_a?(Array) || schema["enum"].empty?)
              raise ArgumentError, "output_type enums must contain at least one value"
            end

            if schema.key?("$ref")
              unless (schema.keys - %w[$ref $defs]).empty?
                raise ArgumentError, "output_type contains unsupported reference siblings"
              end

              check_schema(resolve(schema["$ref"]), seen)
            end

            schema.fetch("properties", {}).each_value { check_schema(_1, seen) }
            schema.fetch("$defs", {}).each_value { check_schema(_1, seen) }
            check_schema(schema["items"], seen) if schema.key?("items")
            schema.fetch("anyOf", []).each { check_schema(_1, seen) }
          end

        end
      end
    end
  end
end
