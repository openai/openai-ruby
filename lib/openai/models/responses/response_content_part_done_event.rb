# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseContentPartDoneEvent < OpenAI::BaseModel
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

        # @!parse
        #   # Emitted when a content part is done.
        #   #
        #   # @param content_index [Integer]
        #   # @param item_id [String]
        #   # @param output_index [Integer]
        #   # @param part [OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal]
        #   # @param type [Symbol, :"response.content_part.done"]
        #   #
        #   def initialize(content_index:, item_id:, output_index:, part:, type: :"response.content_part.done", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # The content part that is done.
        module Part
          extend OpenAI::Union

          discriminator :type

          # A text output from the model.
          variant :output_text, -> { OpenAI::Models::Responses::ResponseOutputText }

          # A refusal from the model.
          variant :refusal, -> { OpenAI::Models::Responses::ResponseOutputRefusal }

          # @!parse
          #   class << self
          #     # @return [Array(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)]
          #     def variants; end
          #   end
        end
      end
    end
  end
end
