# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # @see OpenAI::Resources::Chat::Completions#create
      #
      # @see OpenAI::Resources::Chat::Completions#stream_raw
      class ChatCompletion < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   A unique identifier for the chat completion.
        #
        #   @return [String]
        required :id, String

        # @!attribute choices
        #   A list of chat completion choices. Can be more than one if `n` is greater
        #   than 1.
        #
        #   @return [Array<OpenAI::Models::Chat::ChatCompletion::Choice>]
        required :choices, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Chat::ChatCompletion::Choice] }

        # @!attribute created
        #   The Unix timestamp (in seconds) of when the chat completion was created.
        #
        #   @return [Integer]
        required :created, Integer

        # @!attribute model
        #   The model used for the chat completion.
        #
        #   @return [String]
        required :model, String

        # @!attribute object
        #   The object type, which is always `chat.completion`.
        #
        #   @return [Symbol, :"chat.completion"]
        required :object, const: :"chat.completion"

        # @!attribute service_tier
        #   Specifies the latency tier to use for processing the request. This parameter is
        #   relevant for customers subscribed to the scale tier service:
        #
        #   - If set to 'auto', and the Project is Scale tier enabled, the system will
        #     utilize scale tier credits until they are exhausted.
        #   - If set to 'auto', and the Project is not Scale tier enabled, the request will
        #     be processed using the default service tier with a lower uptime SLA and no
        #     latency guarentee.
        #   - If set to 'default', the request will be processed using the default service
        #     tier with a lower uptime SLA and no latency guarentee.
        #   - If set to 'flex', the request will be processed with the Flex Processing
        #     service tier.
        #     [Learn more](https://platform.openai.com/docs/guides/flex-processing).
        #   - When not set, the default behavior is 'auto'.
        #
        #   When this parameter is set, the response body will include the `service_tier`
        #   utilized.
        #
        #   @return [Symbol, OpenAI::Models::Chat::ChatCompletion::ServiceTier, nil]
        optional :service_tier, enum: -> { OpenAI::Models::Chat::ChatCompletion::ServiceTier }, nil?: true

        # @!attribute system_fingerprint
        #   This fingerprint represents the backend configuration that the model runs with.
        #
        #   Can be used in conjunction with the `seed` request parameter to understand when
        #   backend changes have been made that might impact determinism.
        #
        #   @return [String, nil]
        optional :system_fingerprint, String

        # @!attribute usage
        #   Usage statistics for the completion request.
        #
        #   @return [OpenAI::Models::CompletionUsage, nil]
        optional :usage, -> { OpenAI::Models::CompletionUsage }

        # @!method initialize(id:, choices:, created:, model:, service_tier: nil, system_fingerprint: nil, usage: nil, object: :"chat.completion")
        #   Represents a chat completion response returned by model, based on the provided
        #   input.
        #
        #   @param id [String]
        #   @param choices [Array<OpenAI::Models::Chat::ChatCompletion::Choice>]
        #   @param created [Integer]
        #   @param model [String]
        #   @param service_tier [Symbol, OpenAI::Models::Chat::ChatCompletion::ServiceTier, nil]
        #   @param system_fingerprint [String]
        #   @param usage [OpenAI::Models::CompletionUsage]
        #   @param object [Symbol, :"chat.completion"]

        class Choice < OpenAI::Internal::Type::BaseModel
          # @!attribute finish_reason
          #   The reason the model stopped generating tokens. This will be `stop` if the model
          #   hit a natural stop point or a provided stop sequence, `length` if the maximum
          #   number of tokens specified in the request was reached, `content_filter` if
          #   content was omitted due to a flag from our content filters, `tool_calls` if the
          #   model called a tool, or `function_call` (deprecated) if the model called a
          #   function.
          #
          #   @return [Symbol, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason]
          required :finish_reason, enum: -> { OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason }

          # @!attribute index
          #   The index of the choice in the list of choices.
          #
          #   @return [Integer]
          required :index, Integer

          # @!attribute logprobs
          #   Log probability information for the choice.
          #
          #   @return [OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs, nil]
          required :logprobs, -> { OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs }, nil?: true

          # @!attribute message
          #   A chat completion message generated by the model.
          #
          #   @return [OpenAI::Models::Chat::ChatCompletionMessage]
          required :message, -> { OpenAI::Models::Chat::ChatCompletionMessage }

          # @!method initialize(finish_reason:, index:, logprobs:, message:)
          #   @param finish_reason [Symbol, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason]
          #   @param index [Integer]
          #   @param logprobs [OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs, nil]
          #   @param message [OpenAI::Models::Chat::ChatCompletionMessage]

          # The reason the model stopped generating tokens. This will be `stop` if the model
          # hit a natural stop point or a provided stop sequence, `length` if the maximum
          # number of tokens specified in the request was reached, `content_filter` if
          # content was omitted due to a flag from our content filters, `tool_calls` if the
          # model called a tool, or `function_call` (deprecated) if the model called a
          # function.
          #
          # @see OpenAI::Models::Chat::ChatCompletion::Choice#finish_reason
          module FinishReason
            extend OpenAI::Internal::Type::Enum

            STOP = :stop
            LENGTH = :length
            TOOL_CALLS = :tool_calls
            CONTENT_FILTER = :content_filter
            FUNCTION_CALL = :function_call

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Chat::ChatCompletion::Choice#logprobs
          class Logprobs < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   A list of message content tokens with log probability information.
            #
            #   @return [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil]
            required :content,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Chat::ChatCompletionTokenLogprob] },
                     nil?: true

            # @!attribute refusal
            #   A list of message refusal tokens with log probability information.
            #
            #   @return [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil]
            required :refusal,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Chat::ChatCompletionTokenLogprob] },
                     nil?: true

            # @!method initialize(content:, refusal:)
            #   Log probability information for the choice.
            #
            #   @param content [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil]
            #   @param refusal [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil]
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
        #
        # @see OpenAI::Models::Chat::ChatCompletion#service_tier
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DEFAULT = :default
          FLEX = :flex

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    ChatCompletion = Chat::ChatCompletion
  end
end
