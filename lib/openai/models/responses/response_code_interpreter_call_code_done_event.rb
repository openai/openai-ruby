# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallCodeDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #   The final code snippet output by the code interpreter.
        #
        #   @return [String]
        required :code, String

        # @!attribute output_index
        #   The index of the output item that the code interpreter call is in progress.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.code_interpreter_call.code.done`.
        #
        #   @return [Symbol, :"response.code_interpreter_call.code.done"]
        required :type, const: :"response.code_interpreter_call.code.done"

        # @!method initialize(code:, output_index:, type: :"response.code_interpreter_call.code.done")
        #   Emitted when code snippet output is finalized by the code interpreter.
        #
        #   @param code [String]
        #   @param output_index [Integer]
        #   @param type [Symbol, :"response.code_interpreter_call.code.done"]
      end
    end
  end
end
