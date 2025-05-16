# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseReasoningSummaryTextDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the item this summary text is associated with.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item this summary text is associated with.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute summary_index
        #   The index of the summary part within the reasoning summary.
        #
        #   @return [Integer]
        required :summary_index, Integer

        # @!attribute text
        #   The full text of the completed reasoning summary.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the event. Always `response.reasoning_summary_text.done`.
        #
        #   @return [Symbol, :"response.reasoning_summary_text.done"]
        required :type, const: :"response.reasoning_summary_text.done"

        # @!method initialize(item_id:, output_index:, summary_index:, text:, type: :"response.reasoning_summary_text.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseReasoningSummaryTextDoneEvent} for more details.
        #
        #   Emitted when a reasoning summary text is completed.
        #
        #   @param item_id [String] The ID of the item this summary text is associated with.
        #
        #   @param output_index [Integer] The index of the output item this summary text is associated with.
        #
        #   @param summary_index [Integer] The index of the summary part within the reasoning summary.
        #
        #   @param text [String] The full text of the completed reasoning summary.
        #
        #   @param type [Symbol, :"response.reasoning_summary_text.done"] The type of the event. Always `response.reasoning_summary_text.done`.
      end
    end
  end
end
