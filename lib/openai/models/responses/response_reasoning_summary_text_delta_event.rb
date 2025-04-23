# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseReasoningSummaryTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The text delta that was added to the summary.
        #
        #   @return [String]
        required :delta, String

        # @!attribute item_id
        #   The ID of the item this summary text delta is associated with.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item this summary text delta is associated with.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute summary_index
        #   The index of the summary part within the reasoning summary.
        #
        #   @return [Integer]
        required :summary_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.reasoning_summary_text.delta`.
        #
        #   @return [Symbol, :"response.reasoning_summary_text.delta"]
        required :type, const: :"response.reasoning_summary_text.delta"

        # @!method initialize(delta:, item_id:, output_index:, summary_index:, type: :"response.reasoning_summary_text.delta")
        #   Emitted when a delta is added to a reasoning summary text.
        #
        #   @param delta [String]
        #   @param item_id [String]
        #   @param output_index [Integer]
        #   @param summary_index [Integer]
        #   @param type [Symbol, :"response.reasoning_summary_text.delta"]
      end
    end
  end
end
