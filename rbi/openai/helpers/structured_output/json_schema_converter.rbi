# typed: strong

module OpenAI
  module Helpers
    module StructuredOutput
      JsonSchema = T.type_alias { OpenAI::Internal::AnyHash }

      # To customize the JSON schema conversion for a type, implement the `JsonSchemaConverter` interface.
      module JsonSchemaConverter
        POINTER = T.let(Object.new.freeze, T.anything)
        COUNTER = T.let(Object.new.freeze, T.anything)

        Input =
          T.type_alias do
            T.any(
              OpenAI::Helpers::StructuredOutput::JsonSchemaConverter,
              T::Class[T.anything]
            )
          end
        State =
          T.type_alias do
            { defs: T::Hash[Object, String], path: T::Array[String] }
          end

        # The exact JSON schema produced is subject to improvement between minor release versions.
        sig do
          params(
            state: OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::State
          ).returns(OpenAI::Helpers::StructuredOutput::JsonSchema)
        end
        def to_json_schema_inner(state:)
        end

        # Internal helpers methods.
        class << self
          # @api private
          sig do
            params(
              schema: OpenAI::Helpers::StructuredOutput::JsonSchema
            ).returns(OpenAI::Helpers::StructuredOutput::JsonSchema)
          end
          def to_nilable(schema)
          end

          # @api private
          sig do
            params(
              state:
                OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::State,
              type:
                OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input,
              blk: T.proc.returns(OpenAI::Helpers::StructuredOutput::JsonSchema)
            ).void
          end
          def cache_def!(state, type:, &blk)
          end

          # @api private
          sig do
            params(
              type:
                OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input
            ).returns(OpenAI::Helpers::StructuredOutput::JsonSchema)
          end
          def to_json_schema(type)
          end

          # @api private
          sig do
            params(
              type:
                OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input,
              state:
                OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::State
            ).returns(OpenAI::Helpers::StructuredOutput::JsonSchema)
          end
          def to_json_schema_inner(type, state:)
          end
        end
      end
    end
  end
end
