# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseReasoningSummaryPartDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the item this summary part is associated with.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item this summary part is associated with.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute part
        #   The completed summary part.
        #
        #   @return [OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent::Part]
        required :part, -> { OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent::Part }

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute summary_index
        #   The index of the summary part within the reasoning summary.
        #
        #   @return [Integer]
        required :summary_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.reasoning_summary_part.done`.
        #
        #   @return [Symbol, :"response.reasoning_summary_part.done"]
        required :type, const: :"response.reasoning_summary_part.done"

        # @!method initialize(item_id:, output_index:, part:, sequence_number:, summary_index:, type: :"response.reasoning_summary_part.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent} for more
        #   details.
        #
        #   Emitted when a reasoning summary part is completed.
        #
        #   @param item_id [String] The ID of the item this summary part is associated with.
        #
        #   @param output_index [Integer] The index of the output item this summary part is associated with.
        #
        #   @param part [OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent::Part] The completed summary part.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param summary_index [Integer] The index of the summary part within the reasoning summary.
        #
        #   @param type [Symbol, :"response.reasoning_summary_part.done"] The type of the event. Always `response.reasoning_summary_part.done`.

        # @see OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent#part
        class Part < OpenAI::Internal::Type::BaseModel
          # @!attribute text
          #   The text of the summary part.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   The type of the summary part. Always `summary_text`.
          #
          #   @return [Symbol, :summary_text]
          required :type, const: :summary_text

          # @!method initialize(text:, type: :summary_text)
          #   The completed summary part.
          #
          #   @param text [String] The text of the summary part.
          #
          #   @param type [Symbol, :summary_text] The type of the summary part. Always `summary_text`.
        end
      end
    end
  end
end
