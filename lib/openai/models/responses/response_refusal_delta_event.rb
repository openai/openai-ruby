# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseRefusalDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part that the refusal text is added to.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute delta
        #   The refusal text that is added.
        #
        #   @return [String]
        required :delta, String

        # @!attribute item_id
        #   The ID of the output item that the refusal text is added to.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the refusal text is added to.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.refusal.delta`.
        #
        #   @return [Symbol, :"response.refusal.delta"]
        required :type, const: :"response.refusal.delta"

        # @!parse
        #   # Emitted when there is a partial refusal text.
        #   #
        #   # @param content_index [Integer]
        #   # @param delta [String]
        #   # @param item_id [String]
        #   # @param output_index [Integer]
        #   # @param type [Symbol, :"response.refusal.delta"]
        #   #
        #   def initialize(content_index:, delta:, item_id:, output_index:, type: :"response.refusal.delta", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
