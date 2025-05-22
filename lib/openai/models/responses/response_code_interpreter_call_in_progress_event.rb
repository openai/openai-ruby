# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallInProgressEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute code_interpreter_call
        #   A tool call to run code.
        #
        #   @return [OpenAI::Models::Responses::ResponseCodeInterpreterToolCall]
        required :code_interpreter_call, -> { OpenAI::Responses::ResponseCodeInterpreterToolCall }

        # @!attribute output_index
        #   The index of the output item that the code interpreter call is in progress.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.code_interpreter_call.in_progress`.
        #
        #   @return [Symbol, :"response.code_interpreter_call.in_progress"]
        required :type, const: :"response.code_interpreter_call.in_progress"

        # @!method initialize(code_interpreter_call:, output_index:, sequence_number:, type: :"response.code_interpreter_call.in_progress")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent} for more
        #   details.
        #
        #   Emitted when a code interpreter call is in progress.
        #
        #   @param code_interpreter_call [OpenAI::Models::Responses::ResponseCodeInterpreterToolCall] A tool call to run code.
        #
        #   @param output_index [Integer] The index of the output item that the code interpreter call is in progress.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.code_interpreter_call.in_progress"] The type of the event. Always `response.code_interpreter_call.in_progress`.
      end
    end
  end
end
