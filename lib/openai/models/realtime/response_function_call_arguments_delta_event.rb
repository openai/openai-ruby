# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ResponseFunctionCallArgumentsDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute call_id
        #   The ID of the function call.
        #
        #   @return [String]
        required :call_id, String

        # @!attribute delta
        #   The arguments delta as a JSON string.
        #
        #   @return [String]
        required :delta, String

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the function call item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute response_id
        #   The ID of the response.
        #
        #   @return [String]
        required :response_id, String

        # @!attribute type
        #   The event type, must be `response.function_call_arguments.delta`.
        #
        #   @return [Symbol, :"response.function_call_arguments.delta"]
        required :type, const: :"response.function_call_arguments.delta"

        # @!method initialize(call_id:, delta:, event_id:, item_id:, output_index:, response_id:, type: :"response.function_call_arguments.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::ResponseFunctionCallArgumentsDeltaEvent} for more
        #   details.
        #
        #   Returned when the model-generated function call arguments are updated.
        #
        #   @param call_id [String] The ID of the function call.
        #
        #   @param delta [String] The arguments delta as a JSON string.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the function call item.
        #
        #   @param output_index [Integer] The index of the output item in the response.
        #
        #   @param response_id [String] The ID of the response.
        #
        #   @param type [Symbol, :"response.function_call_arguments.delta"] The event type, must be `response.function_call_arguments.delta`.
      end
    end
  end
end
