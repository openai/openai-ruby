# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallInterpretingEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The unique identifier of the code interpreter tool call item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response for which the code interpreter is
        #   interpreting code.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event, used to order streaming events.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.code_interpreter_call.interpreting`.
        #
        #   @return [Symbol, :"response.code_interpreter_call.interpreting"]
        required :type, const: :"response.code_interpreter_call.interpreting"

        # @!method initialize(item_id:, output_index:, sequence_number:, type: :"response.code_interpreter_call.interpreting")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent} for
        #   more details.
        #
        #   Emitted when the code interpreter is actively interpreting the code snippet.
        #
        #   @param item_id [String] The unique identifier of the code interpreter tool call item.
        #
        #   @param output_index [Integer] The index of the output item in the response for which the code interpreter is i
        #
        #   @param sequence_number [Integer] The sequence number of this event, used to order streaming events.
        #
        #   @param type [Symbol, :"response.code_interpreter_call.interpreting"] The type of the event. Always `response.code_interpreter_call.interpreting`.
      end
    end
  end
end
