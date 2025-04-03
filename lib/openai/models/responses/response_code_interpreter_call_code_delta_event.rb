# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallCodeDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The partial code snippet added by the code interpreter.
        #
        #   @return [String]
        required :delta, String

        # @!attribute output_index
        #   The index of the output item that the code interpreter call is in progress.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.code_interpreter_call.code.delta`.
        #
        #   @return [Symbol, :"response.code_interpreter_call.code.delta"]
        required :type, const: :"response.code_interpreter_call.code.delta"

        # @!parse
        #   # Emitted when a partial code snippet is added by the code interpreter.
        #   #
        #   # @param delta [String]
        #   # @param output_index [Integer]
        #   # @param type [Symbol, :"response.code_interpreter_call.code.delta"]
        #   #
        #   def initialize(delta:, output_index:, type: :"response.code_interpreter_call.code.delta", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
