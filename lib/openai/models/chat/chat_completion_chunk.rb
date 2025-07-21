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
        required :choices, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionChunk::Choice] }

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
        #   Specifies the processing type used for serving the request.
        #
        #   - If set to 'auto', then the request will be processed with the service tier
        #     configured in the Project settings. Unless otherwise configured, the Project
        #     will use 'default'.
        #   - If set to 'default', then the request will be processed with the standard
        #     pricing and performance for the selected model.
        #   - If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or
        #     'priority', then the request will be processed with the corresponding service
        #     tier. [Contact sales](https://openai.com/contact-sales) to learn more about
        #     Priority processing.
        #   - When not set, the default behavior is 'auto'.
        #
        #   When the `service_tier` parameter is set, the response body will include the
        #   `service_tier` value based on the processing mode actually used to serve the
        #   request. This response value may be different from the value set in the
        #   parameter.
        #
        #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier, nil]
        optional :service_tier, enum: -> { OpenAI::Chat::ChatCompletionChunk::ServiceTier }, nil?: true

        # @!attribute system_fingerprint
        #   This fingerprint represents the backend configuration that the model runs with.
        #   Can be used in conjunction with the `seed` request parameter to understand when
        #   backend changes have been made that might impact determinism.
        #
        #   @return [String, nil]
        optional :system_fingerprint, String

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
        optional :usage, -> { OpenAI::CompletionUsage }, nil?: true

        # @!method initialize(id:, choices:, created:, model:, service_tier: nil, system_fingerprint: nil, usage: nil, object: :"chat.completion.chunk")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Chat::ChatCompletionChunk} for more details.
        #
        #   Represents a streamed chunk of a chat completion response returned by the model,
        #   based on the provided input.
        #   [Learn more](https://platform.openai.com/docs/guides/streaming-responses).
        #
        #   @param id [String] A unique identifier for the chat completion. Each chunk has the same ID.
        #
        #   @param choices [Array<OpenAI::Models::Chat::ChatCompletionChunk::Choice>] A list of chat completion choices. Can contain more than one elements if `n` is
        #
        #   @param created [Integer] The Unix timestamp (in seconds) of when the chat completion was created. Each ch
        #
        #   @param model [String] The model to generate the completion.
        #
        #   @param service_tier [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::ServiceTier, nil] Specifies the processing type used for serving the request.
        #
        #   @param system_fingerprint [String] This fingerprint represents the backend configuration that the model runs with.
        #
        #   @param usage [OpenAI::Models::CompletionUsage, nil] An optional field that will only be present when you set
        #
        #   @param object [Symbol, :"chat.completion.chunk"] The object type, which is always `chat.completion.chunk`.

        class Choice < OpenAI::Internal::Type::BaseModel
          # @!attribute delta
          #   A chat completion delta generated by streamed model responses.
          #
          #   @return [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta]
          required :delta, -> { OpenAI::Chat::ChatCompletionChunk::Choice::Delta }

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
                   enum: -> {
                     OpenAI::Chat::ChatCompletionChunk::Choice::FinishReason
                   },
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
          optional :logprobs, -> { OpenAI::Chat::ChatCompletionChunk::Choice::Logprobs }, nil?: true

          # @!method initialize(delta:, finish_reason:, index:, logprobs: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Chat::ChatCompletionChunk::Choice} for more details.
          #
          #   @param delta [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta] A chat completion delta generated by streamed model responses.
          #
          #   @param finish_reason [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::FinishReason, nil] The reason the model stopped generating tokens. This will be `stop` if the model
          #
          #   @param index [Integer] The index of the choice in the list of choices.
          #
          #   @param logprobs [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Logprobs, nil] Log probability information for the choice.

          # @see OpenAI::Models::Chat::ChatCompletionChunk::Choice#delta
          class Delta < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   The contents of the chunk message.
            #
            #   @return [String, nil]
            optional :content, String, nil?: true

            # @!attribute function_call
            #   @deprecated
            #
            #   Deprecated and replaced by `tool_calls`. The name and arguments of a function
            #   that should be called, as generated by the model.
            #
            #   @return [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall, nil]
            optional :function_call, -> { OpenAI::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall }

            # @!attribute refusal
            #   The refusal message generated by the model.
            #
            #   @return [String, nil]
            optional :refusal, String, nil?: true

            # @!attribute role
            #   The role of the author of this message.
            #
            #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role, nil]
            optional :role, enum: -> { OpenAI::Chat::ChatCompletionChunk::Choice::Delta::Role }

            # @!attribute tool_calls
            #
            #   @return [Array<OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall>, nil]
            optional :tool_calls,
                     -> {
                       OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall]
                     }

            # @!method initialize(content: nil, function_call: nil, refusal: nil, role: nil, tool_calls: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta} for more details.
            #
            #   A chat completion delta generated by streamed model responses.
            #
            #   @param content [String, nil] The contents of the chunk message.
            #
            #   @param function_call [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall] Deprecated and replaced by `tool_calls`. The name and arguments of a function th
            #
            #   @param refusal [String, nil] The refusal message generated by the model.
            #
            #   @param role [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::Role] The role of the author of this message.
            #
            #   @param tool_calls [Array<OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall>]

            # @deprecated
            #
            # @see OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta#function_call
            class FunctionCall < OpenAI::Internal::Type::BaseModel
              # @!attribute arguments
              #   The arguments to call the function with, as generated by the model in JSON
              #   format. Note that the model does not always generate valid JSON, and may
              #   hallucinate parameters not defined by your function schema. Validate the
              #   arguments in your code before calling your function.
              #
              #   @return [String, nil]
              optional :arguments, String

              # @!attribute name
              #   The name of the function to call.
              #
              #   @return [String, nil]
              optional :name, String

              # @!method initialize(arguments: nil, name: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::FunctionCall} for
              #   more details.
              #
              #   Deprecated and replaced by `tool_calls`. The name and arguments of a function
              #   that should be called, as generated by the model.
              #
              #   @param arguments [String] The arguments to call the function with, as generated by the model in JSON forma
              #
              #   @param name [String] The name of the function to call.
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

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            class ToolCall < OpenAI::Internal::Type::BaseModel
              # @!attribute index
              #
              #   @return [Integer]
              required :index, Integer

              # @!attribute id
              #   The ID of the tool call.
              #
              #   @return [String, nil]
              optional :id, String

              # @!attribute function
              #
              #   @return [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function, nil]
              optional :function, -> { OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function }

              # @!attribute type
              #   The type of the tool. Currently, only `function` is supported.
              #
              #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type, nil]
              optional :type, enum: -> { OpenAI::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type }

              # @!method initialize(index:, id: nil, function: nil, type: nil)
              #   @param index [Integer]
              #
              #   @param id [String] The ID of the tool call.
              #
              #   @param function [OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function]
              #
              #   @param type [Symbol, OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Type] The type of the tool. Currently, only `function` is supported.

              # @see OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall#function
              class Function < OpenAI::Internal::Type::BaseModel
                # @!attribute arguments
                #   The arguments to call the function with, as generated by the model in JSON
                #   format. Note that the model does not always generate valid JSON, and may
                #   hallucinate parameters not defined by your function schema. Validate the
                #   arguments in your code before calling your function.
                #
                #   @return [String, nil]
                optional :arguments, String

                # @!attribute name
                #   The name of the function to call.
                #
                #   @return [String, nil]
                optional :name, String

                # @!method initialize(arguments: nil, name: nil)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall::Function}
                #   for more details.
                #
                #   @param arguments [String] The arguments to call the function with, as generated by the model in JSON forma
                #
                #   @param name [String] The name of the function to call.
              end

              # The type of the tool. Currently, only `function` is supported.
              #
              # @see OpenAI::Models::Chat::ChatCompletionChunk::Choice::Delta::ToolCall#type
              module Type
                extend OpenAI::Internal::Type::Enum

                FUNCTION = :function

                # @!method self.values
                #   @return [Array<Symbol>]
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

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Chat::ChatCompletionChunk::Choice#logprobs
          class Logprobs < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   A list of message content tokens with log probability information.
            #
            #   @return [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil]
            required :content,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionTokenLogprob] },
                     nil?: true

            # @!attribute refusal
            #   A list of message refusal tokens with log probability information.
            #
            #   @return [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil]
            required :refusal,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionTokenLogprob] },
                     nil?: true

            # @!method initialize(content:, refusal:)
            #   Log probability information for the choice.
            #
            #   @param content [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil] A list of message content tokens with log probability information.
            #
            #   @param refusal [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil] A list of message refusal tokens with log probability information.
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
        #
        # @see OpenAI::Models::Chat::ChatCompletionChunk#service_tier
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DEFAULT = :default
          FLEX = :flex
          SCALE = :scale
          PRIORITY = :priority

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    ChatCompletionChunk = Chat::ChatCompletionChunk
  end
end
