# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseWebSearchCallCompletedEvent < OpenAI::BaseModel
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

        # @!parse
        #   # Emitted when a web search call is completed.
        #   #
        #   # @param item_id [String]
        #   # @param output_index [Integer]
        #   # @param type [Symbol, :"response.web_search_call.completed"]
        #   #
        #   def initialize(item_id:, output_index:, type: :"response.web_search_call.completed", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
