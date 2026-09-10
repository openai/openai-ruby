# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Sessions
          # @see OpenAI::Resources::Beta::Agents::Sessions::Turns#retrieve
          class Turn < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the turn.
            #
            #   @return [String]
            required :id, String

            # @!attribute agent_id
            #   The ID of the agent that ran the turn.
            #
            #   @return [String]
            required :agent_id, String

            # @!attribute completed_at
            #   The Unix timestamp, in seconds, when the turn reached a terminal state.
            #
            #   @return [Integer, nil]
            required :completed_at, Integer, nil?: true

            # @!attribute created_at
            #   The Unix timestamp, in seconds, used to order the turn by creation time.
            #   Subagent turns use their start time, falling back to completion time or the
            #   subagent opening time when the preceding timestamps are unavailable.
            #
            #   @return [Integer]
            required :created_at, Integer

            # @!attribute error
            #   A customer-safe error describing why a session request failed.
            #
            #   @return [OpenAI::Models::Beta::SessionTurnError, nil]
            required :error, -> { OpenAI::Beta::SessionTurnError }, nil?: true

            # @!attribute object
            #   The object type. Always `agent.session.turn`.
            #
            #   @return [Symbol, :"agent.session.turn"]
            required :object, const: :"agent.session.turn"

            # @!attribute session_id
            #   The ID of the session that owns the turn.
            #
            #   @return [String]
            required :session_id, String

            # @!attribute started_at
            #   The Unix timestamp, in seconds, when the turn started.
            #
            #   @return [Integer, nil]
            required :started_at, Integer, nil?: true

            # @!attribute status
            #   The current status of the turn.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Agents::Sessions::Turn::Status]
            required :status, enum: -> { OpenAI::Beta::Agents::Sessions::Turn::Status }

            # @!attribute subagent_id
            #   The ID of the subagent that ran the turn, if applicable.
            #
            #   @return [String, nil]
            required :subagent_id, String, nil?: true

            # @!attribute usage
            #   Recorded token usage for a session or turn. Usage is best effort and may change.
            #
            #   @return [OpenAI::Models::Beta::TokenUsage, nil]
            required :usage, -> { OpenAI::Beta::TokenUsage }, nil?: true

            # @!method initialize(id:, agent_id:, completed_at:, created_at:, error:, session_id:, started_at:, status:, subagent_id:, usage:, object: :"agent.session.turn")
            #   The canonical public representation of a session turn.
            #
            #   @param id [String]
            #     The ID of the turn.
            #
            #   @param agent_id [String]
            #     The ID of the agent that ran the turn.
            #
            #   @param completed_at [Integer, nil]
            #     The Unix timestamp, in seconds, when the turn reached a terminal state.
            #
            #   @param created_at [Integer]
            #     The Unix timestamp, in seconds, used to order the turn by creation time.
            #     Subagent turns use their start time, falling back to completion time or the
            #     subagent opening time when the preceding timestamps are unavailable.
            #
            #   @param error [OpenAI::Models::Beta::SessionTurnError, nil]
            #     A customer-safe error describing why a session request failed.
            #
            #   @param session_id [String]
            #     The ID of the session that owns the turn.
            #
            #   @param started_at [Integer, nil]
            #     The Unix timestamp, in seconds, when the turn started.
            #
            #   @param status [Symbol, OpenAI::Models::Beta::Agents::Sessions::Turn::Status]
            #     The current status of the turn.
            #
            #   @param subagent_id [String, nil]
            #     The ID of the subagent that ran the turn, if applicable.
            #
            #   @param usage [OpenAI::Models::Beta::TokenUsage, nil]
            #     Recorded token usage for a session or turn. Usage is best effort and may change.
            #
            #   @param object [Symbol, :"agent.session.turn"]
            #     The object type. Always `agent.session.turn`.

            # The current status of the turn.
            #
            # @see OpenAI::Models::Beta::Agents::Sessions::Turn#status
            module Status
              extend OpenAI::Internal::Type::Enum

              # The turn is waiting to start.
              QUEUED = :queued

              # The turn is in progress.
              IN_PROGRESS = :in_progress

              # The turn is waiting for external input.
              WAITING = :waiting

              # The turn completed successfully.
              COMPLETED = :completed

              # The turn failed.
              FAILED = :failed

              # The turn was cancelled.
              CANCELLED = :cancelled

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
