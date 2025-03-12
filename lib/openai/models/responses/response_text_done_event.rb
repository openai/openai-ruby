# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseTextDoneEvent < OpenAI::BaseModel
        # @!attribute content_index
        #   The index of the content part that the text content is finalized.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute item_id
        #   The ID of the output item that the text content is finalized.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the text content is finalized.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute text
        #   The text content that is finalized.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the event. Always `response.output_text.done`.
        #
        #   @return [Symbol, :"response.output_text.done"]
        required :type, const: :"response.output_text.done"

        # @!parse
        #   # Emitted when text content is finalized.
        #   #
        #   # @param content_index [Integer]
        #   # @param item_id [String]
        #   # @param output_index [Integer]
        #   # @param text [String]
        #   # @param type [Symbol, :"response.output_text.done"]
        #   #
        #   def initialize(content_index:, item_id:, output_index:, text:, type: :"response.output_text.done", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
