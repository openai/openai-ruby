# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFunctionCallArgumentsDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute arguments
        #   The function-call arguments.
        #
        #   @return [String]
        required :arguments, String

        # @!attribute item_id
        #   The ID of the item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #
        #   @return [Symbol, :"response.function_call_arguments.done"]
        required :type, const: :"response.function_call_arguments.done"

        # @!method initialize(arguments:, item_id:, output_index:, sequence_number:, type: :"response.function_call_arguments.done")
        #   Emitted when function-call arguments are finalized.
        #
        #   @param arguments [String] The function-call arguments.
        #
        #   @param item_id [String] The ID of the item.
        #
        #   @param output_index [Integer] The index of the output item.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.function_call_arguments.done"]
      end
    end
  end
end
