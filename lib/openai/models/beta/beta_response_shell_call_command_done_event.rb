# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseShellCallCommandDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute command
        #   The final shell command that was emitted.
        #
        #   @return [String]
        required :command, String

        # @!attribute command_index
        #   The index of the shell command that was completed.
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
        #   The type of the event, always `response.shell_call_command.done`.
        #
        #   @return [Symbol, :"response.shell_call_command.done"]
        required :type, const: :"response.shell_call_command.done"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseShellCallCommandDoneEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseShellCallCommandDoneEvent::Agent }

        # @!method initialize(command:, command_index:, output_index:, sequence_number:, agent: nil, type: :"response.shell_call_command.done")
        #   A streaming event that indicated a shell command was completed.
        #
        #   @param command [String] The final shell command that was emitted.
        #
        #   @param command_index [Integer] The index of the shell command that was completed.
        #
        #   @param output_index [Integer] The index of the output item that was updated.
        #
        #   @param sequence_number [Integer] The sequence number of the event that was emitted.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseShellCallCommandDoneEvent::Agent] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.shell_call_command.done"] The type of the event, always `response.shell_call_command.done`.

        # @see OpenAI::Models::Beta::BetaResponseShellCallCommandDoneEvent#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute agent_name
          #   The canonical name of the agent that produced this item.
          #
          #   @return [String]
          required :agent_name, String

          # @!method initialize(agent_name:)
          #   The agent that owns this multi-agent streaming event.
          #
          #   @param agent_name [String] The canonical name of the agent that produced this item.
        end
      end
    end

    BetaResponseShellCallCommandDoneEvent = Beta::BetaResponseShellCallCommandDoneEvent
  end
end
