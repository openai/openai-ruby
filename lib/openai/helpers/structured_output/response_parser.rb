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
          return raw unless retrieval_complete?(raw, model, tool_models)

          parsable_output = raw[:output].to_a.reject do |output|
            output[:type] == "function_call" && !output.key?(:name)
          end

          parse!(raw.merge(output: parsable_output), model, tool_models)
          raw
        end

        def self.retrieval_complete?(raw, model, tool_models)
          return false unless [nil, "completed"].include?(raw[:status])

          raw[:output].to_a.none? do |output|
            case output[:type]
            when "message"
              model && unfinished_message?(output, model, response_status: raw[:status])
            when "function_call"
              unfinished_function_call?(output, tool_models, response_status: raw[:status])
            else
              false
            end
          end
        end

        def self.unfinished_message?(output, model, response_status:)
          return true if pending_status?(output[:status])
          return false unless response_status.nil? && output[:status].nil?

          output[:content].to_a.any? do |content|
            content[:type] == "output_text" &&
              (!content.key?(:text) || !value_ready?(content[:text], model))
          end
        end

        def self.unfinished_function_call?(output, tool_models, response_status:)
          return false if tool_models.empty?
          return false unless output.key?(:name)
          return false unless tool_models.key?(output[:name])
          return true if pending_status?(output[:status])
          return false unless response_status.nil? && output[:status].nil?

          !output.key?(:arguments) || !value_ready?(output[:arguments], tool_models.fetch(output[:name]))
        end

        def self.pending_status?(status)
          ["queued", "in_progress", "incomplete"].include?(status)
        end

        def self.value_ready?(value, model)
          parsed = JSON.parse(value, symbolize_names: true)
          return false unless known_properties?(parsed, model.to_json_schema)

          state = OpenAI::Internal::Type::Converter.new_coerce_state
          OpenAI::Internal::Type::Converter.coerce(model, parsed, state: state)
          exactness = state.fetch(:exactness)
          exactness.fetch(:no).zero? && exactness.fetch(:maybe).zero?
        rescue JSON::ParserError, TypeError
          false
        end

        def self.known_properties?(value, schema, root_schema = schema)
          schema = resolve_schema(schema, root_schema)
          return false unless schema

          if (parts = schema[:allOf] || schema["allOf"])
            return parts.all? { |part| known_properties?(value, part, root_schema) }
          end

          if (variants = schema[:anyOf] || schema["anyOf"])
            compatible = variants.select { |variant| schema_matches_shape?(value, variant, root_schema) }
            return compatible.any? { |variant| known_properties?(value, variant, root_schema) }
          end

          type = schema[:type] || schema["type"]
          case type
          when "object"
            return true unless value.is_a?(Hash)

            properties = schema[:properties] || schema["properties"] || {}
            additional_properties = if schema.key?(:additionalProperties)
              schema[:additionalProperties]
            else
              schema["additionalProperties"]
            end

            if additional_properties == false
              return false if (value.keys.map(&:to_s) - properties.keys.map(&:to_s)).any?
            end

            properties.all? do |key, property_schema|
              value_key = value.key?(key) ? key : key.to_sym
              !value.key?(value_key) || known_properties?(value.fetch(value_key), property_schema, root_schema)
            end

          when "array"
            return true unless value.is_a?(Array)

            items = schema[:items] || schema["items"]
            value.all? { |item| known_properties?(item, items, root_schema) }
          else
            true
          end
        end

        def self.schema_matches_shape?(value, schema, root_schema)
          schema = resolve_schema(schema, root_schema)
          return false unless schema

          if (parts = schema[:allOf] || schema["allOf"])
            return parts.all? { |part| schema_matches_shape?(value, part, root_schema) }
          end

          if (variants = schema[:anyOf] || schema["anyOf"])
            return variants.any? { |variant| schema_matches_shape?(value, variant, root_schema) }
          end

          if schema.key?(:const) || schema.key?("const")
            constant = schema.key?(:const) ? schema[:const] : schema["const"]
            return value == constant
          end

          types = Array(schema[:type] || schema["type"])
          return true if types.empty?

          types.any? do |type|
            case type
            when "object"
              value.is_a?(Hash)
            when "array"
              value.is_a?(Array)
            when "null"
              value.nil?
            when "string"
              value.is_a?(String)
            when "integer"
              value.is_a?(Integer)
            when "number"
              value.is_a?(Numeric)
            when "boolean"
              [true, false].include?(value)
            else
              true
            end
          end
        end

        def self.resolve_schema(schema, root_schema)
          reference = schema["$ref"] || schema[:$ref]
          return schema unless reference

          definitions = root_schema["$defs"] || root_schema[:$defs] || {}
          token = URI.decode_uri_component(reference.delete_prefix("#/$defs/"))
          name = token.gsub("~1", "/").gsub("~0", "~")
          definitions[name] || definitions[name.to_sym]
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
          :known_properties?,
          :pending_status?,
          :resolve_schema,
          :retrieval_complete?,
          :schema_matches_shape?,
          :unfinished_function_call?,
          :unfinished_message?,
          :value_ready?
        )
      end
    end
  end
end
