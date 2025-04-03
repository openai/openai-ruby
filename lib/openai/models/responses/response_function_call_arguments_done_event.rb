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

        # @!attribute type
        #
        #   @return [Symbol, :"response.function_call_arguments.done"]
        required :type, const: :"response.function_call_arguments.done"

        # @!parse
        #   # Emitted when function-call arguments are finalized.
        #   #
        #   # @param arguments [String]
        #   # @param item_id [String]
        #   # @param output_index [Integer]
        #   # @param type [Symbol, :"response.function_call_arguments.done"]
        #   #
        #   def initialize(arguments:, item_id:, output_index:, type: :"response.function_call_arguments.done", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
