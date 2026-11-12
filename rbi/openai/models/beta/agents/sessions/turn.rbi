# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Sessions

          class Turn < OpenAI::Internal::Type::BaseModel

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Sessions::Turn,
                OpenAI::Internal::AnyHash
              )
            end

            # The ID of the turn.
            sig { returns(String) }
            attr_accessor :id

            # The ID of the agent that ran the turn.
            sig { returns(String) }
            attr_accessor :agent_id

            # The Unix timestamp, in seconds, when the turn reached a terminal state.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :completed_at

            # The Unix timestamp, in seconds, used to order the turn by creation time.
            # Subagent turns use their start time, falling back to completion time or the
            # subagent opening time when the preceding timestamps are unavailable.
            sig { returns(Integer) }
            attr_accessor :created_at

            # A customer-safe error. Non-null only for a failed turn.
            sig { returns(T.nilable(OpenAI::Beta::SessionTurnError)) }
            attr_reader :error

            sig { params(error: T.nilable(OpenAI::Beta::SessionTurnError::OrHash)).void }
            attr_writer :error

            # The object type. Always `agent.session.turn`.
            sig { returns(Symbol) }
            attr_accessor :object

            # The ID of the session that owns the turn.
            sig { returns(String) }
            attr_accessor :session_id

            # The Unix timestamp, in seconds, when the turn started.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :started_at

            # The current status of the turn.
            sig { returns(OpenAI::Beta::Agents::Sessions::Turn::Status::TaggedSymbol) }
            attr_accessor :status

            # The ID of the subagent that ran the turn, if applicable.
            sig { returns(T.nilable(String)) }
            attr_accessor :subagent_id

            # Best-effort token usage for the turn, or null if unknown. Recorded usage may
            # change.
            sig { returns(T.nilable(OpenAI::Beta::TokenUsage)) }
            attr_reader :usage

            sig { params(usage: T.nilable(OpenAI::Beta::TokenUsage::OrHash)).void }
            attr_writer :usage

            # Prompt cache lifetime selected when this turn started, including an inherited
            # session TTL. Null when the turn used the model default or no TTL was recorded.
            sig { returns(T.nilable(OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions)) }
            attr_reader :prompt_cache_options

            sig {
              params(prompt_cache_options: T.nilable(OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions::OrHash))
                .void
            }
            attr_writer :prompt_cache_options

            # The canonical public representation of a session turn.
            sig do
              params(

                id: String,

                agent_id: String,

                completed_at: T.nilable(Integer),

                created_at: Integer,

                error: T.nilable(OpenAI::Beta::SessionTurnError::OrHash),

                session_id: String,

                started_at: T.nilable(Integer),

                status: OpenAI::Beta::Agents::Sessions::Turn::Status::OrSymbol,

                subagent_id: T.nilable(String),

                usage: T.nilable(OpenAI::Beta::TokenUsage::OrHash),

                prompt_cache_options: T.nilable(OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions::OrHash),

                object: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The ID of the turn.
              id:,

              # The ID of the agent that ran the turn.
              agent_id:,

              # The Unix timestamp, in seconds, when the turn reached a terminal state.
              completed_at:,

              # The Unix timestamp, in seconds, used to order the turn by creation time.
              # Subagent turns use their start time, falling back to completion time or the
              # subagent opening time when the preceding timestamps are unavailable.
              created_at:,

              # A customer-safe error. Non-null only for a failed turn.
              error:,

              # The ID of the session that owns the turn.
              session_id:,

              # The Unix timestamp, in seconds, when the turn started.
              started_at:,

              # The current status of the turn.
              status:,

              # The ID of the subagent that ran the turn, if applicable.
              subagent_id:,

              # Best-effort token usage for the turn, or null if unknown. Recorded usage may
              # change.
              usage:,

              # Prompt cache lifetime selected when this turn started, including an inherited
              # session TTL. Null when the turn used the model default or no TTL was recorded.
              prompt_cache_options: nil,

              # The object type. Always `agent.session.turn`.

              object: :"agent.session.turn"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  agent_id: String,
                  completed_at: T.nilable(Integer),
                  created_at: Integer,
                  error: T.nilable(OpenAI::Beta::SessionTurnError),
                  object: Symbol,
                  session_id: String,
                  started_at: T.nilable(Integer),
                  status: OpenAI::Beta::Agents::Sessions::Turn::Status::TaggedSymbol,
                  subagent_id: T.nilable(String),
                  usage: T.nilable(OpenAI::Beta::TokenUsage),
                  prompt_cache_options: T.nilable(OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions)
                }
              )
            end
            def to_hash
            end

            # The current status of the turn.
            module Status
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Agents::Sessions::Turn::Status) }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              # The turn is waiting to start.
              QUEUED = T.let(:queued, OpenAI::Beta::Agents::Sessions::Turn::Status::TaggedSymbol)

              # The turn is in progress.
              IN_PROGRESS = T.let(:in_progress, OpenAI::Beta::Agents::Sessions::Turn::Status::TaggedSymbol)

              # The turn is waiting for external input.
              WAITING = T.let(:waiting, OpenAI::Beta::Agents::Sessions::Turn::Status::TaggedSymbol)

              # The turn completed successfully.
              COMPLETED = T.let(:completed, OpenAI::Beta::Agents::Sessions::Turn::Status::TaggedSymbol)

              # The turn failed.
              FAILED = T.let(:failed, OpenAI::Beta::Agents::Sessions::Turn::Status::TaggedSymbol)

              # The turn was cancelled.
              CANCELLED = T.let(:cancelled, OpenAI::Beta::Agents::Sessions::Turn::Status::TaggedSymbol)

              sig { override.returns(T::Array[OpenAI::Beta::Agents::Sessions::Turn::Status::TaggedSymbol]) }
              def self.values
              end
            end

            class PromptCacheOptions < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions,
                  OpenAI::Internal::AnyHash
                )
              end

              sig { returns(OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions::Ttl::TaggedSymbol) }
              attr_accessor :ttl

              # Prompt cache lifetime selected when this turn started, including an inherited
              # session TTL. Null when the turn used the model default or no TTL was recorded.
              sig do
                params(

                  ttl: OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions::Ttl::OrSymbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                ttl:
              )
              end

              sig do
                override.returns(
                  {ttl: OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions::Ttl::TaggedSymbol}
                )
              end
              def to_hash
              end

              module Ttl
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol = T.type_alias {
                  T.all(Symbol, OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions::Ttl)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                TTL_30M = T.let(:"30m", OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions::Ttl::TaggedSymbol)
                TTL_12H = T.let(:"12h", OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions::Ttl::TaggedSymbol)

                sig {
                  override.returns(
                    T::Array[OpenAI::Beta::Agents::Sessions::Turn::PromptCacheOptions::Ttl::TaggedSymbol]
                  )
                }
                def self.values
                end
              end
            end

          end

        end

      end

    end

  end
end
