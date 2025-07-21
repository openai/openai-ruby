# typed: strong

module OpenAI
  module Models
    ChatCompletion = Chat::ChatCompletion

    module Chat
      class ChatCompletion < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Chat::ChatCompletion, OpenAI::Internal::AnyHash)
          end

        # A unique identifier for the chat completion.
        sig { returns(String) }
        attr_accessor :id

        # A list of chat completion choices. Can be more than one if `n` is greater
        # than 1.
        sig { returns(T::Array[OpenAI::Chat::ChatCompletion::Choice]) }
        attr_accessor :choices

        # The Unix timestamp (in seconds) of when the chat completion was created.
        sig { returns(Integer) }
        attr_accessor :created

        # The model used for the chat completion.
        sig { returns(String) }
        attr_accessor :model

        # The object type, which is always `chat.completion`.
        sig { returns(Symbol) }
        attr_accessor :object

        # Specifies the processing type used for serving the request.
        #
        # - If set to 'auto', then the request will be processed with the service tier
        #   configured in the Project settings. Unless otherwise configured, the Project
        #   will use 'default'.
        # - If set to 'default', then the request will be processed with the standard
        #   pricing and performance for the selected model.
        # - If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or
        #   'priority', then the request will be processed with the corresponding service
        #   tier. [Contact sales](https://openai.com/contact-sales) to learn more about
        #   Priority processing.
        # - When not set, the default behavior is 'auto'.
        #
        # When the `service_tier` parameter is set, the response body will include the
        # `service_tier` value based on the processing mode actually used to serve the
        # request. This response value may be different from the value set in the
        # parameter.
        sig do
          returns(
            T.nilable(OpenAI::Chat::ChatCompletion::ServiceTier::TaggedSymbol)
          )
        end
        attr_accessor :service_tier

        # This fingerprint represents the backend configuration that the model runs with.
        #
        # Can be used in conjunction with the `seed` request parameter to understand when
        # backend changes have been made that might impact determinism.
        sig { returns(T.nilable(String)) }
        attr_reader :system_fingerprint

        sig { params(system_fingerprint: String).void }
        attr_writer :system_fingerprint

        # Usage statistics for the completion request.
        sig { returns(T.nilable(OpenAI::CompletionUsage)) }
        attr_reader :usage

        sig { params(usage: OpenAI::CompletionUsage::OrHash).void }
        attr_writer :usage

        # Represents a chat completion response returned by model, based on the provided
        # input.
        sig do
          params(
            id: String,
            choices: T::Array[OpenAI::Chat::ChatCompletion::Choice::OrHash],
            created: Integer,
            model: String,
            service_tier:
              T.nilable(OpenAI::Chat::ChatCompletion::ServiceTier::OrSymbol),
            system_fingerprint: String,
            usage: OpenAI::CompletionUsage::OrHash,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A unique identifier for the chat completion.
          id:,
          # A list of chat completion choices. Can be more than one if `n` is greater
          # than 1.
          choices:,
          # The Unix timestamp (in seconds) of when the chat completion was created.
          created:,
          # The model used for the chat completion.
          model:,
          # Specifies the processing type used for serving the request.
          #
          # - If set to 'auto', then the request will be processed with the service tier
          #   configured in the Project settings. Unless otherwise configured, the Project
          #   will use 'default'.
          # - If set to 'default', then the request will be processed with the standard
          #   pricing and performance for the selected model.
          # - If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or
          #   'priority', then the request will be processed with the corresponding service
          #   tier. [Contact sales](https://openai.com/contact-sales) to learn more about
          #   Priority processing.
          # - When not set, the default behavior is 'auto'.
          #
          # When the `service_tier` parameter is set, the response body will include the
          # `service_tier` value based on the processing mode actually used to serve the
          # request. This response value may be different from the value set in the
          # parameter.
          service_tier: nil,
          # This fingerprint represents the backend configuration that the model runs with.
          #
          # Can be used in conjunction with the `seed` request parameter to understand when
          # backend changes have been made that might impact determinism.
          system_fingerprint: nil,
          # Usage statistics for the completion request.
          usage: nil,
          # The object type, which is always `chat.completion`.
          object: :"chat.completion"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              choices: T::Array[OpenAI::Chat::ChatCompletion::Choice],
              created: Integer,
              model: String,
              object: Symbol,
              service_tier:
                T.nilable(
                  OpenAI::Chat::ChatCompletion::ServiceTier::TaggedSymbol
                ),
              system_fingerprint: String,
              usage: OpenAI::CompletionUsage
            }
          )
        end
        def to_hash
        end

        class Choice < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Chat::ChatCompletion::Choice,
                OpenAI::Internal::AnyHash
              )
            end

          # The reason the model stopped generating tokens. This will be `stop` if the model
          # hit a natural stop point or a provided stop sequence, `length` if the maximum
          # number of tokens specified in the request was reached, `content_filter` if
          # content was omitted due to a flag from our content filters, `tool_calls` if the
          # model called a tool, or `function_call` (deprecated) if the model called a
          # function.
          sig do
            returns(
              OpenAI::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol
            )
          end
          attr_accessor :finish_reason

          # The index of the choice in the list of choices.
          sig { returns(Integer) }
          attr_accessor :index

          # Log probability information for the choice.
          sig do
            returns(T.nilable(OpenAI::Chat::ChatCompletion::Choice::Logprobs))
          end
          attr_reader :logprobs

          sig do
            params(
              logprobs:
                T.nilable(
                  OpenAI::Chat::ChatCompletion::Choice::Logprobs::OrHash
                )
            ).void
          end
          attr_writer :logprobs

          # A chat completion message generated by the model.
          sig { returns(OpenAI::Chat::ChatCompletionMessage) }
          attr_reader :message

          sig do
            params(message: OpenAI::Chat::ChatCompletionMessage::OrHash).void
          end
          attr_writer :message

          sig do
            params(
              finish_reason:
                OpenAI::Chat::ChatCompletion::Choice::FinishReason::OrSymbol,
              index: Integer,
              logprobs:
                T.nilable(
                  OpenAI::Chat::ChatCompletion::Choice::Logprobs::OrHash
                ),
              message: OpenAI::Chat::ChatCompletionMessage::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The reason the model stopped generating tokens. This will be `stop` if the model
            # hit a natural stop point or a provided stop sequence, `length` if the maximum
            # number of tokens specified in the request was reached, `content_filter` if
            # content was omitted due to a flag from our content filters, `tool_calls` if the
            # model called a tool, or `function_call` (deprecated) if the model called a
            # function.
            finish_reason:,
            # The index of the choice in the list of choices.
            index:,
            # Log probability information for the choice.
            logprobs:,
            # A chat completion message generated by the model.
            message:
          )
          end

          sig do
            override.returns(
              {
                finish_reason:
                  OpenAI::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol,
                index: Integer,
                logprobs:
                  T.nilable(OpenAI::Chat::ChatCompletion::Choice::Logprobs),
                message: OpenAI::Chat::ChatCompletionMessage
              }
            )
          end
          def to_hash
          end

          # The reason the model stopped generating tokens. This will be `stop` if the model
          # hit a natural stop point or a provided stop sequence, `length` if the maximum
          # number of tokens specified in the request was reached, `content_filter` if
          # content was omitted due to a flag from our content filters, `tool_calls` if the
          # model called a tool, or `function_call` (deprecated) if the model called a
          # function.
          module FinishReason
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Chat::ChatCompletion::Choice::FinishReason
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            STOP =
              T.let(
                :stop,
                OpenAI::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol
              )
            LENGTH =
              T.let(
                :length,
                OpenAI::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol
              )
            TOOL_CALLS =
              T.let(
                :tool_calls,
                OpenAI::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol
              )
            CONTENT_FILTER =
              T.let(
                :content_filter,
                OpenAI::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol
              )
            FUNCTION_CALL =
              T.let(
                :function_call,
                OpenAI::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class Logprobs < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Chat::ChatCompletion::Choice::Logprobs,
                  OpenAI::Internal::AnyHash
                )
              end

            # A list of message content tokens with log probability information.
            sig do
              returns(
                T.nilable(T::Array[OpenAI::Chat::ChatCompletionTokenLogprob])
              )
            end
            attr_accessor :content

            # A list of message refusal tokens with log probability information.
            sig do
              returns(
                T.nilable(T::Array[OpenAI::Chat::ChatCompletionTokenLogprob])
              )
            end
            attr_accessor :refusal

            # Log probability information for the choice.
            sig do
              params(
                content:
                  T.nilable(
                    T::Array[OpenAI::Chat::ChatCompletionTokenLogprob::OrHash]
                  ),
                refusal:
                  T.nilable(
                    T::Array[OpenAI::Chat::ChatCompletionTokenLogprob::OrHash]
                  )
              ).returns(T.attached_class)
            end
            def self.new(
              # A list of message content tokens with log probability information.
              content:,
              # A list of message refusal tokens with log probability information.
              refusal:
            )
            end

            sig do
              override.returns(
                {
                  content:
                    T.nilable(
                      T::Array[OpenAI::Chat::ChatCompletionTokenLogprob]
                    ),
                  refusal:
                    T.nilable(
                      T::Array[OpenAI::Chat::ChatCompletionTokenLogprob]
                    )
                }
              )
            end
            def to_hash
            end
          end
        end

        # Specifies the processing type used for serving the request.
        #
        # - If set to 'auto', then the request will be processed with the service tier
        #   configured in the Project settings. Unless otherwise configured, the Project
        #   will use 'default'.
        # - If set to 'default', then the request will be processed with the standard
        #   pricing and performance for the selected model.
        # - If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or
        #   'priority', then the request will be processed with the corresponding service
        #   tier. [Contact sales](https://openai.com/contact-sales) to learn more about
        #   Priority processing.
        # - When not set, the default behavior is 'auto'.
        #
        # When the `service_tier` parameter is set, the response body will include the
        # `service_tier` value based on the processing mode actually used to serve the
        # request. This response value may be different from the value set in the
        # parameter.
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Chat::ChatCompletion::ServiceTier)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Chat::ChatCompletion::ServiceTier::TaggedSymbol
            )
          DEFAULT =
            T.let(
              :default,
              OpenAI::Chat::ChatCompletion::ServiceTier::TaggedSymbol
            )
          FLEX =
            T.let(
              :flex,
              OpenAI::Chat::ChatCompletion::ServiceTier::TaggedSymbol
            )
          SCALE =
            T.let(
              :scale,
              OpenAI::Chat::ChatCompletion::ServiceTier::TaggedSymbol
            )
          PRIORITY =
            T.let(
              :priority,
              OpenAI::Chat::ChatCompletion::ServiceTier::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Chat::ChatCompletion::ServiceTier::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
