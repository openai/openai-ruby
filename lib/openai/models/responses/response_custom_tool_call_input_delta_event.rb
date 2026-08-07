# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCustomToolCallInputDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The incremental input data (delta) for the custom tool call.
        #
        #   @return [String]
        required :delta, String

        # @!attribute item_id
        #   Unique identifier for the API item associated with this event.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output this delta applies to.
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
        #   @return [Symbol, :"response.custom_tool_call_input.delta"]
        required :type, const: :"response.custom_tool_call_input.delta"

        # @!method initialize(delta:, item_id:, output_index:, sequence_number:, type: :"response.custom_tool_call_input.delta")
        #   Event representing a delta (partial update) to the input of a custom tool call.
        #
        #   @param delta [String] The incremental input data (delta) for the custom tool call.
        #
        #   @param item_id [String] Unique identifier for the API item associated with this event.
        #
        #   @param output_index [Integer] The index of the output this delta applies to.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.custom_tool_call_input.delta"] The event type identifier.
      end
    end
  end
end
