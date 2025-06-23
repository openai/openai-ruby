# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The unique identifier of the code interpreter tool call item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response for which the code interpreter call
        #   is completed.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event, used to order streaming events.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.code_interpreter_call.completed`.
        #
        #   @return [Symbol, :"response.code_interpreter_call.completed"]
        required :type, const: :"response.code_interpreter_call.completed"

        # @!method initialize(item_id:, output_index:, sequence_number:, type: :"response.code_interpreter_call.completed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent} for more
        #   details.
        #
        #   Emitted when the code interpreter call is completed.
        #
        #   @param item_id [String] The unique identifier of the code interpreter tool call item.
        #
        #   @param output_index [Integer] The index of the output item in the response for which the code interpreter call
        #
        #   @param sequence_number [Integer] The sequence number of this event, used to order streaming events.
        #
        #   @param type [Symbol, :"response.code_interpreter_call.completed"] The type of the event. Always `response.code_interpreter_call.completed`.
      end
    end
  end
end
