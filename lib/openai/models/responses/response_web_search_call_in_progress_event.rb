# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseWebSearchCallInProgressEvent < OpenAI::Internal::Type::BaseModel
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
        #   The type of the event. Always `response.web_search_call.in_progress`.
        #
        #   @return [Symbol, :"response.web_search_call.in_progress"]
        required :type, const: :"response.web_search_call.in_progress"

        # @!method initialize(item_id:, output_index:, type: :"response.web_search_call.in_progress")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent} for more
        #   details.
        #
        #   Emitted when a web search call is initiated.
        #
        #   @param item_id [String] Unique ID for the output item associated with the web search call. ...
        #
        #   @param output_index [Integer] The index of the output item that the web search call is associated with. ...
        #
        #   @param type [Symbol, :"response.web_search_call.in_progress"] The type of the event. Always `response.web_search_call.in_progress`. ...
      end
    end
  end
end
