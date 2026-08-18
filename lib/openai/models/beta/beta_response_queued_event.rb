# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseQueuedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The full response object that is queued.
        #
        #   @return [OpenAI::Models::Beta::BetaResponse]
        required :response, -> { OpenAI::Beta::BetaResponse }

        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.queued'.
        #
        #   @return [Symbol, :"response.queued"]
        required :type, const: :"response.queued"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseQueuedEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseQueuedEvent::Agent }, nil?: true

        # @!method initialize(response:, sequence_number:, agent: nil, type: :"response.queued")
        #   Emitted when a response is queued and waiting to be processed.
        #
        #   @param response [OpenAI::Models::Beta::BetaResponse] The full response object that is queued.
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseQueuedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.queued"] The type of the event. Always 'response.queued'.

        # @see OpenAI::Models::Beta::BetaResponseQueuedEvent#agent
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

    BetaResponseQueuedEvent = Beta::BetaResponseQueuedEvent
  end
end
