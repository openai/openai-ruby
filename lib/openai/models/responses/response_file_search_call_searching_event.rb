# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFileSearchCallSearchingEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the output item that the file search call is initiated.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the file search call is searching.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.file_search_call.searching`.
        #
        #   @return [Symbol, :"response.file_search_call.searching"]
        required :type, const: :"response.file_search_call.searching"

        # @!method initialize(item_id:, output_index:, type: :"response.file_search_call.searching")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseFileSearchCallSearchingEvent} for more details.
        #
        #   Emitted when a file search is currently searching.
        #
        #   @param item_id [String] The ID of the output item that the file search call is initiated.
        #
        #   @param output_index [Integer] The index of the output item that the file search call is searching.
        #
        #   @param type [Symbol, :"response.file_search_call.searching"] The type of the event. Always `response.file_search_call.searching`.
      end
    end
  end
end
