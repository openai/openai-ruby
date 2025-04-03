# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFileSearchCallInProgressEvent < OpenAI::Internal::Type::BaseModel
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
        #   The type of the event. Always `response.file_search_call.in_progress`.
        #
        #   @return [Symbol, :"response.file_search_call.in_progress"]
        required :type, const: :"response.file_search_call.in_progress"

        # @!parse
        #   # Emitted when a file search call is initiated.
        #   #
        #   # @param item_id [String]
        #   # @param output_index [Integer]
        #   # @param type [Symbol, :"response.file_search_call.in_progress"]
        #   #
        #   def initialize(item_id:, output_index:, type: :"response.file_search_call.in_progress", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
