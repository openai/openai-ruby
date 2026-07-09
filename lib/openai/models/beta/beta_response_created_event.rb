# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseCreatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that was created.
        #
        #   @return [OpenAI::Models::Beta::BetaResponse]
        required :response, -> { OpenAI::Beta::BetaResponse }

        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.created`.
        #
        #   @return [Symbol, :"response.created"]
        required :type, const: :"response.created"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseCreatedEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseCreatedEvent::Agent }, nil?: true

        # @!method initialize(response:, sequence_number:, agent: nil, type: :"response.created")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseCreatedEvent} for more details.
        #
        #   An event that is emitted when a response is created.
        #
        #   @param response [OpenAI::Models::Beta::BetaResponse] The response that was created.
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseCreatedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.created"] The type of the event. Always `response.created`.

        # @see OpenAI::Models::Beta::BetaResponseCreatedEvent#agent
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

    BetaResponseCreatedEvent = Beta::BetaResponseCreatedEvent
  end
end
