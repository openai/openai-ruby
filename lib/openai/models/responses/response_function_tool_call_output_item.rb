# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFunctionToolCallOutputItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the function call tool output.
        #
        #   @return [String]
        required :id, String

        # @!attribute call_id
        #   The unique ID of the function tool call generated by the model.
        #
        #   @return [String]
        required :call_id, String

        # @!attribute output
        #   A JSON string of the output of the function tool call.
        #
        #   @return [String]
        required :output, String

        # @!attribute type
        #   The type of the function tool call output. Always `function_call_output`.
        #
        #   @return [Symbol, :function_call_output]
        required :type, const: :function_call_output

        # @!attribute [r] status
        #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status, nil]
        optional :status, enum: -> { OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status]
        #   attr_writer :status

        # @!parse
        #   # @param id [String]
        #   # @param call_id [String]
        #   # @param output [String]
        #   # @param status [Symbol, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem::Status]
        #   # @param type [Symbol, :function_call_output]
        #   #
        #   def initialize(id:, call_id:, output:, status: nil, type: :function_call_output, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        #
        # @see OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end
  end
end
