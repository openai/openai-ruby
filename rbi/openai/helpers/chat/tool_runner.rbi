# typed: strong

module OpenAI
  module Helpers
    module Chat
      class ToolRunner
        Handler = T.type_alias { T.proc.params(arguments: T::Hash[String, T.untyped]).returns(T.untyped) }

        class Error < StandardError
        end

        class MaxRoundsError < Error
        end

        # @api private
        sig do
          params(
            completions: OpenAI::Resources::Chat::Completions,
            params: T::Hash[Symbol, T.untyped],
            tool_handlers: T::Hash[String, Handler],
            max_rounds: Integer
          )
            .void
        end
        def initialize(completions:, params:, tool_handlers:, max_rounds:)
        end

        # @api private
        sig { returns(OpenAI::Chat::ChatCompletion) }
        def run
        end
      end
    end
  end

  module Resources
    class Chat
      class Completions
        sig do
          params(
            model: T.any(String, OpenAI::ChatModel::OrSymbol),
            messages: T::Array[
              T.any(
                OpenAI::Chat::ChatCompletionDeveloperMessageParam::OrHash,
                OpenAI::Chat::ChatCompletionSystemMessageParam::OrHash,
                OpenAI::Chat::ChatCompletionUserMessageParam::OrHash,
                OpenAI::Chat::ChatCompletionAssistantMessageParam::OrHash,
                OpenAI::Chat::ChatCompletionToolMessageParam::OrHash,
                OpenAI::Chat::ChatCompletionFunctionMessageParam::OrHash
              )
            ],
            tools: T::Array[
              T.any(
                OpenAI::StructuredOutput::JsonSchemaConverter,
                OpenAI::Chat::ChatCompletionFunctionTool::OrHash
              )
            ],
            tool_handlers: T::Hash[String, OpenAI::Helpers::Chat::ToolRunner::Handler],
            max_rounds: Integer,
            params: T.untyped
          )
            .returns(OpenAI::Chat::ChatCompletion)
        end
        def run_tools(model:, messages:, tools:, tool_handlers:, max_rounds: 10, **params)
        end
      end
    end
  end
end
