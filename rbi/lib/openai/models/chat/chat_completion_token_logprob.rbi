# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionTokenLogprob < OpenAI::Internal::Type::BaseModel
        # The token.
        sig { returns(String) }
        attr_accessor :token

        # A list of integers representing the UTF-8 bytes representation of the token.
        # Useful in instances where characters are represented by multiple tokens and
        # their byte representations must be combined to generate the correct text
        # representation. Can be `null` if there is no bytes representation for the token.
        sig { returns(T.nilable(T::Array[Integer])) }
        attr_accessor :bytes

        # The log probability of this token, if it is within the top 20 most likely
        # tokens. Otherwise, the value `-9999.0` is used to signify that the token is very
        # unlikely.
        sig { returns(Float) }
        attr_accessor :logprob

        # List of the most likely tokens and their log probability, at this token
        # position. In rare cases, there may be fewer than the number of requested
        # `top_logprobs` returned.
        sig { returns(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob::TopLogprob]) }
        attr_accessor :top_logprobs

        sig do
          params(
            token: String,
            bytes: T.nilable(T::Array[Integer]),
            logprob: Float,
            top_logprobs: T::Array[T.any(OpenAI::Models::Chat::ChatCompletionTokenLogprob::TopLogprob, OpenAI::Internal::AnyHash)]
          )
            .returns(T.attached_class)
        end
        def self.new(token:, bytes:, logprob:, top_logprobs:); end

        sig do
          override
            .returns(
              {
                token: String,
                bytes: T.nilable(T::Array[Integer]),
                logprob: Float,
                top_logprobs: T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob::TopLogprob]
              }
            )
        end
        def to_hash; end

        class TopLogprob < OpenAI::Internal::Type::BaseModel
          # The token.
          sig { returns(String) }
          attr_accessor :token

          # A list of integers representing the UTF-8 bytes representation of the token.
          # Useful in instances where characters are represented by multiple tokens and
          # their byte representations must be combined to generate the correct text
          # representation. Can be `null` if there is no bytes representation for the token.
          sig { returns(T.nilable(T::Array[Integer])) }
          attr_accessor :bytes

          # The log probability of this token, if it is within the top 20 most likely
          # tokens. Otherwise, the value `-9999.0` is used to signify that the token is very
          # unlikely.
          sig { returns(Float) }
          attr_accessor :logprob

          sig do
            params(
              token: String,
              bytes: T.nilable(T::Array[Integer]),
              logprob: Float
            ).returns(T.attached_class)
          end
          def self.new(token:, bytes:, logprob:); end

          sig { override.returns({token: String, bytes: T.nilable(T::Array[Integer]), logprob: Float}) }
          def to_hash; end
        end
      end
    end

    ChatCompletionTokenLogprob = Chat::ChatCompletionTokenLogprob
  end
end
