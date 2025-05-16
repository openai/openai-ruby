# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseWebSearchCallCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   Unique ID for the output item associated with the web search call.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the web search call is associated with.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.web_search_call.completed`.
        #
        #   @return [Symbol, :"response.web_search_call.completed"]
        required :type, const: :"response.web_search_call.completed"

        # @!method initialize(item_id:, output_index:, type: :"response.web_search_call.completed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseWebSearchCallCompletedEvent} for more details.
        #
        #   Emitted when a web search call is completed.
        #
        #   @param item_id [String] Unique ID for the output item associated with the web search call.
        #
        #   @param output_index [Integer] The index of the output item that the web search call is associated with.
        #
        #   @param type [Symbol, :"response.web_search_call.completed"] The type of the event. Always `response.web_search_call.completed`.
      end
    end
  end
end
