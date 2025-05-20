# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseContentPartAddedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part that was added.
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
        #   The content part that was added.
        #
        #   @return [OpenAI::Responses::ResponseOutputText, OpenAI::Responses::ResponseOutputRefusal]
        required :part, union: -> { OpenAI::Responses::ResponseContentPartAddedEvent::Part }

        # @!attribute type
        #   The type of the event. Always `response.content_part.added`.
        #
        #   @return [Symbol, :"response.content_part.added"]
        required :type, const: :"response.content_part.added"

        # @!method initialize(content_index:, item_id:, output_index:, part:, type: :"response.content_part.added")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseContentPartAddedEvent} for more details.
        #
        #   Emitted when a new content part is added.
        #
        #   @param content_index [Integer] The index of the content part that was added.
        #
        #   @param item_id [String] The ID of the output item that the content part was added to.
        #
        #   @param output_index [Integer] The index of the output item that the content part was added to.
        #
        #   @param part [OpenAI::Responses::ResponseOutputText, OpenAI::Responses::ResponseOutputRefusal] The content part that was added.
        #
        #   @param type [Symbol, :"response.content_part.added"] The type of the event. Always `response.content_part.added`.

        # The content part that was added.
        #
        # @see OpenAI::Responses::ResponseContentPartAddedEvent#part
        module Part
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A text output from the model.
          variant :output_text, -> { OpenAI::Responses::ResponseOutputText }

          # A refusal from the model.
          variant :refusal, -> { OpenAI::Responses::ResponseOutputRefusal }

          # @!method self.variants
          #   @return [Array(OpenAI::Responses::ResponseOutputText, OpenAI::Responses::ResponseOutputRefusal)]
        end
      end
    end
  end
end
