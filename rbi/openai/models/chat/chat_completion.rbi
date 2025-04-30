# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletion < OpenAI::Internal::Type::BaseModel
        # A unique identifier for the chat completion.
        sig { returns(String) }
        attr_accessor :id

        # A list of chat completion choices. Can be more than one if `n` is greater
        # than 1.
        sig { returns(T::Array[OpenAI::Models::Chat::ChatCompletion::Choice]) }
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

        # Specifies the latency tier to use for processing the request. This parameter is
        # relevant for customers subscribed to the scale tier service:
        #
        # - If set to 'auto', and the Project is Scale tier enabled, the system will
        #   utilize scale tier credits until they are exhausted.
        # - If set to 'auto', and the Project is not Scale tier enabled, the request will
        #   be processed using the default service tier with a lower uptime SLA and no
        #   latency guarentee.
        # - If set to 'default', the request will be processed using the default service
        #   tier with a lower uptime SLA and no latency guarentee.
        # - If set to 'flex', the request will be processed with the Flex Processing
        #   service tier.
        #   [Learn more](https://platform.openai.com/docs/guides/flex-processing).
        # - When not set, the default behavior is 'auto'.
        #
        # When this parameter is set, the response body will include the `service_tier`
        # utilized.
        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletion::ServiceTier::TaggedSymbol)) }
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
        sig { returns(T.nilable(OpenAI::Models::CompletionUsage)) }
        attr_reader :usage

        sig { params(usage: T.any(OpenAI::Models::CompletionUsage, OpenAI::Internal::AnyHash)).void }
        attr_writer :usage

        # Represents a chat completion response returned by model, based on the provided
        # input.
        sig do
          params(
            id: String,
            choices: T::Array[T.any(OpenAI::Models::Chat::ChatCompletion::Choice, OpenAI::Internal::AnyHash)],
            created: Integer,
            model: String,
            service_tier: T.nilable(OpenAI::Models::Chat::ChatCompletion::ServiceTier::OrSymbol),
            system_fingerprint: String,
            usage: T.any(OpenAI::Models::CompletionUsage, OpenAI::Internal::AnyHash),
            object: Symbol
          )
            .returns(T.attached_class)
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
          # Specifies the latency tier to use for processing the request. This parameter is
          # relevant for customers subscribed to the scale tier service:
          #
          # - If set to 'auto', and the Project is Scale tier enabled, the system will
          #   utilize scale tier credits until they are exhausted.
          # - If set to 'auto', and the Project is not Scale tier enabled, the request will
          #   be processed using the default service tier with a lower uptime SLA and no
          #   latency guarentee.
          # - If set to 'default', the request will be processed using the default service
          #   tier with a lower uptime SLA and no latency guarentee.
          # - If set to 'flex', the request will be processed with the Flex Processing
          #   service tier.
          #   [Learn more](https://platform.openai.com/docs/guides/flex-processing).
          # - When not set, the default behavior is 'auto'.
          #
          # When this parameter is set, the response body will include the `service_tier`
          # utilized.
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
        ); end
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
        def to_hash; end

        class Choice < OpenAI::Internal::Type::BaseModel
          # The reason the model stopped generating tokens. This will be `stop` if the model
          # hit a natural stop point or a provided stop sequence, `length` if the maximum
          # number of tokens specified in the request was reached, `content_filter` if
          # content was omitted due to a flag from our content filters, `tool_calls` if the
          # model called a tool, or `function_call` (deprecated) if the model called a
          # function.
          sig { returns(OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol) }
          attr_accessor :finish_reason

          # The index of the choice in the list of choices.
          sig { returns(Integer) }
          attr_accessor :index

          # Log probability information for the choice.
          sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs)) }
          attr_reader :logprobs

          sig do
            params(
              logprobs: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs, OpenAI::Internal::AnyHash))
            )
              .void
          end
          attr_writer :logprobs

          # A chat completion message generated by the model.
          sig { returns(OpenAI::Models::Chat::ChatCompletionMessage) }
          attr_reader :message

          sig { params(message: T.any(OpenAI::Models::Chat::ChatCompletionMessage, OpenAI::Internal::AnyHash)).void }
          attr_writer :message

          sig do
            params(
              finish_reason: OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::OrSymbol,
              index: Integer,
              logprobs: T.nilable(T.any(OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs, OpenAI::Internal::AnyHash)),
              message: T.any(OpenAI::Models::Chat::ChatCompletionMessage, OpenAI::Internal::AnyHash)
            )
              .returns(T.attached_class)
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
          ); end
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
          def to_hash; end

          # The reason the model stopped generating tokens. This will be `stop` if the model
          # hit a natural stop point or a provided stop sequence, `length` if the maximum
          # number of tokens specified in the request was reached, `content_filter` if
          # content was omitted due to a flag from our content filters, `tool_calls` if the
          # model called a tool, or `function_call` (deprecated) if the model called a
          # function.
          module FinishReason
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            STOP = T.let(:stop, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)
            LENGTH = T.let(:length, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)
            TOOL_CALLS = T.let(:tool_calls, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)
            CONTENT_FILTER =
              T.let(:content_filter, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)
            FUNCTION_CALL =
              T.let(:function_call, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason::TaggedSymbol]) }
            def self.values; end
          end

          class Logprobs < OpenAI::Internal::Type::BaseModel
            # A list of message content tokens with log probability information.
            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])) }
            attr_accessor :content

            # A list of message refusal tokens with log probability information.
            sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])) }
            attr_accessor :refusal

            # Log probability information for the choice.
            sig do
              params(
                content: T.nilable(T::Array[T.any(OpenAI::Models::Chat::ChatCompletionTokenLogprob, OpenAI::Internal::AnyHash)]),
                refusal: T.nilable(T::Array[T.any(OpenAI::Models::Chat::ChatCompletionTokenLogprob, OpenAI::Internal::AnyHash)])
              )
                .returns(T.attached_class)
            end
            def self.new(
              # A list of message content tokens with log probability information.
              content:,
              # A list of message refusal tokens with log probability information.
              refusal:
            ); end
            sig do
              override
                .returns(
                  {
                    content: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob]),
                    refusal: T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTokenLogprob])
                  }
                )
            end
            def to_hash; end
          end
        end

        # Specifies the latency tier to use for processing the request. This parameter is
        # relevant for customers subscribed to the scale tier service:
        #
        # - If set to 'auto', and the Project is Scale tier enabled, the system will
        #   utilize scale tier credits until they are exhausted.
        # - If set to 'auto', and the Project is not Scale tier enabled, the request will
        #   be processed using the default service tier with a lower uptime SLA and no
        #   latency guarentee.
        # - If set to 'default', the request will be processed using the default service
        #   tier with a lower uptime SLA and no latency guarentee.
        # - If set to 'flex', the request will be processed with the Flex Processing
        #   service tier.
        #   [Learn more](https://platform.openai.com/docs/guides/flex-processing).
        # - When not set, the default behavior is 'auto'.
        #
        # When this parameter is set, the response body will include the `service_tier`
        # utilized.
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletion::ServiceTier) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO = T.let(:auto, OpenAI::Models::Chat::ChatCompletion::ServiceTier::TaggedSymbol)
          DEFAULT = T.let(:default, OpenAI::Models::Chat::ChatCompletion::ServiceTier::TaggedSymbol)
          FLEX = T.let(:flex, OpenAI::Models::Chat::ChatCompletion::ServiceTier::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletion::ServiceTier::TaggedSymbol]) }
          def self.values; end
        end
      end
    end

    ChatCompletion = Chat::ChatCompletion
  end
end
