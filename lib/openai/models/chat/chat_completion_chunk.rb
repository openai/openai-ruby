# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionChunk < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   A unique identifier for the chat completion. Each chunk has the same ID.
        #
        #   @return [String]
        required :id, String

        # @!attribute choices
        #   A list of chat completion choices. Can contain more than one elements if `n` is
        #   greater than 1. Can also be empty for the last chunk if you set
        #   `stream_options: {"include_usage": true}`.
        #
        #   @return [Array<OpenAI::Models::Chat::ChatCompletionChunk::Choice>]
        required :choices,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Chat::ChatCompletionChunk::Choice] }

        # @!attribute created
        #   The Unix timestamp (in seconds) of when the chat completion was created. Each
        #   chunk has the same timestamp.
        #
        #   @return [Integer]
        required :created, Integer

        # @!attribute model
        #   The model to generate the completion.
        #
        #   @return [String]
        required :model, String

        # @!attribute object
        #   The object type, which is always `chat.completion.chunk`.
        #
        #   @return [Symbol, :"chat.completion.chunk"]
        required :object, const: :"chat.completion.chunk"

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
        #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier, nil]
        optional :service_tier, enum: -> { OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier }, nil?: true

        # @!attribute [r] system_fingerprint
        #   This fingerprint represents the backend configuration that the model runs with.
        #   Can be used in conjunction with the `seed` request parameter to understand when
        #   backend changes have been made that might impact determinism.
        #
        #   @return [String, nil]
        optional :system_fingerprint, String

        # @!parse
        #   # @return [String]
        #   attr_writer :system_fingerprint

        # @!attribute usage
        #   An optional field that will only be present when you set
        #   `stream_options: {"include_usage": true}` in your request. When present, it
        #   contains a null value **except for the last chunk** which contains the token
        #   usage statistics for the entire request.
        #
        #   **NOTE:** If the stream is interrupted or cancelled, you may not receive the
        #   final usage chunk which contains the total token usage for the request.
        #
        #   @return [OpenAI::Models::CompletionUsage, nil]
        optional :usage, -> { OpenAI::Models::CompletionUsage }, nil?: true

        # @!parse
        #   # Represents a streamed chunk of a chat completion response returned by the model,
        #   # based on the provided input.
        #   # [Learn more](https://platform.openai.com/docs/guides/streaming-responses).
        #   #
        #   # @param id [String]
        #   # @param choices [Array<OpenAI::Models::Chat::ChatCompletionChunk::Choice>]
        #   # @param created [Integer]
        #   # @param model [String]
        #   # @param service_tier [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier, nil]
        #   # @param system_fingerprint [String]
        #   # @param usage [OpenAI::Models::CompletionUsage, nil]
        #   # @param object [Symbol, :"chat.completion.chunk"]
        #   #
        #   def initialize(
        #     id:,
        #     choices:,
        #     created:,
        #     model:,
        #     service_tier: nil,
        #     system_fingerprint: nil,
        #     usage: nil,
        #     object: :"chat.completion.chunk",
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        class Choice < OpenAI::Internal::Type::BaseModel
          # @!attribute delta
          #   A chat completion delta generated by streamed model responses.
          #
          #   @return [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta]
          required :delta, -> { OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta }

          # @!attribute finish_reason
          #   The reason the model stopped generating tokens. This will be `stop` if the model
          #   hit a natural stop point or a provided stop sequence, `length` if the maximum
          #   number of tokens specified in the request was reached, `content_filter` if
          #   content was omitted due to a flag from our content filters, `tool_calls` if the
          #   model called a tool, or `function_call` (deprecated) if the model called a
          #   function.
          #
          #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason, nil]
          required :finish_reason,
                   enum: -> { OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason },
                   nil?: true

          # @!attribute index
          #   The index of the choice in the list of choices.
          #
          #   @return [Integer]
          required :index, Integer

          # @!attribute logprobs
          #   Log probability information for the choice.
          #
          #   @return [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs, nil]
          optional :logprobs, -> { OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs }, nil?: true

          # @!parse
          #   # @param delta [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta]
          #   # @param finish_reason [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason, nil]
          #   # @param index [Integer]
          #   # @param logprobs [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs, nil]
          #   #
          #   def initialize(delta:, finish_reason:, index:, logprobs: nil, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # @see OpenAI::Models::Chat::ChatCompletionChunk::Choice#delta
          class Delta < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   The contents of the chunk message.
            #
            #   @return [String, nil]
            optional :content, String, nil?: true

            # @!attribute [r] function_call
            #   Deprecated and replaced by `tool_calls`. The name and arguments of a function
            #   that should be called, as generated by the model.
            #
            #   @return [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall, nil]
            optional :function_call, -> { OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall }

            # @!parse
            #   # @return [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall]
            #   attr_writer :function_call

            # @!attribute refusal
            #   The refusal message generated by the model.
            #
            #   @return [String, nil]
            optional :refusal, String, nil?: true

            # @!attribute [r] role
            #   The role of the author of this message.
            #
            #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role, nil]
            optional :role, enum: -> { OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role }

            # @!parse
            #   # @return [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role]
            #   attr_writer :role

            # @!attribute [r] tool_calls
            #
            #   @return [Array<OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall>, nil]
            optional :tool_calls,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall] }

            # @!parse
            #   # @return [Array<OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall>]
            #   attr_writer :tool_calls

            # @!parse
            #   # A chat completion delta generated by streamed model responses.
            #   #
            #   # @param content [String, nil]
            #   # @param function_call [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall]
            #   # @param refusal [String, nil]
            #   # @param role [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role]
            #   # @param tool_calls [Array<OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall>]
            #   #
            #   def initialize(content: nil, function_call: nil, refusal: nil, role: nil, tool_calls: nil, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

            # @deprecated
            #
            # @see OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta#function_call
            class FunctionCall < OpenAI::Internal::Type::BaseModel
              # @!attribute [r] arguments
              #   The arguments to call the function with, as generated by the model in JSON
              #   format. Note that the model does not always generate valid JSON, and may
              #   hallucinate parameters not defined by your function schema. Validate the
              #   arguments in your code before calling your function.
              #
              #   @return [String, nil]
              optional :arguments, String

              # @!parse
              #   # @return [String]
              #   attr_writer :arguments

              # @!attribute [r] name
              #   The name of the function to call.
              #
              #   @return [String, nil]
              optional :name, String

              # @!parse
              #   # @return [String]
              #   attr_writer :name

              # @!parse
              #   # Deprecated and replaced by `tool_calls`. The name and arguments of a function
              #   # that should be called, as generated by the model.
              #   #
              #   # @param arguments [String]
              #   # @param name [String]
              #   #
              #   def initialize(arguments: nil, name: nil, **) = super

              # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
            end

            # The role of the author of this message.
            #
            # @see OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta#role
            module Role
              extend OpenAI::Internal::Type::Enum

              DEVELOPER = :developer
              SYSTEM = :system
              USER = :user
              ASSISTANT = :assistant
              TOOL = :tool

              finalize!

              # @!parse
              #   # @return [Array<Symbol>]
              #   def self.values; end
            end

            class ToolCall < OpenAI::Internal::Type::BaseModel
              # @!attribute index
              #
              #   @return [Integer]
              required :index, Integer

              # @!attribute [r] id
              #   The ID of the tool call.
              #
              #   @return [String, nil]
              optional :id, String

              # @!parse
              #   # @return [String]
              #   attr_writer :id

              # @!attribute [r] function
              #
              #   @return [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function, nil]
              optional :function, -> { OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function }

              # @!parse
              #   # @return [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function]
              #   attr_writer :function

              # @!attribute [r] type
              #   The type of the tool. Currently, only `function` is supported.
              #
              #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type, nil]
              optional :type, enum: -> { OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type }

              # @!parse
              #   # @return [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type]
              #   attr_writer :type

              # @!parse
              #   # @param index [Integer]
              #   # @param id [String]
              #   # @param function [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function]
              #   # @param type [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type]
              #   #
              #   def initialize(index:, id: nil, function: nil, type: nil, **) = super

              # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

              # @see OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall#function
              class Function < OpenAI::Internal::Type::BaseModel
                # @!attribute [r] arguments
                #   The arguments to call the function with, as generated by the model in JSON
                #   format. Note that the model does not always generate valid JSON, and may
                #   hallucinate parameters not defined by your function schema. Validate the
                #   arguments in your code before calling your function.
                #
                #   @return [String, nil]
                optional :arguments, String

                # @!parse
                #   # @return [String]
                #   attr_writer :arguments

                # @!attribute [r] name
                #   The name of the function to call.
                #
                #   @return [String, nil]
                optional :name, String

                # @!parse
                #   # @return [String]
                #   attr_writer :name

                # @!parse
                #   # @param arguments [String]
                #   # @param name [String]
                #   #
                #   def initialize(arguments: nil, name: nil, **) = super

                # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
              end

              # The type of the tool. Currently, only `function` is supported.
              #
              # @see OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall#type
              module Type
                extend OpenAI::Internal::Type::Enum

                FUNCTION = :function

                finalize!

                # @!parse
                #   # @return [Array<Symbol>]
                #   def self.values; end
              end
            end
          end

          # The reason the model stopped generating tokens. This will be `stop` if the model
          # hit a natural stop point or a provided stop sequence, `length` if the maximum
          # number of tokens specified in the request was reached, `content_filter` if
          # content was omitted due to a flag from our content filters, `tool_calls` if the
          # model called a tool, or `function_call` (deprecated) if the model called a
          # function.
          #
          # @see OpenAI::Models::Chat::ChatCompletionChunk::Choice#finish_reason
          module FinishReason
            extend OpenAI::Internal::Type::Enum

            STOP = :stop
            LENGTH = :length
            TOOL_CALLS = :tool_calls
            CONTENT_FILTER = :content_filter
            FUNCTION_CALL = :function_call

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end

          # @see OpenAI::Models::Chat::ChatCompletionChunk::Choice#logprobs
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

            # @!parse
            #   # Log probability information for the choice.
            #   #
            #   # @param content [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil]
            #   # @param refusal [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil]
            #   #
            #   def initialize(content:, refusal:, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
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
        # @see OpenAI::Models::Chat::ChatCompletionChunk#service_tier
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DEFAULT = :default
          FLEX = :flex

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end

    ChatCompletionChunk = Chat::ChatCompletionChunk
  end
end
