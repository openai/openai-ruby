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

        # @!method initialize(item_id:, output_index:, type: :"response.file_search_call.in_progress")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseFileSearchCallInProgressEvent} for more details.
        #
        #   Emitted when a file search call is initiated.
        #
        #   @param item_id [String] The ID of the output item that the file search call is initiated.
        #
        #   @param output_index [Integer] The index of the output item that the file search call is initiated.
        #
        #   @param type [Symbol, :"response.file_search_call.in_progress"] The type of the event. Always `response.file_search_call.in_progress`.
      end
    end
  end
end
