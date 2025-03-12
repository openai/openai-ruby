# typed: strong

module OpenAI
  module Resources
    class Chat
      class Completions
        sig { returns(OpenAI::Resources::Chat::Completions::Messages) }
        def messages
        end

        sig do
          params(
            messages: T::Array[
            T.any(
              OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
              OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
              OpenAI::Models::Chat::ChatCompletionUserMessageParam,
              OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
              OpenAI::Models::Chat::ChatCompletionToolMessageParam,
              OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
            )
            ],
            model: T.any(String, Symbol),
            audio: T.nilable(OpenAI::Models::Chat::ChatCompletionAudioParam),
            frequency_penalty: T.nilable(Float),
            function_call: T.any(Symbol, OpenAI::Models::Chat::ChatCompletionFunctionCallOption),
            functions: T::Array[OpenAI::Models::Chat::CompletionCreateParams::Function],
            logit_bias: T.nilable(T::Hash[Symbol, Integer]),
            logprobs: T.nilable(T::Boolean),
            max_completion_tokens: T.nilable(Integer),
            max_tokens: T.nilable(Integer),
            metadata: T.nilable(OpenAI::Models::Metadata),
            modalities: T.nilable(T::Array[Symbol]),
            n: T.nilable(Integer),
            parallel_tool_calls: T::Boolean,
            prediction: T.nilable(OpenAI::Models::Chat::ChatCompletionPredictionContent),
            presence_penalty: T.nilable(Float),
            reasoning_effort: T.nilable(Symbol),
            response_format: T.any(
              OpenAI::Models::ResponseFormatText,
              OpenAI::Models::ResponseFormatJSONSchema,
              OpenAI::Models::ResponseFormatJSONObject
            ),
            seed: T.nilable(Integer),
            service_tier: T.nilable(Symbol),
            stop: T.nilable(T.any(String, T::Array[String])),
            store: T.nilable(T::Boolean),
            stream_options: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions),
            temperature: T.nilable(Float),
            tool_choice: T.any(Symbol, OpenAI::Models::Chat::ChatCompletionNamedToolChoice),
            tools: T::Array[OpenAI::Models::Chat::ChatCompletionTool],
            top_logprobs: T.nilable(Integer),
            top_p: T.nilable(Float),
            user: String,
            web_search_options: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Chat::ChatCompletion)
        end
        def create(
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
          n: nil,
          parallel_tool_calls: nil,
          prediction: nil,
          presence_penalty: nil,
          reasoning_effort: nil,
          response_format: nil,
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
          web_search_options: nil,
          request_options: {}
        )
        end

        sig do
          params(
            messages: T::Array[
            T.any(
              OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
              OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
              OpenAI::Models::Chat::ChatCompletionUserMessageParam,
              OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
              OpenAI::Models::Chat::ChatCompletionToolMessageParam,
              OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
            )
            ],
            model: T.any(String, Symbol),
            audio: T.nilable(OpenAI::Models::Chat::ChatCompletionAudioParam),
            frequency_penalty: T.nilable(Float),
            function_call: T.any(Symbol, OpenAI::Models::Chat::ChatCompletionFunctionCallOption),
            functions: T::Array[OpenAI::Models::Chat::CompletionCreateParams::Function],
            logit_bias: T.nilable(T::Hash[Symbol, Integer]),
            logprobs: T.nilable(T::Boolean),
            max_completion_tokens: T.nilable(Integer),
            max_tokens: T.nilable(Integer),
            metadata: T.nilable(OpenAI::Models::Metadata),
            modalities: T.nilable(T::Array[Symbol]),
            n: T.nilable(Integer),
            parallel_tool_calls: T::Boolean,
            prediction: T.nilable(OpenAI::Models::Chat::ChatCompletionPredictionContent),
            presence_penalty: T.nilable(Float),
            reasoning_effort: T.nilable(Symbol),
            response_format: T.any(
              OpenAI::Models::ResponseFormatText,
              OpenAI::Models::ResponseFormatJSONSchema,
              OpenAI::Models::ResponseFormatJSONObject
            ),
            seed: T.nilable(Integer),
            service_tier: T.nilable(Symbol),
            stop: T.nilable(T.any(String, T::Array[String])),
            store: T.nilable(T::Boolean),
            stream_options: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions),
            temperature: T.nilable(Float),
            tool_choice: T.any(Symbol, OpenAI::Models::Chat::ChatCompletionNamedToolChoice),
            tools: T::Array[OpenAI::Models::Chat::ChatCompletionTool],
            top_logprobs: T.nilable(Integer),
            top_p: T.nilable(Float),
            user: String,
            web_search_options: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Stream[OpenAI::Models::Chat::ChatCompletionChunk])
        end
        def create_streaming(
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
          n: nil,
          parallel_tool_calls: nil,
          prediction: nil,
          presence_penalty: nil,
          reasoning_effort: nil,
          response_format: nil,
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
          web_search_options: nil,
          request_options: {}
        )
        end

        sig do
          params(
            completion_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Chat::ChatCompletion)
        end
        def retrieve(completion_id, request_options: {})
        end

        sig do
          params(
            completion_id: String,
            metadata: T.nilable(OpenAI::Models::Metadata),
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Chat::ChatCompletion)
        end
        def update(completion_id, metadata:, request_options: {})
        end

        sig do
          params(
            after: String,
            limit: Integer,
            metadata: T.nilable(OpenAI::Models::Metadata),
            model: String,
            order: Symbol,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::CursorPage[OpenAI::Models::Chat::ChatCompletion])
        end
        def list(after: nil, limit: nil, metadata: nil, model: nil, order: nil, request_options: {})
        end

        sig do
          params(
            completion_id: String,
            request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
          )
            .returns(OpenAI::Models::Chat::ChatCompletionDeleted)
        end
        def delete(completion_id, request_options: {})
        end

        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end
    end
  end
end
