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

        # @!method initialize(content_index:, delta:, item_id:, output_index:, type: :"response.refusal.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseRefusalDeltaEvent} for more details.
        #
        #   Emitted when there is a partial refusal text.
        #
        #   @param content_index [Integer] The index of the content part that the refusal text is added to. ...
        #
        #   @param delta [String] The refusal text that is added. ...
        #
        #   @param item_id [String] The ID of the output item that the refusal text is added to. ...
        #
        #   @param output_index [Integer] The index of the output item that the refusal text is added to. ...
        #
        #   @param type [Symbol, :"response.refusal.delta"] The type of the event. Always `response.refusal.delta`. ...
      end
    end
  end
end
