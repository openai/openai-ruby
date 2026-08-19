# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseShellCallOutputContentDoneEvent < OpenAI::Internal::Type::BaseModel
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
        #   @return [Array<OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent::Output>]
        required(
          :output,
          -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output] }
        )

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

        # @!method initialize(command_index:, item_id:, output:, output_index:, sequence_number:, type: :"response.shell_call_output_content.done")
        #   A streaming event that indicated shell call output was completed.
        #
        #   @param command_index [Integer] The index of the shell command that produced output.
        #
        #   @param item_id [String] The ID of the output item that was updated.
        #
        #   @param output [Array<OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent::Output>] The output contents emitted for the shell command.
        #
        #   @param output_index [Integer] The index of the output item that was updated.
        #
        #   @param sequence_number [Integer] The sequence number of the event that was emitted.
        #
        #   @param type [Symbol, :"response.shell_call_output_content.done"] The type of the event, always `response.shell_call_output_content.done`.

        class Output < OpenAI::Internal::Type::BaseModel
          # @!attribute outcome
          #   Represents either an exit outcome (with an exit code) or a timeout outcome for a
          #   shell call output chunk.
          #
          #   @return [OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Timeout, OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Exit]
          required(
            :outcome,
            union: -> { OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome }
          )

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
          #   {OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent::Output} for
          #   more details.
          #
          #   The content of a shell tool call output that was emitted.
          #
          #   @param outcome [OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Timeout, OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Exit] Represents either an exit outcome (with an exit code) or a timeout outcome for a
          #
          #   @param stderr [String] The standard error output that was captured.
          #
          #   @param stdout [String] The standard output that was captured.
          #
          #   @param created_by [String] The identifier of the actor that created the item.

          # Represents either an exit outcome (with an exit code) or a timeout outcome for a
          # shell call output chunk.
          #
          # @see OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent::Output#outcome
          module Outcome
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Indicates that the shell call exceeded its configured time limit.
            variant(
              :timeout,
              -> { OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Timeout }
            )

            # Indicates that the shell commands finished and returned an exit code.
            variant :exit, -> { OpenAI::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Exit }

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
            #   @return [Array(OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Timeout, OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent::Output::Outcome::Exit)]
          end
        end
      end
    end
  end
end
