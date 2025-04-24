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
        #   @return [OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal]
        required :part, union: -> { OpenAI::Models::Responses::ResponseContentPartDoneEvent::Part }

        # @!attribute type
        #   The type of the event. Always `response.content_part.done`.
        #
        #   @return [Symbol, :"response.content_part.done"]
        required :type, const: :"response.content_part.done"

        # @!method initialize(content_index:, item_id:, output_index:, part:, type: :"response.content_part.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseContentPartDoneEvent} for more details.
        #
        #   Emitted when a content part is done.
        #
        #   @param content_index [Integer] The index of the content part that is done. ...
        #
        #   @param item_id [String] The ID of the output item that the content part was added to. ...
        #
        #   @param output_index [Integer] The index of the output item that the content part was added to. ...
        #
        #   @param part [OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal] The content part that is done. ...
        #
        #   @param type [Symbol, :"response.content_part.done"] The type of the event. Always `response.content_part.done`. ...

        # The content part that is done.
        #
        # @see OpenAI::Models::Responses::ResponseContentPartDoneEvent#part
        module Part
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A text output from the model.
          variant :output_text, -> { OpenAI::Models::Responses::ResponseOutputText }

          # A refusal from the model.
          variant :refusal, -> { OpenAI::Models::Responses::ResponseOutputRefusal }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)]
        end
      end
    end
  end
end
