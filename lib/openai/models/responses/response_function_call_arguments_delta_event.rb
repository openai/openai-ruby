# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFunctionCallArgumentsDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The function-call arguments delta that is added.
        #
        #   @return [String]
        required :delta, String

        # @!attribute item_id
        #   The ID of the output item that the function-call arguments delta is added to.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that the function-call arguments delta is added to.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.function_call_arguments.delta`.
        #
        #   @return [Symbol, :"response.function_call_arguments.delta"]
        required :type, const: :"response.function_call_arguments.delta"

        # @!method initialize(delta:, item_id:, output_index:, type: :"response.function_call_arguments.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent} for more
        #   details.
        #
        #   Emitted when there is a partial function-call arguments delta.
        #
        #   @param delta [String] The function-call arguments delta that is added. ...
        #
        #   @param item_id [String] The ID of the output item that the function-call arguments delta is added to.
        #   ...
        #
        #   @param output_index [Integer] The index of the output item that the function-call arguments delta is added to.
        #   ...
        #
        #   @param type [Symbol, :"response.function_call_arguments.delta"] The type of the event. Always `response.function_call_arguments.delta`. ...
      end
    end
  end
end
