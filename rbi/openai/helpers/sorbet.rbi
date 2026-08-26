# typed: strong

module OpenAI
  module Helpers
    module StructuredOutput
      class SorbetAdapter
        include OpenAI::Internal::Type::Converter
        include OpenAI::Helpers::StructuredOutput::JsonSchemaConverter

        class HydrationError < TypeError
        end

        sig { params(model: T.class_of(T::Struct)).void }
        def initialize(model)
        end

        sig { returns(String) }
        attr_reader :name

        sig { returns(OpenAI::Helpers::StructuredOutput::JsonSchema) }
        def to_json_schema
        end

        # @api private
        sig do
          params(
            state: OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::State
          )
            .returns(OpenAI::Helpers::StructuredOutput::JsonSchema)
        end
        def to_json_schema_inner(state:)
        end

        # @api private
        sig do
          override
            .params(
              value: T.anything,
              state: OpenAI::Internal::Type::Converter::CoerceState
            )
            .returns(T.anything)
        end
        def coerce(value, state:)
        end
      end

      sig do
        params(model: T.class_of(T::Struct))
          .returns(OpenAI::Helpers::StructuredOutput::SorbetAdapter)
      end
      def self.from_sorbet(model)
      end
    end
  end
end
