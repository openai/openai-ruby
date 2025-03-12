# typed: strong

module OpenAI
  module Models
    ChatCompletionTokenLogprob = T.type_alias { Chat::ChatCompletionTokenLogprob }

    module Chat
      class ChatCompletionTokenLogprob < OpenAI::BaseModel
        sig { returns(String) }
        def token
        end

        sig { params(_: String).returns(String) }
        def token=(_)
        end

        sig { returns(T.nilable(T::Array[Integer])) }
        def bytes
        end

        sig { params(_: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer])) }
        def bytes=(_)
        end

        sig { returns(Float) }
        def logprob
        end

        sig { params(_: Float).returns(Float) }
        def logprob=(_)
        end

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
            top_logprobs: T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob::TopLogprob]
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
          sig { returns(String) }
          def token
          end

          sig { params(_: String).returns(String) }
          def token=(_)
          end

          sig { returns(T.nilable(T::Array[Integer])) }
          def bytes
          end

          sig { params(_: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer])) }
          def bytes=(_)
          end

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
  end
end
