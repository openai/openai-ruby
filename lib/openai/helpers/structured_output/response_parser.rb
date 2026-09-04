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
                      type: :json_schema | "json_schema",
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
              in {type: :function | "function", parameters: OpenAI::StructuredOutput::JsonSchemaConverter => params}
                func = tool.fetch(:function, tool)
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

        # Extracts retrieval-local structured-output hints without mutating caller-owned values.
        #
        # @api private
        #
        # @param parsed [Hash] Dumped retrieval parameters containing local text/tool hints
        # @return [Array<(JsonSchemaConverter|nil, Hash)>] Text model and named tool models
        def self.get_retrieval_models(parsed)
          get_models(duplicate_retrieval_params(parsed.slice(:text, :tools)))
        end

        # Parses retrieval output only when status and payload shape indicate it is complete.
        #
        # @api private
        #
        # @param raw [Hash] The raw retrieved response hash that will be mutated with parsed data
        # @param model [JsonSchemaConverter, nil] The converter for structured text output
        # @param tool_models [Hash<String, JsonSchemaConverter>] Tool names and their converters
        # @return [Hash] The same response with typed values in its :parsed fields when ready
        def self.parse_retrieved!(raw, model, tool_models)
          staged = {}.compare_by_identity
          return raw unless retrieval_complete?(raw, model, tool_models, staged)

          parse!(raw.merge(output: parsable_output(raw, staged)), model, tool_models)
          staged.each_value do |target, converter, parsed|
            target.store(:parsed, OpenAI::Internal::Type::Converter.coerce(converter, parsed))
          end

          raw
        end

        def self.retrieval_complete?(raw, model, tool_models, staged)
          return false unless [nil, "completed"].include?(raw[:status])

          raw[:output].to_a.none? do |output|
            case output[:type]
            when "message"
              model && unfinished_message?(output, model, staged, response_status: raw[:status])
            when "function_call"
              unfinished_function_call?(output, tool_models, staged, response_status: raw[:status])
            else
              false
            end
          end
        end

        def self.unfinished_message?(output, model, staged, response_status:)
          return true if pending_status?(output[:status])
          return false unless response_status.nil? && output[:status].nil?

          output[:content].to_a.any? do |content|
            next false unless content[:type] == "output_text"
            next true unless content.key?(:text)

            ready, parsed = prepare_value(content[:text])
            staged.store(content, [content, model, parsed]) if ready
            !ready
          end
        end

        def self.unfinished_function_call?(output, tool_models, staged, response_status:)
          return false if tool_models.empty?
          return false unless output.key?(:name)
          return false unless tool_models.key?(output[:name])
          return true if pending_status?(output[:status])
          return false unless response_status.nil? && output[:status].nil?
          return true unless output.key?(:arguments)

          model = tool_models.fetch(output[:name])
          ready, parsed = prepare_value(output[:arguments])
          staged.store(output, [output, model, parsed]) if ready
          !ready
        end

        def self.pending_status?(status)
          ["queued", "in_progress", "incomplete"].include?(status)
        end

        def self.prepare_value(value)
          [true, JSON.parse(value, symbolize_names: true)]
        rescue JSON::ParserError, TypeError
          [false, nil]
        end

        def self.parsable_output(raw, staged)
          raw[:output].to_a.filter_map do |output|
            next if output[:type] == "function_call" && (!output.key?(:name) || staged.key?(output))
            next output unless output[:type] == "message"

            content = output[:content].to_a.reject { |item| staged.key?(item) }
            output.merge(content: content)
          end
        end

        def self.duplicate_retrieval_params(value)
          case value
          when Array
            value.map { |item| duplicate_retrieval_params(item) }
          when Hash
            value.to_h do |key, item|
              normalized_key = key.is_a?(String) ? key.to_sym : key
              normalized_key = :format if normalized_key == :format_
              normalized_item = duplicate_retrieval_params(item)
              if normalized_key == :type && ["function", "json_schema"].include?(normalized_item)
                normalized_item = normalized_item.to_sym
              end

              [normalized_key, normalized_item]
            end
          else
            value
          end
        end

        private_class_method(
          :duplicate_retrieval_params,
          :parsable_output,
          :pending_status?,
          :prepare_value,
          :retrieval_complete?,
          :unfinished_function_call?,
          :unfinished_message?
        )
      end
    end
  end
end
