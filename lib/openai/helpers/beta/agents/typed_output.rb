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

            value = JSON.parse(result.output_text)
            validate(@schema, value)
            parsed = OpenAI::Internal::Type::Converter.coerce(
              @model,
              JSON.parse(result.output_text, symbolize_names: true)
            )
            @result = ParsedTurnResult.new(raw_result: result, output_parsed: parsed)
          rescue JSON::ParserError, TypeError => cause
            @error = OutputParseError.new(raw_result: result)
            raise @error, cause: cause
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

          def validate(schema, value)
            validate(resolve(schema["$ref"]), value) if schema.key?("$ref")
            if schema.key?("anyOf")
              matches = schema["anyOf"].any? do |branch|
                begin
                  validate(branch, value)
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
                  value.is_a?(Integer)
                when "number"
                  value.is_a?(Numeric)
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
              if !(schema.fetch("required", []) - value.keys).empty? ||
                  (schema["additionalProperties"] == false && !(value.keys - properties.keys).empty?)
                raise TypeError, "Output contains missing or unexpected fields"
              end

              properties.each { |name, field| validate(field, value[name]) if value.key?(name) }
            elsif value.is_a?(Array) && schema.key?("items")
              value.each { validate(schema["items"], _1) }
            end
          end
        end
      end
    end
  end
end
