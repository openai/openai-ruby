# typed: strong

module OpenAI
  module Helpers
    module StructuredOutput
      # @api private
      module ResponseParser
        sig do
          params(
            raw: OpenAI::Internal::AnyHash,
            model: T.nilable(OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input),
            tool_models: T::Hash[String, OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input]
          )
            .returns(OpenAI::Internal::AnyHash)
        end
        def self.parse!(raw, model, tool_models)
        end

        sig do
          params(
            raw: OpenAI::Internal::AnyHash,
            model: T.nilable(OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input),
            tool_models: T::Hash[String, OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input]
          )
            .returns(OpenAI::Internal::AnyHash)
        end
        def self.parse_retrieved!(raw, model, tool_models)
        end

        sig do
          params(parsed: OpenAI::Internal::AnyHash)
            .returns(
              [
                T.nilable(OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input),
                T::Hash[String, OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input]
              ]
            )
        end
        def self.get_models(parsed)
        end

        sig do
          params(parsed: OpenAI::Internal::AnyHash)
            .returns(
              [
                T.nilable(OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input),
                T::Hash[String, OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input]
              ]
            )
        end
        def self.get_retrieval_models(parsed)
        end
      end
    end
  end
end
