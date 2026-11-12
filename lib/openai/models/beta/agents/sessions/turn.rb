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
            #   A customer-safe error. Non-null only for a failed turn.
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
            #   Best-effort token usage for the turn, or null if unknown. Recorded usage may
            #   change.
            #
            #   @return [OpenAI::Models::Beta::TokenUsage, nil]
            required :usage, -> { OpenAI::Beta::TokenUsage }, nil?: true

            # @!attribute prompt_cache_options
            #   Prompt cache lifetime selected when this turn started, including an inherited
            #   session TTL. Null when the turn used the model default or no TTL was recorded.
            #
            #   @return [OpenAI::Models::Beta::Agents::Sessions::Turn::PromptCacheOptions, nil]
            optional(
              :prompt_cache_options,
              -> { OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions },
              nil?: true
            )

            # @!method initialize(id:, agent_id:, completed_at:, created_at:, error:, session_id:, started_at:, status:, subagent_id:, usage:, prompt_cache_options: nil, object: :"agent.session.turn")
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
            #     A customer-safe error. Non-null only for a failed turn.
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
            #     Best-effort token usage for the turn, or null if unknown. Recorded usage may
            #     change.
            #
            #   @param prompt_cache_options [OpenAI::Models::Beta::Agents::Sessions::Turn::PromptCacheOptions, nil]
            #     Prompt cache lifetime selected when this turn started, including an inherited
            #     session TTL. Null when the turn used the model default or no TTL was recorded.
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

            # @see OpenAI::Models::Beta::Agents::Sessions::Turn#prompt_cache_options
            class PromptCacheOptions < OpenAI::Internal::Type::BaseModel
              # @!attribute ttl
              #
              #   @return [Symbol, OpenAI::Models::Beta::Agents::Sessions::Turn::PromptCacheOptions::Ttl]
              required :ttl, enum: -> { OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions::Ttl }

              # @!method initialize(ttl:)
              #   Prompt cache lifetime selected when this turn started, including an inherited
              #   session TTL. Null when the turn used the model default or no TTL was recorded.
              #
              #   @param ttl [Symbol, OpenAI::Models::Beta::Agents::Sessions::Turn::PromptCacheOptions::Ttl]

              # @see OpenAI::Models::Beta::Agents::Sessions::Turn::PromptCacheOptions#ttl
              module Ttl
                extend OpenAI::Internal::Type::Enum

                TTL_30M = :"30m"
                TTL_12H = :"12h"

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end
          end
        end
      end
    end
  end
end
