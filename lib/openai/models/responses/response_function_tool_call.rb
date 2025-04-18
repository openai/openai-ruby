# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFunctionToolCall < OpenAI::Internal::Type::BaseModel
        # @!attribute arguments
        #   A JSON string of the arguments to pass to the function.
        #
        #   @return [String]
        required :arguments, String

        # @!attribute call_id
        #   The unique ID of the function tool call generated by the model.
        #
        #   @return [String]
        required :call_id, String

        # @!attribute name
        #   The name of the function to run.
        #
        #   @return [String]
        required :name, String

        # @!attribute type
        #   The type of the function tool call. Always `function_call`.
        #
        #   @return [Symbol, :function_call]
        required :type, const: :function_call

        # @!attribute id
        #   The unique ID of the function tool call.
        #
        #   @return [String, nil]
        optional :id, String

        # @!attribute status
        #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseFunctionToolCall::Status, nil]
        optional :status, enum: -> { OpenAI::Models::Responses::ResponseFunctionToolCall::Status }

        # @!method initialize(arguments:, call_id:, name:, id: nil, status: nil, type: :function_call)
        #   A tool call to run a function. See the
        #   [function calling guide](https://platform.openai.com/docs/guides/function-calling)
        #   for more information.
        #
        #   @param arguments [String]
        #   @param call_id [String]
        #   @param name [String]
        #   @param id [String]
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseFunctionToolCall::Status]
        #   @param type [Symbol, :function_call]

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        #
        # @see OpenAI::Models::Responses::ResponseFunctionToolCall#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
