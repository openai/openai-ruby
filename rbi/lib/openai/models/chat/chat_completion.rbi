# typed: strong

module OpenAI
  module Models
    ChatCompletion = T.type_alias { Chat::ChatCompletion }

    module Chat
      class ChatCompletion < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { returns(T::Array[OpenAI::Models::Chat::ChatCompletion::Choice]) }
        def choices
        end

        sig do
          params(_: T::Array[OpenAI::Models::Chat::ChatCompletion::Choice])
            .returns(T::Array[OpenAI::Models::Chat::ChatCompletion::Choice])
        end
        def choices=(_)
        end

        sig { returns(Integer) }
        def created
        end

        sig { params(_: Integer).returns(Integer) }
        def created=(_)
        end

        sig { returns(String) }
        def model
        end

        sig { params(_: String).returns(String) }
        def model=(_)
        end

        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def service_tier
        end

        sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
        def service_tier=(_)
        end

        sig { returns(T.nilable(String)) }
        def system_fingerprint
        end

        sig { params(_: String).returns(String) }
        def system_fingerprint=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::CompletionUsage)) }
        def usage
        end

        sig { params(_: OpenAI::Models::CompletionUsage).returns(OpenAI::Models::CompletionUsage) }
        def usage=(_)
        end

        sig do
          params(
            id: String,
            choices: T::Array[OpenAI::Models::Chat::ChatCompletion::Choice],
            created: Integer,
            model: String,
            service_tier: T.nilable(Symbol),
            system_fingerprint: String,
            usage: OpenAI::Models::CompletionUsage,
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          id:,
          choices:,
          created:,
          model:,
          service_tier: nil,
          system_fingerprint: nil,
          usage: nil,
          object: :"chat.completion"
        )
        end

        sig do
          override
            .returns(
              {
                id: String,
                choices: T::Array[OpenAI::Models::Chat::ChatCompletion::Choice],
                created: Integer,
                model: String,
                object: Symbol,
                service_tier: T.nilable(Symbol),
                system_fingerprint: String,
                usage: OpenAI::Models::CompletionUsage
              }
            )
        end
        def to_hash
        end

        class Choice < OpenAI::BaseModel
          sig { returns(Symbol) }
          def finish_reason
          end

          sig { params(_: Symbol).returns(Symbol) }
          def finish_reason=(_)
          end

          sig { returns(Integer) }
          def index
          end

          sig { params(_: Integer).returns(Integer) }
          def index=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs)) }
          def logprobs
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs))
              .returns(T.nilable(OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs))
          end
          def logprobs=(_)
          end

          sig { returns(OpenAI::Models::Chat::ChatCompletionMessage) }
          def message
          end

          sig do
            params(_: OpenAI::Models::Chat::ChatCompletionMessage).returns(OpenAI::Models::Chat::ChatCompletionMessage)
          end
          def message=(_)
          end

          sig do
            params(
              finish_reason: Symbol,
              index: Integer,
              logprobs: T.nilable(OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs),
              message: OpenAI::Models::Chat::ChatCompletionMessage
            )
              .returns(T.attached_class)
          end
          def self.new(finish_reason:, index:, logprobs:, message:)
          end

          sig do
            override
              .returns(
                {
                  finish_reason: Symbol,
                  index: Integer,
                  logprobs: T.nilable(OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs),
                  message: OpenAI::Models::Chat::ChatCompletionMessage
                }
              )
          end
          def to_hash
          end

          class FinishReason < OpenAI::Enum
            abstract!

            STOP = :stop
            LENGTH = :length
            TOOL_CALLS = :tool_calls
            CONTENT_FILTER = :content_filter
            FUNCTION_CALL = :function_call

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end

          class Logprobs < OpenAI::BaseModel
            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])) }
            def content
            end

            sig do
              params(_: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
                .returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
            end
            def content=(_)
            end

            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])) }
            def refusal
            end

            sig do
              params(_: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
                .returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
            end
            def refusal=(_)
            end

            sig do
              params(
                content: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]),
                refusal: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])
              )
                .returns(T.attached_class)
            end
            def self.new(content:, refusal:)
            end

            sig do
              override
                .returns(
                  {
                    content: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]),
                    refusal: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])
                  }
                )
            end
            def to_hash
            end
          end
        end

        class ServiceTier < OpenAI::Enum
          abstract!

          SCALE = T.let(:scale, T.nilable(Symbol))
          DEFAULT = T.let(:default, T.nilable(Symbol))

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
