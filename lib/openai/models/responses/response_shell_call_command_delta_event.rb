# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseShellCallCommandDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute command_index
        #   The index of the shell command that was updated.
        #
        #   @return [Integer]
        required :command_index, Integer

        # @!attribute delta
        #   The shell command delta that was appended.
        #
        #   @return [String]
        required :delta, String

        # @!attribute output_index
        #   The index of the output item that was updated.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of the event that was emitted.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event, always `response.shell_call_command.delta`.
        #
        #   @return [Symbol, :"response.shell_call_command.delta"]
        required :type, const: :"response.shell_call_command.delta"

        # @!attribute obfuscation
        #   An obfuscation string that was added to pad the event payload.
        #
        #   @return [String, nil]
        optional :obfuscation, String

        # @!method initialize(command_index:, delta:, output_index:, sequence_number:, obfuscation: nil, type: :"response.shell_call_command.delta")
        #   A streaming event that indicated a shell command was incrementally updated.
        #
        #   @param command_index [Integer] The index of the shell command that was updated.
        #
        #   @param delta [String] The shell command delta that was appended.
        #
        #   @param output_index [Integer] The index of the output item that was updated.
        #
        #   @param sequence_number [Integer] The sequence number of the event that was emitted.
        #
        #   @param obfuscation [String] An obfuscation string that was added to pad the event payload.
        #
        #   @param type [Symbol, :"response.shell_call_command.delta"] The type of the event, always `response.shell_call_command.delta`.
      end
    end
  end
end
