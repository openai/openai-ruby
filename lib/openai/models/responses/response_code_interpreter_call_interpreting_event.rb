# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallInterpretingEvent < OpenAI::Internal::Type::BaseModel
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
        #   The type of the event. Always `response.code_interpreter_call.interpreting`.
        #
        #   @return [Symbol, :"response.code_interpreter_call.interpreting"]
        required :type, const: :"response.code_interpreter_call.interpreting"

        # @!method initialize(code_interpreter_call:, output_index:, sequence_number:, type: :"response.code_interpreter_call.interpreting")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent} for
        #   more details.
        #
        #   Emitted when the code interpreter is actively interpreting the code snippet.
        #
        #   @param code_interpreter_call [OpenAI::Models::Responses::ResponseCodeInterpreterToolCall] A tool call to run code.
        #
        #   @param output_index [Integer] The index of the output item that the code interpreter call is in progress.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.code_interpreter_call.interpreting"] The type of the event. Always `response.code_interpreter_call.interpreting`.
      end
    end
  end
end
