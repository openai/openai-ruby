# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionEnvironmentResetEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute environment_id
        #   The stable environment ID, retained across sandbox replacements.
        #
        #   @return [String]
        required :environment_id, String

        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute reset_count
        #   Monotonically increasing reset number. Repeated notifications share this number.
        #
        #   @return [Integer]
        required :reset_count, Integer

        # @!attribute session_id
        #   The ID of the session associated with the event.
        #
        #   @return [String]
        required :session_id, String

        # @!attribute turn_id
        #   The associated turn, when applicable.
        #
        #   @return [String, nil]
        required :turn_id, String, nil?: true

        # @!attribute type
        #   The type of the object. Always `agent.session.environment.reset`.
        #
        #   @return [Symbol, :"agent.session.environment.reset"]
        required :type, const: :"agent.session.environment.reset"

        # @!method initialize(environment_id:, event_id:, reset_count:, session_id:, turn_id:, type: :"agent.session.environment.reset")
        #   Emitted after a hosted sandbox is replaced. Conversation history survives;
        #   changes to the previous sandbox's files and processes do not.
        #
        #   @param environment_id [String]
        #     The stable environment ID, retained across sandbox replacements.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param reset_count [Integer]
        #     Monotonically increasing reset number. Repeated notifications share this number.
        #
        #   @param session_id [String]
        #     The ID of the session associated with the event.
        #
        #   @param turn_id [String, nil]
        #     The associated turn, when applicable.
        #
        #   @param type [Symbol, :"agent.session.environment.reset"]
        #     The type of the object. Always `agent.session.environment.reset`.
      end
    end
  end
end
