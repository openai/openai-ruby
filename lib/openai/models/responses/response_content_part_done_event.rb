# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseContentPartDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part that is done.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute item_id
        #   The ID of the output item that the content part was added to.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the content part was added to.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute part
        #   The content part that is done.
        #
        #   @return [OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal, OpenAI::Models::Responses::ResponseContentPartDoneEvent::Part::ReasoningText]
        required :part, union: -> { OpenAI::Responses::ResponseContentPartDoneEvent::Part }

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.content_part.done`.
        #
        #   @return [Symbol, :"response.content_part.done"]
        required :type, const: :"response.content_part.done"

        # @!method initialize(content_index:, item_id:, output_index:, part:, sequence_number:, type: :"response.content_part.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseContentPartDoneEvent} for more details.
        #
        #   Emitted when a content part is done.
        #
        #   @param content_index [Integer] The index of the content part that is done.
        #
        #   @param item_id [String] The ID of the output item that the content part was added to.
        #
        #   @param output_index [Integer] The index of the output item that the content part was added to.
        #
        #   @param part [OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal, OpenAI::Models::Responses::ResponseContentPartDoneEvent::Part::ReasoningText] The content part that is done.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.content_part.done"] The type of the event. Always `response.content_part.done`.

        # The content part that is done.
        #
        # @see OpenAI::Models::Responses::ResponseContentPartDoneEvent#part
        module Part
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A text output from the model.
          variant :output_text, -> { OpenAI::Responses::ResponseOutputText }

          # A refusal from the model.
          variant :refusal, -> { OpenAI::Responses::ResponseOutputRefusal }

          # Reasoning text from the model.
          variant :reasoning_text, -> { OpenAI::Responses::ResponseContentPartDoneEvent::Part::ReasoningText }

          class ReasoningText < OpenAI::Internal::Type::BaseModel
            # @!attribute text
            #   The reasoning text from the model.
            #
            #   @return [String]
            required :text, String

            # @!attribute type
            #   The type of the reasoning text. Always `reasoning_text`.
            #
            #   @return [Symbol, :reasoning_text]
            required :type, const: :reasoning_text

            # @!method initialize(text:, type: :reasoning_text)
            #   Reasoning text from the model.
            #
            #   @param text [String] The reasoning text from the model.
            #
            #   @param type [Symbol, :reasoning_text] The type of the reasoning text. Always `reasoning_text`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal, OpenAI::Models::Responses::ResponseContentPartDoneEvent::Part::ReasoningText)]
        end
      end
    end
  end
end
