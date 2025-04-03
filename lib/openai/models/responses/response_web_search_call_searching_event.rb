# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseWebSearchCallSearchingEvent < OpenAI::Internal::Type::BaseModel
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
        #   The type of the event. Always `response.web_search_call.searching`.
        #
        #   @return [Symbol, :"response.web_search_call.searching"]
        required :type, const: :"response.web_search_call.searching"

        # @!parse
        #   # Emitted when a web search call is executing.
        #   #
        #   # @param item_id [String]
        #   # @param output_index [Integer]
        #   # @param type [Symbol, :"response.web_search_call.searching"]
        #   #
        #   def initialize(item_id:, output_index:, type: :"response.web_search_call.searching", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
