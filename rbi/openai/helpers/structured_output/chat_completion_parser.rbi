# typed: strong

module OpenAI
  module Helpers
    module StructuredOutput
      # @api private
      module ChatCompletionParser
        sig do
          params(
            model: T.nilable(OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input),
            tool_models: T::Hash[String, OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input]
          )
            .returns(T.proc.params(raw: OpenAI::Internal::AnyHash).returns(OpenAI::Internal::AnyHash))
        end
        def self.build_unwrap(model, tool_models)
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
          params(
            tools: T.nilable(T::Array[OpenAI::Internal::AnyHash]),
            tool_models: T::Hash[String, OpenAI::Helpers::StructuredOutput::JsonSchemaConverter::Input]
          )
            .returns(T::Array[OpenAI::Internal::AnyHash])
        end
        def self.build_tools(tools, tool_models)
        end
      end
    end
  end
end
