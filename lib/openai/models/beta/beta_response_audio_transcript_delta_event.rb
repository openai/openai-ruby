# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseAudioTranscriptDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The partial transcript of the audio response.
        #
        #   @return [String]
        required :delta, String

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.audio.transcript.delta`.
        #
        #   @return [Symbol, :"response.audio.transcript.delta"]
        required :type, const: :"response.audio.transcript.delta"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseAudioTranscriptDeltaEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseAudioTranscriptDeltaEvent::Agent }, nil?: true

        # @!method initialize(delta:, sequence_number:, agent: nil, type: :"response.audio.transcript.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseAudioTranscriptDeltaEvent} for more details.
        #
        #   Emitted when there is a partial transcript of audio.
        #
        #   @param delta [String] The partial transcript of the audio response.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseAudioTranscriptDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.audio.transcript.delta"] The type of the event. Always `response.audio.transcript.delta`.

        # @see OpenAI::Models::Beta::BetaResponseAudioTranscriptDeltaEvent#agent
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

    BetaResponseAudioTranscriptDeltaEvent = Beta::BetaResponseAudioTranscriptDeltaEvent
  end
end
