# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseReasoningSummaryDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The partial update to the reasoning summary content.
        #
        #   @return [Object]
        required :delta, OpenAI::Internal::Type::Unknown

        # @!attribute item_id
        #   The unique identifier of the item for which the reasoning summary is being
        #   updated.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response's output array.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute summary_index
        #   The index of the summary part within the output item.
        #
        #   @return [Integer]
        required :summary_index, Integer

        # @!attribute type
        #   The type of the event. Always 'response.reasoning_summary.delta'.
        #
        #   @return [Symbol, :"response.reasoning_summary.delta"]
        required :type, const: :"response.reasoning_summary.delta"

        # @!method initialize(delta:, item_id:, output_index:, summary_index:, type: :"response.reasoning_summary.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseReasoningSummaryDeltaEvent} for more details.
        #
        #   Emitted when there is a delta (partial update) to the reasoning summary content.
        #
        #   @param delta [Object] The partial update to the reasoning summary content.
        #
        #   @param item_id [String] The unique identifier of the item for which the reasoning summary is being updat
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param summary_index [Integer] The index of the summary part within the output item.
        #
        #   @param type [Symbol, :"response.reasoning_summary.delta"] The type of the event. Always 'response.reasoning_summary.delta'.
      end
    end
  end
end
