# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseAudioTranscriptDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.audio.transcript.done`.
        #
        #   @return [Symbol, :"response.audio.transcript.done"]
        required :type, const: :"response.audio.transcript.done"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseAudioTranscriptDoneEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseAudioTranscriptDoneEvent::Agent }, nil?: true

        # @!method initialize(sequence_number:, agent: nil, type: :"response.audio.transcript.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseAudioTranscriptDoneEvent} for more details.
        #
        #   Emitted when the full audio transcript is completed.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseAudioTranscriptDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.audio.transcript.done"] The type of the event. Always `response.audio.transcript.done`.

        # @see OpenAI::Models::Beta::BetaResponseAudioTranscriptDoneEvent#agent
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

    BetaResponseAudioTranscriptDoneEvent = Beta::BetaResponseAudioTranscriptDoneEvent
  end
end
