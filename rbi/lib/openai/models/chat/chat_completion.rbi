# typed: strong

module OpenAI
  module Models
    ChatCompletion = T.type_alias { Chat::ChatCompletion }

    module Chat
      class ChatCompletion < OpenAI::BaseModel
        # A unique identifier for the chat completion.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # A list of chat completion choices. Can be more than one if `n` is greater
        #   than 1.
        sig { returns(T::Array[OpenAI::Models::Chat::ChatCompletion::Choice]) }
        def choices
        end

        sig do
          params(_: T::Array[OpenAI::Models::Chat::ChatCompletion::Choice])
            .returns(T::Array[OpenAI::Models::Chat::ChatCompletion::Choice])
        end
        def choices=(_)
        end

        # The Unix timestamp (in seconds) of when the chat completion was created.
        sig { returns(Integer) }
        def created
        end

        sig { params(_: Integer).returns(Integer) }
        def created=(_)
        end

        # The model used for the chat completion.
        sig { returns(String) }
        def model
        end

        sig { params(_: String).returns(String) }
        def model=(_)
        end

        # The object type, which is always `chat.completion`.
        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        # The service tier used for processing the request.
        sig { returns(T.nilable(Symbol)) }
        def service_tier
        end

        sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
        def service_tier=(_)
        end

        # This fingerprint represents the backend configuration that the model runs with.
        #
        #   Can be used in conjunction with the `seed` request parameter to understand when
        #   backend changes have been made that might impact determinism.
        sig { returns(T.nilable(String)) }
        def system_fingerprint
        end

        sig { params(_: String).returns(String) }
        def system_fingerprint=(_)
        end

        # Usage statistics for the completion request.
        sig { returns(T.nilable(OpenAI::Models::CompletionUsage)) }
        def usage
        end

        sig { params(_: OpenAI::Models::CompletionUsage).returns(OpenAI::Models::CompletionUsage) }
        def usage=(_)
        end

        # Represents a chat completion response returned by model, based on the provided
        #   input.
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
          # The reason the model stopped generating tokens. This will be `stop` if the model
          #   hit a natural stop point or a provided stop sequence, `length` if the maximum
          #   number of tokens specified in the request was reached, `content_filter` if
          #   content was omitted due to a flag from our content filters, `tool_calls` if the
          #   model called a tool, or `function_call` (deprecated) if the model called a
          #   function.
          sig { returns(Symbol) }
          def finish_reason
          end

          sig { params(_: Symbol).returns(Symbol) }
          def finish_reason=(_)
          end

          # The index of the choice in the list of choices.
          sig { returns(Integer) }
          def index
          end

          sig { params(_: Integer).returns(Integer) }
          def index=(_)
          end

          # Log probability information for the choice.
          sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs)) }
          def logprobs
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs))
              .returns(T.nilable(OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs))
          end
          def logprobs=(_)
          end

          # A chat completion message generated by the model.
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

          # The reason the model stopped generating tokens. This will be `stop` if the model
          #   hit a natural stop point or a provided stop sequence, `length` if the maximum
          #   number of tokens specified in the request was reached, `content_filter` if
          #   content was omitted due to a flag from our content filters, `tool_calls` if the
          #   model called a tool, or `function_call` (deprecated) if the model called a
          #   function.
          class FinishReason < OpenAI::Enum
            abstract!

            Value = type_template(:out) { {fixed: Symbol} }

            STOP = :stop
            LENGTH = :length
            TOOL_CALLS = :tool_calls
            CONTENT_FILTER = :content_filter
            FUNCTION_CALL = :function_call
          end

          class Logprobs < OpenAI::BaseModel
            # A list of message content tokens with log probability information.
            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])) }
            def content
            end

            sig do
              params(_: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
                .returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
            end
            def content=(_)
            end

            # A list of message refusal tokens with log probability information.
            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])) }
            def refusal
            end

            sig do
              params(_: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
                .returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]))
            end
            def refusal=(_)
            end

            # Log probability information for the choice.
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

        # The service tier used for processing the request.
        class ServiceTier < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          SCALE = :scale
          DEFAULT = :default
        end
      end
    end
  end
end
