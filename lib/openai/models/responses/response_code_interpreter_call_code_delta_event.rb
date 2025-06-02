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

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.code_interpreter_call_code.delta`.
        #
        #   @return [Symbol, :"response.code_interpreter_call_code.delta"]
        required :type, const: :"response.code_interpreter_call_code.delta"

        # @!method initialize(delta:, output_index:, sequence_number:, type: :"response.code_interpreter_call_code.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent} for more
        #   details.
        #
        #   Emitted when a partial code snippet is added by the code interpreter.
        #
        #   @param delta [String] The partial code snippet added by the code interpreter.
        #
        #   @param output_index [Integer] The index of the output item that the code interpreter call is in progress.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.code_interpreter_call_code.delta"] The type of the event. Always `response.code_interpreter_call_code.delta`.
      end
    end
  end
end
