# frozen_string_literal: true

module OpenAI
  module Helpers
    module StructuredOutput
      # Request preparation and response coercion for Chat Completions.
      #
      # @api private
      module ChatCompletionParser
        # @api private
        def self.build_unwrap(model, tool_models)
          # rubocop:disable Metrics/BlockLength
          -> (raw) do
            if model.is_a?(OpenAI::StructuredOutput::JsonSchemaConverter)
              raw[:choices]&.each do |choice|
                message = choice.fetch(:message)
                begin
                  content = message.fetch(:content)
                  parsed = content.nil? ? nil : JSON.parse(content, symbolize_names: true)
                rescue JSON::ParserError => e
                  parsed = e
                end

                coerced = OpenAI::Internal::Type::Converter.coerce(model, parsed)
                message.store(:parsed, coerced)
              end
            end

            raw[:choices]&.each do |choice|
              choice.dig(:message, :tool_calls)&.each do |tool_call|
                func = tool_call.fetch(:function)
                next if (model = tool_models[func.fetch(:name)]).nil?

                begin
                  arguments = func.fetch(:arguments)
                  parsed = arguments.nil? ? nil : JSON.parse(arguments, symbolize_names: true)
                rescue JSON::ParserError => e
                  parsed = e
                end

                coerced = OpenAI::Internal::Type::Converter.coerce(model, parsed)
                func.store(:parsed, coerced)
              end
            end

            raw
          end
          # rubocop:enable Metrics/BlockLength
        end

        # @api private
        def self.get_models(parsed)
          model = nil
          tool_models = {}
          case parsed
          in {response_format: OpenAI::StructuredOutput::JsonSchemaConverter => model}
            parsed.update(
              response_format: {
                type: :json_schema,
                json_schema: {
                  strict: true,
                  name: model.name.split("::").last,
                  schema: model.to_json_schema
                }
              }
            )
          in {
              response_format: {type: :json_schema, json_schema: OpenAI::StructuredOutput::JsonSchemaConverter => model}
            }
            parsed.fetch(:response_format).update(
              json_schema: {
                strict: true,
                name: model.name.split("::").last,
                schema: model.to_json_schema
              }
            )
          in {
              response_format: {
                  type: :json_schema,
                  json_schema: {schema: OpenAI::StructuredOutput::JsonSchemaConverter => model}
                }
            }
            parsed.dig(:response_format, :json_schema).store(:schema, model.to_json_schema)
          in {tools: Array => tools}
            mapped = tools.map do |tool|
              case tool
              in OpenAI::StructuredOutput::JsonSchemaConverter
                name = tool.name.split("::").last
                tool_models.store(name, tool)
                {
                  type: :function,
                  function: {
                    strict: true,
                    name: name,
                    parameters: tool.to_json_schema
                  }
                }
              in {function: {parameters: OpenAI::StructuredOutput::JsonSchemaConverter => params}}
                func = tool.fetch(:function)
                name = func[:name] ||= params.name.split("::").last
                tool_models.store(name, params)
                func.update(parameters: params.to_json_schema)
                tool
              else
                tool
              end
            end

            tools.replace(mapped)
          else
          end

          [model, tool_models]
        end

        # @api private
        def self.build_tools(tools, tool_models)
          return [] if tools.nil?

          tools.map do |tool|
            next tool unless tool[:type] == :function

            function_name = tool.dig(:function, :name)
            model = tool_models[function_name]

            model ? tool.merge(model: model) : tool
          end
        end
      end
    end
  end
end
