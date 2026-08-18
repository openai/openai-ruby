# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that failed.
        #
        #   @return [OpenAI::Models::Beta::BetaResponse]
        required :response, -> { OpenAI::Beta::BetaResponse }

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.failed`.
        #
        #   @return [Symbol, :"response.failed"]
        required :type, const: :"response.failed"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseFailedEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseFailedEvent::Agent }, nil?: true

        # @!method initialize(response:, sequence_number:, agent: nil, type: :"response.failed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseFailedEvent} for more details.
        #
        #   An event that is emitted when a response fails.
        #
        #   @param response [OpenAI::Models::Beta::BetaResponse] The response that failed.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseFailedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.failed"] The type of the event. Always `response.failed`.

        # @see OpenAI::Models::Beta::BetaResponseFailedEvent#agent
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

    BetaResponseFailedEvent = Beta::BetaResponseFailedEvent
  end
end
