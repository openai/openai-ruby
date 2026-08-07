# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCustomToolCallInputDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute input
        #   The complete input data for the custom tool call.
        #
        #   @return [String]
        required :input, String

        # @!attribute item_id
        #   Unique identifier for the API item associated with this event.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output this event applies to.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The event type identifier.
        #
        #   @return [Symbol, :"response.custom_tool_call_input.done"]
        required :type, const: :"response.custom_tool_call_input.done"

        # @!method initialize(input:, item_id:, output_index:, sequence_number:, type: :"response.custom_tool_call_input.done")
        #   Event indicating that input for a custom tool call is complete.
        #
        #   @param input [String] The complete input data for the custom tool call.
        #
        #   @param item_id [String] Unique identifier for the API item associated with this event.
        #
        #   @param output_index [Integer] The index of the output this event applies to.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.custom_tool_call_input.done"] The event type identifier.
      end
    end
  end
end
