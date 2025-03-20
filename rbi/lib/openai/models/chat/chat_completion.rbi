# typed: strong

module OpenAI
  module Models
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
        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletion::ServiceTier::TaggedSymbol)) }
        def service_tier
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Chat::ChatCompletion::ServiceTier::TaggedSymbol))
            .returns(T.nilable(OpenAI::Models::Chat::ChatCompletion::ServiceTier::TaggedSymbol))
        end
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

        sig do
          params(_: T.any(OpenAI::Models::CompletionUsage, OpenAI::Util::AnyHash))
            .returns(T.any(OpenAI::Models::CompletionUsage, OpenAI::Util::AnyHash))
        end
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
            service_tier: T.nilable(OpenAI::Models::Chat::ChatCompletion::ServiceTier::TaggedSymbol),
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
                service_tier: T.nilable(OpenAI::Models::Chat::ChatCompletion::ServiceTier::TaggedSymbol),
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
          sig { returns(OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol) }
          def finish_reason
          end

          sig do
            params(_: OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)
              .returns(OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)
          end
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
            params(_: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs, OpenAI::Util::AnyHash)))
              .returns(T.nilable(T.any(OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs, OpenAI::Util::AnyHash)))
          end
          def logprobs=(_)
          end

          # A chat completion message generated by the model.
          sig { returns(OpenAI::Models::Chat::ChatCompletionMessage) }
          def message
          end

          sig do
            params(_: T.any(OpenAI::Models::Chat::ChatCompletionMessage, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Chat::ChatCompletionMessage, OpenAI::Util::AnyHash))
          end
          def message=(_)
          end

          sig do
            params(
              finish_reason: OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol,
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
                  finish_reason: OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol,
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
          module FinishReason
            extend OpenAI::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason) }
            OrSymbol =
              T.type_alias { T.any(Symbol, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol) }

            STOP = T.let(:stop, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)
            LENGTH = T.let(:length, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)
            TOOL_CALLS = T.let(:tool_calls, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)
            CONTENT_FILTER =
              T.let(:content_filter, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)
            FUNCTION_CALL =
              T.let(:function_call, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)
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
        module ServiceTier
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletion::ServiceTier) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Chat::ChatCompletion::ServiceTier::TaggedSymbol) }

          SCALE = T.let(:scale, OpenAI::Models::Chat::ChatCompletion::ServiceTier::TaggedSymbol)
          DEFAULT = T.let(:default, OpenAI::Models::Chat::ChatCompletion::ServiceTier::TaggedSymbol)
        end
      end
    end

    ChatCompletion = Chat::ChatCompletion
  end
end
