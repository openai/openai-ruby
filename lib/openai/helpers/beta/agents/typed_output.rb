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
            @schema = JSON.parse(JSON.generate(model.to_json_schema))
            @schema = @schema.merge(resolve(@schema.fetch("$ref"))).except("$ref") if @schema.key?("$ref")
            if @schema["type"] != "object" || %w[oneOf anyOf allOf enum not].any? { @schema.key?(_1) }
              raise ArgumentError, "output_type must have an object-root schema without root composition"
            end

            check_schema(@schema)
          end

          def prepare_request(params)
            agent = params.fetch(:agent, nil).to_h.dup
            text = agent.fetch(:text, nil).to_h.dup
            if text.key?(:format)
              raise ArgumentError, "output_type cannot be combined with agent.text.format"
            end

            params[:agent] = agent.merge(text: text.merge(format: {type: :json_schema, schema: @schema}))
          end

          def parse(result)
            return @result if @result && @result.raw_result.equal?(result)
            raise @error if @error && @error.raw_result.equal?(result)

            value = JSON.parse(result.output_text, symbolize_names: true, max_nesting: false)
            parsed = OpenAI::Internal::Type::Converter.coerce(@model, validate(@schema, value))
            @result = ParsedTurnResult.new(raw_result: result, output_parsed: parsed)
          rescue JSON::ParserError, TypeError, SystemStackError
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

          def check_schema(schema, seen = {}.compare_by_identity)
            return if seen[schema]
            seen[schema] = true
            supported = %w[
              type
              properties
              required
              additionalProperties
              items
              enum
              const
              anyOf
              default
              $ref
              $defs
              description
              title
            ]
            unless schema.is_a?(Hash) && (schema.keys - supported).empty?
              raise ArgumentError, "output_type contains unsupported schema constraints"
            end

            if schema.key?("type")
              types = Array(schema["type"])
              if types.empty? || !(types - %w[object array string integer number boolean null]).empty?
                raise ArgumentError, "output_type contains an invalid JSON type"
              end
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

          def validate(schema, value, cache = {}.compare_by_identity)
            outcomes = cache[schema] ||= {}.compare_by_identity
            if outcomes.key?(value)
              valid, parsed = outcomes[value]
              raise TypeError, "Output does not match the schema" unless valid
              return parsed
            end

            outcomes[value] = [false, nil]
            parsed = validate_value(schema, value, cache)
            outcomes[value] = [true, parsed]
            parsed
          end

          def validate_value(schema, value, cache)
            value = validate(resolve(schema["$ref"]), value, cache) if schema.key?("$ref")
            if schema.key?("anyOf")
              matches = schema["anyOf"].any? do |branch|
                begin
                  value = validate(branch, value, cache)
                  true
                rescue TypeError
                  false
                end
              end

              raise TypeError, "Output does not match any schema alternative" unless matches
            end

            if (schema.key?("enum") && !schema["enum"].include?(value)) ||
                (schema.key?("const") && schema["const"] != value)
              raise TypeError, "Output does not match the schema enum or constant"
            end

            if schema.key?("type")
              matches = Array(schema["type"]).any? do |type|
                case type
                when "object"
                  value.is_a?(Hash)
                when "array"
                  value.is_a?(Array)
                when "string"
                  value.is_a?(String)
                when "integer"
                  if value.is_a?(Float) && value.finite? && value == Integer(value)
                    value = Integer(value)
                  end

                  value.is_a?(Integer)
                when "number"
                  value.is_a?(Numeric) && value.finite?
                when "boolean"
                  value == true || value == false
                when "null"
                  value.nil?
                else
                  false
                end
              end

              raise TypeError, "Output has an incorrect JSON type" unless matches
            end

            if value.is_a?(Hash)
              properties = schema.fetch("properties", {})
              names = value.keys.map(&:to_s)
              if !(schema.fetch("required", []) - names).empty? ||
                  (schema["additionalProperties"] == false && !(names - properties.keys).empty?)
                raise TypeError, "Output contains missing or unexpected fields"
              end

              properties.each do |name, field|
                key = name.to_sym
                value[key] = validate(field, value[key], cache) if value.key?(key)
              end
            elsif value.is_a?(Array) && schema.key?("items")
              value.map! { validate(schema["items"], _1, cache) }
            end

            value
          end
        end
      end
    end
  end
end
