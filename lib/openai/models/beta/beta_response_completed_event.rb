# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   Properties of the completed response.
        #
        #   @return [OpenAI::Models::Beta::BetaResponse]
        required :response, -> { OpenAI::Beta::BetaResponse }

        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.completed`.
        #
        #   @return [Symbol, :"response.completed"]
        required :type, const: :"response.completed"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseCompletedEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseCompletedEvent::Agent }, nil?: true

        # @!method initialize(response:, sequence_number:, agent: nil, type: :"response.completed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseCompletedEvent} for more details.
        #
        #   Emitted when the model response is complete.
        #
        #   @param response [OpenAI::Models::Beta::BetaResponse] Properties of the completed response.
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseCompletedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.completed"] The type of the event. Always `response.completed`.

        # @see OpenAI::Models::Beta::BetaResponseCompletedEvent#agent
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

    BetaResponseCompletedEvent = Beta::BetaResponseCompletedEvent
  end
end
