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
              properties = fields.to_h do |name, field|
                type, nilable, meta = field.fetch_values(:type, :nilable, :meta)
                new_state = {**state, path: [*path, ".#{name}"]}

                schema =
                  case type
                  in OpenAI::Helpers::StructuredOutput::JsonSchemaConverter
                    type.to_json_schema_inner(state: new_state)
                  else
                    OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_json_schema_inner(
                      type,
                      state: new_state
                    )
                  end
                schema = OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_nilable(schema) if nilable
                OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.assoc_meta!(schema, meta: meta)

                [name, schema]
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
          # @api private
          def required(name_sym, type_info, spec = {})
            super

            field = known_fields.fetch(name_sym)
            type = field.fetch(:type_fn)
            nilable = field.fetch(:nilable)
            # Preserve the original reader's validation without replacing raw field storage.
            readers = @structured_output_readers ||= Module.new.tap { prepend(_1) }
            readers.define_method(name_sym) do
              value = super()
              target = type.call

              case value
              when nil
                return nil if nilable
              when target
                return value
              when String
                return value.to_sym if target == Symbol
              end

              state = OpenAI::Internal::Type::Converter.new_coerce_state(translate_names: false)
              converted = OpenAI::Internal::Type::Converter.coerce(target, value, state: state)

              case converted
              when target
                return converted if state.fetch(:error).nil? && state.fetch(:exactness).fetch(:no).zero?
              end

              raise OpenAI::Errors::ConversionError.new(
                on: self.class,
                method: name_sym,
                target: target,
                value: value,
                cause: state.fetch(:error)
              )
            end
          end

          def optional(...)
            message = "`optional` is not supported for structured output APIs, use `#required` with `nil?: true` instead"
            raise RuntimeError.new(message)
          end
        end
      end
    end
  end
end
