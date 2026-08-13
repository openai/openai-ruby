# frozen_string_literal: true

module OpenAI
  module Helpers
    module StructuredOutput
      # Represents a response from OpenAI's API where the model's output has been structured according to a schema predefined by the user.
      #
      # This class is specifically used when making requests with the `response_format` parameter set to use structured output (e.g., JSON).
      #
      # See {examples/structured_outputs_chat_completions.rb} for a complete example of use
      class BaseModel < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Helpers::StructuredOutput::JsonSchemaConverter

        class << self
          # @return [Hash{Symbol=>Object}]
          def to_json_schema = OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_json_schema(self)

          # @api private
          #
          # @param state [Hash{Symbol=>Object}]
          #
          #   @option state [Hash{Object=>String}] :defs
          #
          #   @option state [Array<String>] :path
          #
          # @return [Hash{Symbol=>Object}]
          def to_json_schema_inner(state:)
            OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.cache_def!(state, type: self) do
              path = state.fetch(:path)
              properties = fields.each_value.to_h do |field|
                api_name, type, nilable, meta = field.fetch_values(:api_name, :type, :nilable, :meta)
                new_state = {**state, path: [*path, ".#{api_name}"]}

                schema = OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_json_schema_inner(
                  type,
                  state: new_state
                )
                schema = OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_nilable(schema) if nilable
                OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.assoc_meta!(
                  schema,
                  meta: meta.except(:api_name)
                )

                [api_name, schema]
              end

              {
                type: "object",
                properties: properties,
                required: properties.keys.map(&:to_s),
                additionalProperties: false
              }
            end
          end
        end

        class << self
          def optional(...)
            message = "`optional` is not supported for structured output APIs, use `#required` with `nil?: true` instead"
            raise RuntimeError.new(message)
          end
        end
      end
    end
  end
end
