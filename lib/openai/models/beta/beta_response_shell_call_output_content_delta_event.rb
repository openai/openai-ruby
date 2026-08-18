# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseShellCallOutputContentDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute command_index
        #   The index of the shell command that produced output.
        #
        #   @return [Integer]
        required :command_index, Integer

        # @!attribute delta
        #   The stdout/stderr delta that was emitted.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseShellCallOutputContentDeltaEvent::Delta]
        required :delta, -> { OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Delta }

        # @!attribute item_id
        #   The ID of the output item that was updated.
        #
        #   @return [String]
        required :item_id, String

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
        #   The type of the event, always `response.shell_call_output_content.delta`.
        #
        #   @return [Symbol, :"response.shell_call_output_content.delta"]
        required :type, const: :"response.shell_call_output_content.delta"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseShellCallOutputContentDeltaEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Agent }

        # @!method initialize(command_index:, delta:, item_id:, output_index:, sequence_number:, agent: nil, type: :"response.shell_call_output_content.delta")
        #   A streaming event that indicated shell call output was incrementally added.
        #
        #   @param command_index [Integer] The index of the shell command that produced output.
        #
        #   @param delta [OpenAI::Models::Beta::BetaResponseShellCallOutputContentDeltaEvent::Delta] The stdout/stderr delta that was emitted.
        #
        #   @param item_id [String] The ID of the output item that was updated.
        #
        #   @param output_index [Integer] The index of the output item that was updated.
        #
        #   @param sequence_number [Integer] The sequence number of the event that was emitted.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseShellCallOutputContentDeltaEvent::Agent] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.shell_call_output_content.delta"] The type of the event, always `response.shell_call_output_content.delta`.

        # @see OpenAI::Models::Beta::BetaResponseShellCallOutputContentDeltaEvent#delta
        class Delta < OpenAI::Internal::Type::BaseModel
          # @!attribute stderr
          #   The stderr delta that was emitted.
          #
          #   @return [String, nil]
          optional :stderr, String

          # @!attribute stdout
          #   The stdout delta that was emitted.
          #
          #   @return [String, nil]
          optional :stdout, String

          # @!method initialize(stderr: nil, stdout: nil)
          #   The stdout/stderr delta that was emitted.
          #
          #   @param stderr [String] The stderr delta that was emitted.
          #
          #   @param stdout [String] The stdout delta that was emitted.
        end

        # @see OpenAI::Models::Beta::BetaResponseShellCallOutputContentDeltaEvent#agent
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

    BetaResponseShellCallOutputContentDeltaEvent = Beta::BetaResponseShellCallOutputContentDeltaEvent
  end
end
