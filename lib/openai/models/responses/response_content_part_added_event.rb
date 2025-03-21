# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseContentPartAddedEvent < OpenAI::BaseModel
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
        #   @return [OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal]
        required :part, union: -> { OpenAI::Models::Responses::ResponseContentPartAddedEvent::Part }

        # @!attribute type
        #   The type of the event. Always `response.content_part.added`.
        #
        #   @return [Symbol, :"response.content_part.added"]
        required :type, const: :"response.content_part.added"

        # @!parse
        #   # Emitted when a new content part is added.
        #   #
        #   # @param content_index [Integer]
        #   # @param item_id [String]
        #   # @param output_index [Integer]
        #   # @param part [OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal]
        #   # @param type [Symbol, :"response.content_part.added"]
        #   #
        #   def initialize(content_index:, item_id:, output_index:, part:, type: :"response.content_part.added", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # The content part that was added.
        module Part
          extend OpenAI::Union

          discriminator :type

          # A text output from the model.
          variant :output_text, -> { OpenAI::Models::Responses::ResponseOutputText }

          # A refusal from the model.
          variant :refusal, -> { OpenAI::Models::Responses::ResponseOutputRefusal }

          # @!parse
          #   # @return [Array(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)]
          #   def self.variants; end
        end
      end
    end
  end
end
