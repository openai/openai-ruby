# typed: strong

module OpenAI
  module Models
    module Chat
      class ParsedChoice < OpenAI::Models::Chat::ChatCompletion::Choice
        sig { returns(T.nilable(OpenAI::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)) }
        attr_accessor :finish_reason
      end

      class ParsedChatCompletion < OpenAI::Models::Chat::ChatCompletion
        sig { returns(T::Array[OpenAI::Models::Chat::ParsedChoice]) }
        attr_accessor :choices
      end
    end
  end

  module Helpers
    module Streaming
      class ChatCompletionStream
        include OpenAI::Internal::Type::BaseStream

        ChatCompletionStreamEvent = T.type_alias do
          T.any(
            ChatChunkEvent,
            ChatContentDeltaEvent,
            ChatContentDoneEvent,
            ChatRefusalDeltaEvent,
            ChatRefusalDoneEvent,
            ChatFunctionToolCallArgumentsDeltaEvent,
            ChatFunctionToolCallArgumentsDoneEvent,
            ChatLogprobsContentDeltaEvent,
            ChatLogprobsContentDoneEvent,
            ChatLogprobsRefusalDeltaEvent,
            ChatLogprobsRefusalDoneEvent
          )
        end

        Message = type_member { {fixed: ChatCompletionStreamEvent} }
        Elem = type_member { {fixed: ChatCompletionStreamEvent} }

        sig { returns(OpenAI::Chat::ChatCompletion) }
        def get_final_completion
        end

        sig { returns(String) }
        def get_output_text
        end

        sig { returns(T.self_type) }
        def until_done
        end

        sig { returns(T.nilable(OpenAI::Chat::ParsedChatCompletion)) }
        def current_completion_snapshot
        end

        sig { returns(T::Enumerator[String]) }
        def text
        end
      end
    end
  end

  module Resources
    class Chat
      class Completions
        sig do
          params(
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
            model: T.any(String, OpenAI::ChatModel::OrSymbol),
            audio: T.nilable(OpenAI::Chat::ChatCompletionAudioParam::OrHash),
            frequency_penalty: T.nilable(Float),
            function_call: T.any(
              OpenAI::Chat::CompletionCreateParams::FunctionCall::FunctionCallMode::OrSymbol,
              OpenAI::Chat::ChatCompletionFunctionCallOption::OrHash
            ),
            functions: T::Array[OpenAI::Chat::CompletionCreateParams::Function::OrHash],
            logit_bias: T.nilable(T::Hash[Symbol, Integer]),
            logprobs: T.nilable(T::Boolean),
            max_completion_tokens: T.nilable(Integer),
            max_tokens: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            modalities: T.nilable(T::Array[OpenAI::Chat::CompletionCreateParams::Modality::OrSymbol]),
            moderation: T.nilable(OpenAI::Chat::CompletionCreateParams::Moderation::OrHash),
            n: T.nilable(Integer),
            parallel_tool_calls: T::Boolean,
            prediction: T.nilable(OpenAI::Chat::ChatCompletionPredictionContent::OrHash),
            presence_penalty: T.nilable(Float),
            prompt_cache_key: T.nilable(String),
            prompt_cache_options: OpenAI::Chat::CompletionCreateParams::PromptCacheOptions::OrHash,
            prompt_cache_retention: T.nilable(OpenAI::Chat::CompletionCreateParams::PromptCacheRetention::OrSymbol),
            reasoning_effort: T.nilable(OpenAI::ReasoningEffort::OrSymbol),
            response_format: T.any(
              OpenAI::ResponseFormatText::OrHash,
              OpenAI::ResponseFormatJSONSchema::OrHash,
              OpenAI::StructuredOutput::JsonSchemaConverter,
              OpenAI::ResponseFormatJSONObject::OrHash
            ),
            safety_identifier: T.nilable(String),
            seed: T.nilable(Integer),
            service_tier: T.nilable(OpenAI::Chat::CompletionCreateParams::ServiceTier::OrSymbol),
            stop: T.nilable(OpenAI::Chat::CompletionCreateParams::Stop::Variants),
            store: T.nilable(T::Boolean),
            stream_options: T.nilable(OpenAI::Chat::ChatCompletionStreamOptions::OrHash),
            temperature: T.nilable(Float),
            tool_choice: T.any(
              OpenAI::Chat::ChatCompletionToolChoiceOption::Auto::OrSymbol,
              OpenAI::Chat::ChatCompletionAllowedToolChoice::OrHash,
              OpenAI::Chat::ChatCompletionNamedToolChoice::OrHash,
              OpenAI::Chat::ChatCompletionNamedToolChoiceCustom::OrHash
            ),
            tools: T::Array[
              T.any(
                OpenAI::StructuredOutput::JsonSchemaConverter,
                OpenAI::Chat::ChatCompletionFunctionTool::OrHash,
                OpenAI::Chat::ChatCompletionCustomTool::OrHash
              )
            ],
            top_logprobs: T.nilable(Integer),
            top_p: T.nilable(Float),
            user: String,
            verbosity: T.nilable(OpenAI::Chat::CompletionCreateParams::Verbosity::OrSymbol),
            web_search_options: OpenAI::Chat::CompletionCreateParams::WebSearchOptions::OrHash,
            stream: T.noreturn,
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::Streaming::ChatCompletionStream)
        end
        def stream(
          messages:,
          model:,
          audio: nil,
          frequency_penalty: nil,
          function_call: nil,
          functions: nil,
          logit_bias: nil,
          logprobs: nil,
          max_completion_tokens: nil,
          max_tokens: nil,
          metadata: nil,
          modalities: nil,
          moderation: nil,
          n: nil,
          parallel_tool_calls: nil,
          prediction: nil,
          presence_penalty: nil,
          prompt_cache_key: nil,
          prompt_cache_options: nil,
          prompt_cache_retention: nil,
          reasoning_effort: nil,
          response_format: nil,
          safety_identifier: nil,
          seed: nil,
          service_tier: nil,
          stop: nil,
          store: nil,
          stream_options: nil,
          temperature: nil,
          tool_choice: nil,
          tools: nil,
          top_logprobs: nil,
          top_p: nil,
          user: nil,
          verbosity: nil,
          web_search_options: nil,
          stream: nil,
          request_options: {}
        )
        end
      end
    end
  end
end
