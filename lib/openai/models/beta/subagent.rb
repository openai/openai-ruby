# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class Subagent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the subagent.
        #
        #   @return [String]
        required :id, String

        # @!attribute closed_at
        #   The Unix timestamp, in seconds, when the subagent was closed. Null while active,
        #   including after resume.
        #
        #   @return [Integer, nil]
        required :closed_at, Integer, nil?: true

        # @!attribute instructions
        #   Initial task content, or null when unavailable. Text may contain placeholders
        #   for images or audio when only a preview is available.
        #
        #   @return [Array<OpenAI::Models::Beta::OutputText, OpenAI::Models::Beta::AgentContent::EncryptedContent>, nil]
        required(
          :instructions,
          -> {
            OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentContent]
          },
          nil?: true
        )

        # @!attribute name
        #   The runner-assigned nickname, or null when unavailable.
        #
        #   @return [String, nil]
        required :name, String, nil?: true

        # @!attribute object
        #   The object type. Always `agent.session.subagent`.
        #
        #   @return [Symbol, :"agent.session.subagent"]
        required :object, const: :"agent.session.subagent"

        # @!attribute opened_at
        #   The Unix timestamp, in seconds, when the subagent was first opened. Resuming
        #   does not change it.
        #
        #   @return [Integer]
        required :opened_at, Integer

        # @!attribute parent_agent_id
        #   The ID of the agent that created this subagent.
        #
        #   @return [String]
        required :parent_agent_id, String

        # @!attribute session_id
        #   The ID of the session that owns the subagent.
        #
        #   @return [String]
        required :session_id, String

        # @!attribute status
        #   The current status of the subagent.
        #
        #   @return [Symbol, OpenAI::Models::Beta::Subagent::Status]
        required :status, enum: -> { OpenAI::Beta::Subagent::Status }

        # @!method initialize(id:, closed_at:, instructions:, name:, opened_at:, parent_agent_id:, session_id:, status:, object: :"agent.session.subagent")
        #   A subagent created within a session.
        #
        #   @param id [String]
        #     The ID of the subagent.
        #
        #   @param closed_at [Integer, nil]
        #     The Unix timestamp, in seconds, when the subagent was closed. Null while active,
        #     including after resume.
        #
        #   @param instructions [Array<OpenAI::Models::Beta::OutputText, OpenAI::Models::Beta::AgentContent::EncryptedContent>, nil]
        #     Initial task content, or null when unavailable. Text may contain placeholders
        #     for images or audio when only a preview is available.
        #
        #   @param name [String, nil]
        #     The runner-assigned nickname, or null when unavailable.
        #
        #   @param opened_at [Integer]
        #     The Unix timestamp, in seconds, when the subagent was first opened. Resuming
        #     does not change it.
        #
        #   @param parent_agent_id [String]
        #     The ID of the agent that created this subagent.
        #
        #   @param session_id [String]
        #     The ID of the session that owns the subagent.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::Subagent::Status]
        #     The current status of the subagent.
        #
        #   @param object [Symbol, :"agent.session.subagent"]
        #     The object type. Always `agent.session.subagent`.

        # The current status of the subagent.
        #
        # @see OpenAI::Models::Beta::Subagent#status
        module Status
          extend OpenAI::Internal::Type::Enum

          # The subagent remains available, including while idle between turns.
          ACTIVE = :active

          # The subagent is closed.
          CLOSED = :closed

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
