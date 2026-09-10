# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentCommandExecutionItem < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the command execution item.
        #
        #   @return [String]
        required :id, String

        # @!attribute command
        #   The command that was executed.
        #
        #   @return [String]
        required :command, String

        # @!attribute cwd
        #   The working directory used to execute the command.
        #
        #   @return [String, nil]
        required :cwd, String, nil?: true

        # @!attribute duration_ms
        #   The command duration in milliseconds.
        #
        #   @return [Integer, nil]
        required :duration_ms, Integer, nil?: true

        # @!attribute exit_code
        #   The process exit code, if the command completed.
        #
        #   @return [Integer, nil]
        required :exit_code, Integer, nil?: true

        # @!attribute output
        #   The command output, if available.
        #
        #   @return [String, nil]
        required :output, String, nil?: true

        # @!attribute status
        #   The status of the command execution.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
        required :status, enum: -> { OpenAI::Beta::AgentFunctionCallStatus }

        # @!attribute turn_id
        #   The ID of the turn that contains this item.
        #
        #   @return [String]
        required :turn_id, String

        # @!attribute type
        #   The item type. Always `command_execution`.
        #
        #   @return [Symbol, :command_execution]
        required :type, const: :command_execution

        # @!method initialize(id:, command:, cwd:, duration_ms:, exit_code:, output:, status:, turn_id:, type: :command_execution)
        #   A command execution produced by the agent.
        #
        #   @param id [String]
        #     The ID of the command execution item.
        #
        #   @param command [String]
        #     The command that was executed.
        #
        #   @param cwd [String, nil]
        #     The working directory used to execute the command.
        #
        #   @param duration_ms [Integer, nil]
        #     The command duration in milliseconds.
        #
        #   @param exit_code [Integer, nil]
        #     The process exit code, if the command completed.
        #
        #   @param output [String, nil]
        #     The command output, if available.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentFunctionCallStatus]
        #     The status of the command execution.
        #
        #   @param turn_id [String]
        #     The ID of the turn that contains this item.
        #
        #   @param type [Symbol, :command_execution]
        #     The item type. Always `command_execution`.
      end
    end
  end
end
