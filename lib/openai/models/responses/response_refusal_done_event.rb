# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseRefusalDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part that the refusal text is finalized.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute item_id
        #   The ID of the output item that the refusal text is finalized.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the refusal text is finalized.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute refusal
        #   The refusal text that is finalized.
        #
        #   @return [String]
        required :refusal, String

        # @!attribute type
        #   The type of the event. Always `response.refusal.done`.
        #
        #   @return [Symbol, :"response.refusal.done"]
        required :type, const: :"response.refusal.done"

        # @!parse
        #   # Emitted when refusal text is finalized.
        #   #
        #   # @param content_index [Integer]
        #   # @param item_id [String]
        #   # @param output_index [Integer]
        #   # @param refusal [String]
        #   # @param type [Symbol, :"response.refusal.done"]
        #   #
        #   def initialize(content_index:, item_id:, output_index:, refusal:, type: :"response.refusal.done", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
