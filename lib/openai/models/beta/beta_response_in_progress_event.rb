# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseInProgressEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that is in progress.
        #
        #   @return [OpenAI::Models::Beta::BetaResponse]
        required :response, -> { OpenAI::Beta::BetaResponse }

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.in_progress`.
        #
        #   @return [Symbol, :"response.in_progress"]
        required :type, const: :"response.in_progress"

        # @!attribute agent
        #   The agent that owns this multi-agent streaming event.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseInProgressEvent::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseInProgressEvent::Agent }, nil?: true

        # @!method initialize(response:, sequence_number:, agent: nil, type: :"response.in_progress")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseInProgressEvent} for more details.
        #
        #   Emitted when the response is in progress.
        #
        #   @param response [OpenAI::Models::Beta::BetaResponse] The response that is in progress.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseInProgressEvent::Agent, nil] The agent that owns this multi-agent streaming event.
        #
        #   @param type [Symbol, :"response.in_progress"] The type of the event. Always `response.in_progress`.

        # @see OpenAI::Models::Beta::BetaResponseInProgressEvent#agent
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

    BetaResponseInProgressEvent = Beta::BetaResponseInProgressEvent
  end
end
