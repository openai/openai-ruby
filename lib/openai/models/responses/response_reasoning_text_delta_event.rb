# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseReasoningTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the reasoning content part this delta is associated with.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute delta
        #   The text delta that was added to the reasoning content.
        #
        #   @return [String]
        required :delta, String

        # @!attribute item_id
        #   The ID of the item this reasoning text delta is associated with.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item this reasoning text delta is associated with.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.reasoning_text.delta`.
        #
        #   @return [Symbol, :"response.reasoning_text.delta"]
        required :type, const: :"response.reasoning_text.delta"

        # @!method initialize(content_index:, delta:, item_id:, output_index:, sequence_number:, type: :"response.reasoning_text.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseReasoningTextDeltaEvent} for more details.
        #
        #   Emitted when a delta is added to a reasoning text.
        #
        #   @param content_index [Integer] The index of the reasoning content part this delta is associated with.
        #
        #   @param delta [String] The text delta that was added to the reasoning content.
        #
        #   @param item_id [String] The ID of the item this reasoning text delta is associated with.
        #
        #   @param output_index [Integer] The index of the output item this reasoning text delta is associated with.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.reasoning_text.delta"] The type of the event. Always `response.reasoning_text.delta`.
      end
    end
  end
end
