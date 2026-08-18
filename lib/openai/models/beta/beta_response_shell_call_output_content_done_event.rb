# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseShellCallOutputContentDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute command_index
        #   The index of the shell command that produced output.
        #
        #   @return [Integer]
        required :command_index, Integer

        # @!attribute item_id
        #   The ID of the output item that was updated.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output
        #   The output contents emitted for the shell command.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Output>]
        required :output,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseShellCallOutputContentDoneEvent::Output] }

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
        #   The type of the event, always `response.shell_call_output_content.done`.
        #
        #   @return [Symbol, :"response.shell_call_output_content.done"]
        required :type, const: :"response.shell_call_output_content.done"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseShellCallOutputContentDoneEvent::Agent }

        # @!method initialize(command_index:, item_id:, output:, output_index:, sequence_number:, agent: nil, type: :"response.shell_call_output_content.done")
        #   A streaming event that indicated shell call output was completed.
        #
        #   @param command_index [Integer] The index of the shell command that produced output.
        #
        #   @param item_id [String] The ID of the output item that was updated.
        #
        #   @param output [Array<OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Output>] The output contents emitted for the shell command.
        #
        #   @param output_index [Integer] The index of the output item that was updated.
        #
        #   @param sequence_number [Integer] The sequence number of the event that was emitted.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Agent] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.shell_call_output_content.done"] The type of the event, always `response.shell_call_output_content.done`.

        class Output < OpenAI::Internal::Type::BaseModel
          # @!attribute outcome
          #   Represents either an exit outcome (with an exit code) or a timeout outcome for a
          #   shell call output chunk.
          #
          #   @return [OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Output::Outcome::Timeout, OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Output::Outcome::Exit]
          required :outcome,
                   union: -> { OpenAI::Beta::BetaResponseShellCallOutputContentDoneEvent::Output::Outcome }

          # @!attribute stderr
          #   The standard error output that was captured.
          #
          #   @return [String]
          required :stderr, String

          # @!attribute stdout
          #   The standard output that was captured.
          #
          #   @return [String]
          required :stdout, String

          # @!attribute created_by
          #   The identifier of the actor that created the item.
          #
          #   @return [String, nil]
          optional :created_by, String

          # @!method initialize(outcome:, stderr:, stdout:, created_by: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Output} for
          #   more details.
          #
          #   The content of a shell tool call output that was emitted.
          #
          #   @param outcome [OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Output::Outcome::Timeout, OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Output::Outcome::Exit] Represents either an exit outcome (with an exit code) or a timeout outcome for a
          #
          #   @param stderr [String] The standard error output that was captured.
          #
          #   @param stdout [String] The standard output that was captured.
          #
          #   @param created_by [String] The identifier of the actor that created the item.

          # Represents either an exit outcome (with an exit code) or a timeout outcome for a
          # shell call output chunk.
          #
          # @see OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Output#outcome
          module Outcome
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Indicates that the shell call exceeded its configured time limit.
            variant :timeout,
                    -> { OpenAI::Beta::BetaResponseShellCallOutputContentDoneEvent::Output::Outcome::Timeout }

            # Indicates that the shell commands finished and returned an exit code.
            variant :exit, -> { OpenAI::Beta::BetaResponseShellCallOutputContentDoneEvent::Output::Outcome::Exit }

            class Timeout < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   The outcome type. Always `timeout`.
              #
              #   @return [Symbol, :timeout]
              required :type, const: :timeout

              # @!method initialize(type: :timeout)
              #   Indicates that the shell call exceeded its configured time limit.
              #
              #   @param type [Symbol, :timeout] The outcome type. Always `timeout`.
            end

            class Exit < OpenAI::Internal::Type::BaseModel
              # @!attribute exit_code
              #   Exit code from the shell process.
              #
              #   @return [Integer]
              required :exit_code, Integer

              # @!attribute type
              #   The outcome type. Always `exit`.
              #
              #   @return [Symbol, :exit]
              required :type, const: :exit

              # @!method initialize(exit_code:, type: :exit)
              #   Indicates that the shell commands finished and returned an exit code.
              #
              #   @param exit_code [Integer] Exit code from the shell process.
              #
              #   @param type [Symbol, :exit] The outcome type. Always `exit`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Output::Outcome::Timeout, OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Output::Outcome::Exit)]
          end
        end

        # @see OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent#agent
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

    BetaResponseShellCallOutputContentDoneEvent = Beta::BetaResponseShellCallOutputContentDoneEvent
  end
end
