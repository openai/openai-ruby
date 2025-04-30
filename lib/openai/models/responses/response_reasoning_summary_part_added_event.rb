# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseReasoningSummaryPartAddedEvent < OpenAI::Internal::Type::BaseModel
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
        #   The summary part that was added.
        #
        #   @return [OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent::Part]
        required :part, -> { OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent::Part }

        # @!attribute summary_index
        #   The index of the summary part within the reasoning summary.
        #
        #   @return [Integer]
        required :summary_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.reasoning_summary_part.added`.
        #
        #   @return [Symbol, :"response.reasoning_summary_part.added"]
        required :type, const: :"response.reasoning_summary_part.added"

        # @!method initialize(item_id:, output_index:, part:, summary_index:, type: :"response.reasoning_summary_part.added")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent} for more
        #   details.
        #
        #   Emitted when a new reasoning summary part is added.
        #
        #   @param item_id [String] The ID of the item this summary part is associated with. ...
        #
        #   @param output_index [Integer] The index of the output item this summary part is associated with. ...
        #
        #   @param part [OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent::Part] The summary part that was added. ...
        #
        #   @param summary_index [Integer] The index of the summary part within the reasoning summary. ...
        #
        #   @param type [Symbol, :"response.reasoning_summary_part.added"] The type of the event. Always `response.reasoning_summary_part.added`. ...

        # @see OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent#part
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
          #   The summary part that was added.
          #
          #   @param text [String] The text of the summary part.
          #
          #   @param type [Symbol, :summary_text] The type of the summary part. Always `summary_text`.
        end
      end
    end
  end
end
