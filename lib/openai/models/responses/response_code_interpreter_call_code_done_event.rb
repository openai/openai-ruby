# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallCodeDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #   The final code snippet output by the code interpreter.
        #
        #   @return [String]
        required :code, String

        # @!attribute item_id
        #   The unique identifier of the code interpreter tool call item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response for which the code is finalized.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event, used to order streaming events.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.code_interpreter_call_code.done`.
        #
        #   @return [Symbol, :"response.code_interpreter_call_code.done"]
        required :type, const: :"response.code_interpreter_call_code.done"

        # @!method initialize(code:, item_id:, output_index:, sequence_number:, type: :"response.code_interpreter_call_code.done")
        #   Emitted when the code snippet is finalized by the code interpreter.
        #
        #   @param code [String] The final code snippet output by the code interpreter.
        #
        #   @param item_id [String] The unique identifier of the code interpreter tool call item.
        #
        #   @param output_index [Integer] The index of the output item in the response for which the code is finalized.
        #
        #   @param sequence_number [Integer] The sequence number of this event, used to order streaming events.
        #
        #   @param type [Symbol, :"response.code_interpreter_call_code.done"] The type of the event. Always `response.code_interpreter_call_code.done`.
      end
    end
  end
end
