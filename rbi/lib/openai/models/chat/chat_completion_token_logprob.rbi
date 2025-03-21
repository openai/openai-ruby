# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionTokenLogprob < OpenAI::BaseModel
        # The token.
        sig { returns(String) }
        def token
        end

        sig { params(_: String).returns(String) }
        def token=(_)
        end

        # A list of integers representing the UTF-8 bytes representation of the token.
        #   Useful in instances where characters are represented by multiple tokens and
        #   their byte representations must be combined to generate the correct text
        #   representation. Can be `null` if there is no bytes representation for the token.
        sig { returns(T.nilable(T::Array[Integer])) }
        def bytes
        end

        sig { params(_: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer])) }
        def bytes=(_)
        end

        # The log probability of this token, if it is within the top 20 most likely
        #   tokens. Otherwise, the value `-9999.0` is used to signify that the token is very
        #   unlikely.
        sig { returns(Float) }
        def logprob
        end

        sig { params(_: Float).returns(Float) }
        def logprob=(_)
        end

        # List of the most likely tokens and their log probability, at this token
        #   position. In rare cases, there may be fewer than the number of requested
        #   `top_logprobs` returned.
        sig { returns(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob::TopLogprob]) }
        def top_logprobs
        end

        sig do
          params(_: T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob::TopLogprob])
            .returns(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob::TopLogprob])
        end
        def top_logprobs=(_)
        end

        sig do
          params(
            token: String,
            bytes: T.nilable(T::Array[Integer]),
            logprob: Float,
            top_logprobs: T::Array[T.any(OpenAI::Models::Chat::ChatCompletionTokenLogprob::TopLogprob, OpenAI::Util::AnyHash)]
          )
            .returns(T.attached_class)
        end
        def self.new(token:, bytes:, logprob:, top_logprobs:)
        end

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
        def to_hash
        end

        class TopLogprob < OpenAI::BaseModel
          # The token.
          sig { returns(String) }
          def token
          end

          sig { params(_: String).returns(String) }
          def token=(_)
          end

          # A list of integers representing the UTF-8 bytes representation of the token.
          #   Useful in instances where characters are represented by multiple tokens and
          #   their byte representations must be combined to generate the correct text
          #   representation. Can be `null` if there is no bytes representation for the token.
          sig { returns(T.nilable(T::Array[Integer])) }
          def bytes
          end

          sig { params(_: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer])) }
          def bytes=(_)
          end

          # The log probability of this token, if it is within the top 20 most likely
          #   tokens. Otherwise, the value `-9999.0` is used to signify that the token is very
          #   unlikely.
          sig { returns(Float) }
          def logprob
          end

          sig { params(_: Float).returns(Float) }
          def logprob=(_)
          end

          sig do
            params(
              token: String,
              bytes: T.nilable(T::Array[Integer]),
              logprob: Float
            ).returns(T.attached_class)
          end
          def self.new(token:, bytes:, logprob:)
          end

          sig { override.returns({token: String, bytes: T.nilable(T::Array[Integer]), logprob: Float}) }
          def to_hash
          end
        end
      end
    end

    ChatCompletionTokenLogprob = Chat::ChatCompletionTokenLogprob
  end
end
