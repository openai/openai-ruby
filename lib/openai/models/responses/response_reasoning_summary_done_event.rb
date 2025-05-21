# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseReasoningSummaryDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The unique identifier of the item for which the reasoning summary is finalized.
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

        # @!attribute text
        #   The finalized reasoning summary text.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the event. Always 'response.reasoning_summary.done'.
        #
        #   @return [Symbol, :"response.reasoning_summary.done"]
        required :type, const: :"response.reasoning_summary.done"

        # @!method initialize(item_id:, output_index:, summary_index:, text:, type: :"response.reasoning_summary.done")
        #   Emitted when the reasoning summary content is finalized for an item.
        #
        #   @param item_id [String] The unique identifier of the item for which the reasoning summary is finalized.
        #
        #   @param output_index [Integer] The index of the output item in the response's output array.
        #
        #   @param summary_index [Integer] The index of the summary part within the output item.
        #
        #   @param text [String] The finalized reasoning summary text.
        #
        #   @param type [Symbol, :"response.reasoning_summary.done"] The type of the event. Always 'response.reasoning_summary.done'.
      end
    end
  end
end
