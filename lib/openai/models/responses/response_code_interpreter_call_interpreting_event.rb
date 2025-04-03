# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallInterpretingEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute code_interpreter_call
        #   A tool call to run code.
        #
        #   @return [OpenAI::Models::Responses::ResponseCodeInterpreterToolCall]
        required :code_interpreter_call, -> { OpenAI::Models::Responses::ResponseCodeInterpreterToolCall }

        # @!attribute output_index
        #   The index of the output item that the code interpreter call is in progress.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute type
        #   The type of the event. Always `response.code_interpreter_call.interpreting`.
        #
        #   @return [Symbol, :"response.code_interpreter_call.interpreting"]
        required :type, const: :"response.code_interpreter_call.interpreting"

        # @!parse
        #   # Emitted when the code interpreter is actively interpreting the code snippet.
        #   #
        #   # @param code_interpreter_call [OpenAI::Models::Responses::ResponseCodeInterpreterToolCall]
        #   # @param output_index [Integer]
        #   # @param type [Symbol, :"response.code_interpreter_call.interpreting"]
        #   #
        #   def initialize(code_interpreter_call:, output_index:, type: :"response.code_interpreter_call.interpreting", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
