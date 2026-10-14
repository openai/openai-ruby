# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseAudioDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   A chunk of Base64 encoded response audio bytes.
        #
        #   @return [String]
        required :delta, String

        # @!attribute sequence_number
        #   A sequence number for this chunk of the stream response.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.audio.delta`.
        #
        #   @return [Symbol, :"response.audio.delta"]
        required :type, const: :"response.audio.delta"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseAudioDeltaEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseAudioDeltaEvent::Agent }, nil?: true

        # @!method initialize(delta:, sequence_number:, agent: nil, type: :"response.audio.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseAudioDeltaEvent} for more details.
        #
        #   Emitted when there is a partial audio response.
        #
        #   @param delta [String] A chunk of Base64 encoded response audio bytes.
        #
        #   @param sequence_number [Integer] A sequence number for this chunk of the stream response.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseAudioDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.audio.delta"] The type of the event. Always `response.audio.delta`.

        # @see OpenAI::Models::Beta::BetaResponseAudioDeltaEvent#agent
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

    BetaResponseAudioDeltaEvent = Beta::BetaResponseAudioDeltaEvent
  end
end
