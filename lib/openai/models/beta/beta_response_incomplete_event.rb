# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseIncompleteEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that was incomplete.
        #
        #   @return [OpenAI::Models::Beta::BetaResponse]
        required :response, -> { OpenAI::Beta::BetaResponse }

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.incomplete`.
        #
        #   @return [Symbol, :"response.incomplete"]
        required :type, const: :"response.incomplete"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseIncompleteEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseIncompleteEvent::Agent }, nil?: true

        # @!method initialize(response:, sequence_number:, agent: nil, type: :"response.incomplete")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseIncompleteEvent} for more details.
        #
        #   An event that is emitted when a response finishes as incomplete.
        #
        #   @param response [OpenAI::Models::Beta::BetaResponse] The response that was incomplete.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseIncompleteEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.incomplete"] The type of the event. Always `response.incomplete`.

        # @see OpenAI::Models::Beta::BetaResponseIncompleteEvent#agent
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

    BetaResponseIncompleteEvent = Beta::BetaResponseIncompleteEvent
  end
end
