# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseAudioDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute sequence_number
        #   The sequence number of the delta.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.audio.done`.
        #
        #   @return [Symbol, :"response.audio.done"]
        required :type, const: :"response.audio.done"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseAudioDoneEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseAudioDoneEvent::Agent }, nil?: true

        # @!method initialize(sequence_number:, agent: nil, type: :"response.audio.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseAudioDoneEvent} for more details.
        #
        #   Emitted when the audio response is complete.
        #
        #   @param sequence_number [Integer] The sequence number of the delta.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseAudioDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.audio.done"] The type of the event. Always `response.audio.done`.

        # @see OpenAI::Models::Beta::BetaResponseAudioDoneEvent#agent
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

    BetaResponseAudioDoneEvent = Beta::BetaResponseAudioDoneEvent
  end
end
