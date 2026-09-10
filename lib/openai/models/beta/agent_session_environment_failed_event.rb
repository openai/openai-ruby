# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionEnvironmentFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute environment
        #   The current environment state.
        #
        #   @return [OpenAI::Models::Beta::AgentSessionEnvironmentState]
        required :environment, -> { OpenAI::Beta::AgentSessionEnvironmentState }

        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session_id
        #   The ID of the session associated with the event.
        #
        #   @return [String]
        required :session_id, String

        # @!attribute turn_id
        #   The ID of the turn associated with the event, when applicable.
        #
        #   @return [String, nil]
        required :turn_id, String, nil?: true

        # @!attribute type
        #   The type of the object. Always `agent.session.environment.failed`.
        #
        #   @return [Symbol, :"agent.session.environment.failed"]
        required :type, const: :"agent.session.environment.failed"

        # @!method initialize(environment:, event_id:, session_id:, turn_id:, type: :"agent.session.environment.failed")
        #   Emitted when a session environment fails.
        #
        #   @param environment [OpenAI::Models::Beta::AgentSessionEnvironmentState]
        #     The current environment state.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param session_id [String]
        #     The ID of the session associated with the event.
        #
        #   @param turn_id [String, nil]
        #     The ID of the turn associated with the event, when applicable.
        #
        #   @param type [Symbol, :"agent.session.environment.failed"]
        #     The type of the object. Always `agent.session.environment.failed`.
      end
    end
  end
end
