# typed: strong

module OpenAI
  module Helpers
    module Beta
      module Agents
        class TurnResult
          sig { returns(OpenAI::Models::Beta::Agents::Sessions::Turn) }
          def turn
          end

          sig { returns(T::Array[OpenAI::Models::Beta::AgentSessionMessage]) }
          def messages
          end

          sig { returns(String) }
          def session_id
          end

          sig { returns(String) }
          def turn_id
          end

          sig { returns(String) }
          def output_text
          end
        end

        class ResultError < OpenAI::Errors::Error
          sig { returns(Symbol) }
          def reason
          end

          sig { returns(T.nilable(String)) }
          def session_id
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::Agents::Sessions::Turn)) }
          def turn
          end

          sig { returns(T::Array[OpenAI::Models::Beta::AgentSessionMessage]) }
          def messages
          end

          sig {
            returns(
              T::Array[T.any(OpenAI::Models::Beta::AgentSession::RequiredAction::Variants, OpenAI::Internal::AnyHash)]
            )
          }
          def required_actions
          end

          sig { returns(T.nilable(String)) }
          def turn_id
          end
        end

        class CreationStream < OpenAI::Internal::Stream
          Message = type_member(:in) { {fixed: OpenAI::Internal::Util::ServerSentEvent} }
          Elem = type_member(:out) { {fixed: OpenAI::Models::Beta::AgentSessionEvent::Variants} }

          sig { returns(TurnResult) }
          def get_final_result
          end

          sig { returns(T.self_type) }
          def with_result_collection
          end
        end
      end
    end
  end
end
