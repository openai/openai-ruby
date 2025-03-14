# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterCallInProgressEvent < OpenAI::BaseModel
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
        #   The type of the event. Always `response.code_interpreter_call.in_progress`.
        #
        #   @return [Symbol, :"response.code_interpreter_call.in_progress"]
        required :type, const: :"response.code_interpreter_call.in_progress"

        # @!parse
        #   # Emitted when a code interpreter call is in progress.
        #   #
        #   # @param code_interpreter_call [OpenAI::Models::Responses::ResponseCodeInterpreterToolCall]
        #   # @param output_index [Integer]
        #   # @param type [Symbol, :"response.code_interpreter_call.in_progress"]
        #   #
        #   def initialize(code_interpreter_call:, output_index:, type: :"response.code_interpreter_call.in_progress", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
