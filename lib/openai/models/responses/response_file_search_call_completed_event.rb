# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFileSearchCallCompletedEvent < OpenAI::BaseModel
        # @!attribute item_id
        #   The ID of the output item that the file search call is initiated.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the file search call is initiated.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.file_search_call.completed`.
        #
        #   @return [Symbol, :"response.file_search_call.completed"]
        required :type, const: :"response.file_search_call.completed"

        # @!parse
        #   # Emitted when a file search call is completed (results found).
        #   #
        #   # @param item_id [String]
        #   # @param output_index [Integer]
        #   # @param type [Symbol, :"response.file_search_call.completed"]
        #   #
        #   def initialize(item_id:, output_index:, type: :"response.file_search_call.completed", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
