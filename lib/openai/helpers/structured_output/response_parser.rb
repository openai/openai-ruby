# frozen_string_literal: true

module OpenAI
  module Helpers
    module StructuredOutput
      # Request preparation and response coercion for the Responses API.
      #
      # @api private
      module ResponseParser
        # Post-processes raw API responses to parse and coerce structured outputs into typed Ruby objects.
        #
        # @api private
        #
        # @param raw [Hash] The raw API response hash that will be mutated with parsed data
        # @param model [JsonSchemaConverter, nil] The converter for structured text output
        # @param tool_models [Hash<String, JsonSchemaConverter>] Tool names and their converters
        # @return [Hash] The same response with typed values in its :parsed fields
        def self.parse!(raw, model, tool_models)
          if model.is_a?(OpenAI::StructuredOutput::JsonSchemaConverter)
            raw[:output]
              &.flat_map do |output|
                next [] unless output[:type] == "message"
                output[:content].to_a
              end
              &.each do |content|
                next unless content[:type] == "output_text"
                begin
                  parsed = JSON.parse(content.fetch(:text), symbolize_names: true)
                rescue JSON::ParserError => e
                  parsed = e
                end

                coerced = OpenAI::Internal::Type::Converter.coerce(model, parsed)
                content.store(:parsed, coerced)
              end
          end

          raw[:output]&.each do |output|
            next unless output[:type] == "function_call"
            next if (model = tool_models[output.fetch(:name)]).nil?
            begin
              parsed = JSON.parse(output.fetch(:arguments), symbolize_names: true)
            rescue JSON::ParserError => e
              parsed = e
            end

            coerced = OpenAI::Internal::Type::Converter.coerce(model, parsed)
            output.store(:parsed, coerced)
          end

          raw
        end

        # Extracts structured output models and replaces request values with JSON Schema.
        #
        # @api private
        #
        # @param parsed [Hash] Request parameters to update in place
        # @return [Array<(JsonSchemaConverter|nil, Hash)>] Text model and named tool models
        def self.get_models(parsed)
          model = nil
          tool_models = {}

          case parsed
          in {text: OpenAI::StructuredOutput::JsonSchemaConverter => model}
            parsed.update(
              text: {
                format: {
                  type: :json_schema,
                  strict: true,
                  name: model.name.split("::").last,
                  schema: model.to_json_schema
                }
              }
            )
          in {text: {format: OpenAI::StructuredOutput::JsonSchemaConverter => model}}
            parsed.fetch(:text).update(
              format: {
                type: :json_schema,
                strict: true,
                name: model.name.split("::").last,
                schema: model.to_json_schema
              }
            )
          in {
              text: {
                  format: {
                      type: :json_schema,
                      schema: OpenAI::StructuredOutput::JsonSchemaConverter => model
                    }
                }
            }
            parsed.dig(:text, :format).store(:schema, model.to_json_schema)
          else
          end

          case parsed
          in {tools: Array => tools}
            # rubocop:disable Metrics/BlockLength
            mapped = tools.map do |tool|
              case tool
              in OpenAI::StructuredOutput::JsonSchemaConverter
                name = tool.name.split("::").last
                tool_models.store(name, tool)
                {
                  type: :function,
                  strict: true,
                  name: name,
                  parameters: tool.to_json_schema
                }
              in {type: :function, parameters: OpenAI::StructuredOutput::JsonSchemaConverter => params}
                func = tool.fetch(:function)
                name = func[:name] ||= params.name.split("::").last
                tool_models.store(name, params)
                func.update(parameters: params.to_json_schema)
                tool
              in {type: _, function: {parameters: OpenAI::StructuredOutput::JsonSchemaConverter => params, **}}
                name = tool[:function][:name] || params.name.split("::").last
                tool_models.store(name, params)
                tool[:function][:parameters] = params.to_json_schema
                tool
              in {type: _, function: Hash => func}
                params = func[:parameters]
                # rubyfmt 0.14.1 corrupts a long guarded `in` clause into `in if`.
                # Keep the same guard in the existing handwritten branch instead.
                next tool unless params.is_a?(Class) && params < OpenAI::Internal::Type::BaseModel
                name = func[:name] || params.name.split("::").last
                tool_models.store(name, params)
                func[:parameters] = params.to_json_schema
                tool
              else
                tool
              end
            end
            # rubocop:enable Metrics/BlockLength
            tools.replace(mapped)
          else
          end

          [model, tool_models]
        end
      end
    end
  end
end
