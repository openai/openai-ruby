# typed: strong

module OpenAI
  module Resources
    class Completions
      sig do
        params(
          model: T.any(String, Symbol),
          prompt: T.nilable(
            T.any(
              String,
              T::Array[String],
              T::Array[Integer],
              T::Array[T::Array[Integer]]
            )
          ),
          best_of: T.nilable(Integer),
          echo: T.nilable(T::Boolean),
          frequency_penalty: T.nilable(Float),
          logit_bias: T.nilable(T::Hash[Symbol, Integer]),
          logprobs: T.nilable(Integer),
          max_tokens: T.nilable(Integer),
          n: T.nilable(Integer),
          presence_penalty: T.nilable(Float),
          seed: T.nilable(Integer),
          stop: T.nilable(T.any(String, T::Array[String])),
          stream_options: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions),
          suffix: T.nilable(String),
          temperature: T.nilable(Float),
          top_p: T.nilable(Float),
          user: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::Completion)
      end
      def create(
        model:,
        prompt:,
        best_of: nil,
        echo: nil,
        frequency_penalty: nil,
        logit_bias: nil,
        logprobs: nil,
        max_tokens: nil,
        n: nil,
        presence_penalty: nil,
        seed: nil,
        stop: nil,
        stream_options: nil,
        suffix: nil,
        temperature: nil,
        top_p: nil,
        user: nil,
        request_options: {}
      )
      end

      sig do
        params(
          model: T.any(String, Symbol),
          prompt: T.nilable(
            T.any(
              String,
              T::Array[String],
              T::Array[Integer],
              T::Array[T::Array[Integer]]
            )
          ),
          best_of: T.nilable(Integer),
          echo: T.nilable(T::Boolean),
          frequency_penalty: T.nilable(Float),
          logit_bias: T.nilable(T::Hash[Symbol, Integer]),
          logprobs: T.nilable(Integer),
          max_tokens: T.nilable(Integer),
          n: T.nilable(Integer),
          presence_penalty: T.nilable(Float),
          seed: T.nilable(Integer),
          stop: T.nilable(T.any(String, T::Array[String])),
          stream_options: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions),
          suffix: T.nilable(String),
          temperature: T.nilable(Float),
          top_p: T.nilable(Float),
          user: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Stream[OpenAI::Models::Completion])
      end
      def create_streaming(
        model:,
        prompt:,
        best_of: nil,
        echo: nil,
        frequency_penalty: nil,
        logit_bias: nil,
        logprobs: nil,
        max_tokens: nil,
        n: nil,
        presence_penalty: nil,
        seed: nil,
        stop: nil,
        stream_options: nil,
        suffix: nil,
        temperature: nil,
        top_p: nil,
        user: nil,
        request_options: {}
      )
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
