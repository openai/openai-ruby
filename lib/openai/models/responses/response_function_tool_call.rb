# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFunctionToolCall < OpenAI::BaseModel
        # @!attribute id
        #   The unique ID of the function tool call.
        #
        #   @return [String]
        required :id, String

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

        # @!attribute [r] status
        #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #     Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseFunctionToolCall::Status, nil]
        optional :status, enum: -> { OpenAI::Models::Responses::ResponseFunctionToolCall::Status }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::Responses::ResponseFunctionToolCall::Status]
        #   attr_writer :status

        # @!parse
        #   # A tool call to run a function. See the
        #   #   [function calling guide](https://platform.openai.com/docs/guides/function-calling)
        #   #   for more information.
        #   #
        #   # @param id [String]
        #   # @param arguments [String]
        #   # @param call_id [String]
        #   # @param name [String]
        #   # @param status [Symbol, OpenAI::Models::Responses::ResponseFunctionToolCall::Status]
        #   # @param type [Symbol, :function_call]
        #   #
        #   def initialize(id:, arguments:, call_id:, name:, status: nil, type: :function_call, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @abstract
        #
        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        class Status < OpenAI::Enum
          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          finalize!
        end
      end
    end
  end
end
