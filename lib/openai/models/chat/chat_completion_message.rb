# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionMessage < OpenAI::BaseModel
        # @!attribute content
        #   The contents of the message.
        #
        #   @return [String, nil]
        required :content, String, nil?: true

        # @!attribute refusal
        #   The refusal message generated by the model.
        #
        #   @return [String, nil]
        required :refusal, String, nil?: true

        # @!attribute role
        #   The role of the author of this message.
        #
        #   @return [Symbol, :assistant]
        required :role, const: :assistant

        # @!attribute audio
        #   If the audio output modality is requested, this object contains data about the
        #     audio response from the model.
        #     [Learn more](https://platform.openai.com/docs/guides/audio).
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionAudio, nil]
        optional :audio, -> { OpenAI::Models::Chat::ChatCompletionAudio }, nil?: true

        # @!attribute [r] function_call
        #   Deprecated and replaced by `tool_calls`. The name and arguments of a function
        #     that should be called, as generated by the model.
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionMessage::FunctionCall, nil]
        optional :function_call, -> { OpenAI::Models::Chat::ChatCompletionMessage::FunctionCall }

        # @!parse
        #   # @return [OpenAI::Models::Chat::ChatCompletionMessage::FunctionCall]
        #   attr_writer :function_call

        # @!attribute [r] tool_calls
        #   The tool calls generated by the model, such as function calls.
        #
        #   @return [Array<OpenAI::Models::Chat::ChatCompletionMessageToolCall>, nil]
        optional :tool_calls, -> { OpenAI::ArrayOf[OpenAI::Models::Chat::ChatCompletionMessageToolCall] }

        # @!parse
        #   # @return [Array<OpenAI::Models::Chat::ChatCompletionMessageToolCall>]
        #   attr_writer :tool_calls

        # @!parse
        #   # A chat completion message generated by the model.
        #   #
        #   # @param content [String, nil]
        #   # @param refusal [String, nil]
        #   # @param audio [OpenAI::Models::Chat::ChatCompletionAudio, nil]
        #   # @param function_call [OpenAI::Models::Chat::ChatCompletionMessage::FunctionCall]
        #   # @param tool_calls [Array<OpenAI::Models::Chat::ChatCompletionMessageToolCall>]
        #   # @param role [Symbol, :assistant]
        #   #
        #   def initialize(content:, refusal:, audio: nil, function_call: nil, tool_calls: nil, role: :assistant, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @deprecated
        class FunctionCall < OpenAI::BaseModel
          # @!attribute arguments
          #   The arguments to call the function with, as generated by the model in JSON
          #     format. Note that the model does not always generate valid JSON, and may
          #     hallucinate parameters not defined by your function schema. Validate the
          #     arguments in your code before calling your function.
          #
          #   @return [String]
          required :arguments, String

          # @!attribute name
          #   The name of the function to call.
          #
          #   @return [String]
          required :name, String

          # @!parse
          #   # Deprecated and replaced by `tool_calls`. The name and arguments of a function
          #   #   that should be called, as generated by the model.
          #   #
          #   # @param arguments [String]
          #   # @param name [String]
          #   #
          #   def initialize(arguments:, name:, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end

    ChatCompletionMessage = Chat::ChatCompletionMessage
  end
end
