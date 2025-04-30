# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content_index
        #   The index of the content part that the text delta was added to.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute delta
        #   The text delta that was added.
        #
        #   @return [String]
        required :delta, String

        # @!attribute item_id
        #   The ID of the output item that the text delta was added to.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the text delta was added to.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.output_text.delta`.
        #
        #   @return [Symbol, :"response.output_text.delta"]
        required :type, const: :"response.output_text.delta"

        # @!method initialize(content_index:, delta:, item_id:, output_index:, type: :"response.output_text.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseTextDeltaEvent} for more details.
        #
        #   Emitted when there is an additional text delta.
        #
        #   @param content_index [Integer] The index of the content part that the text delta was added to. ...
        #
        #   @param delta [String] The text delta that was added. ...
        #
        #   @param item_id [String] The ID of the output item that the text delta was added to. ...
        #
        #   @param output_index [Integer] The index of the output item that the text delta was added to. ...
        #
        #   @param type [Symbol, :"response.output_text.delta"] The type of the event. Always `response.output_text.delta`. ...
      end
    end
  end
end
