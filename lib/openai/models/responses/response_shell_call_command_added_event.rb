# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseShellCallCommandAddedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute command
        #   The shell command that was added.
        #
        #   @return [String]
        required :command, String

        # @!attribute command_index
        #   The index of the shell command that was added.
        #
        #   @return [Integer]
        required :command_index, Integer

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
        #   The type of the event, always `response.shell_call_command.added`.
        #
        #   @return [Symbol, :"response.shell_call_command.added"]
        required :type, const: :"response.shell_call_command.added"

        # @!method initialize(command:, command_index:, output_index:, sequence_number:, type: :"response.shell_call_command.added")
        #   A streaming event that indicated a shell command was added to a tool call.
        #
        #   @param command [String] The shell command that was added.
        #
        #   @param command_index [Integer] The index of the shell command that was added.
        #
        #   @param output_index [Integer] The index of the output item that was updated.
        #
        #   @param sequence_number [Integer] The sequence number of the event that was emitted.
        #
        #   @param type [Symbol, :"response.shell_call_command.added"] The type of the event, always `response.shell_call_command.added`.
      end
    end
  end
end
