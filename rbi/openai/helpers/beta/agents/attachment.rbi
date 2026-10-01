# typed: strong
module OpenAI
  module Helpers
    module Beta
      module Agents
        # @api private
        class Attachment
          sig { returns(T.nilable(OpenAI::Models::Beta::Agents::Sessions::Turn)) }
          attr_reader :turn
          sig { returns(T::Array[T.untyped]) }
          def manual_actions
          end

          sig { returns(T.nilable(T::Boolean)) }
          def current_root?
          end

          sig {
            params(sessions: OpenAI::Resources::Beta::Agents::Sessions, session_id: String, request_options: T.untyped)
              .void
          }
          def initialize(sessions:, session_id:, request_options:)
          end

          sig { void }
          def opened
          end

          sig { params(event: T.untyped).void }
          def observe(event)
          end

          sig { returns(T::Boolean) }
          def settled?
          end

          sig { returns(T::Boolean) }
          def recover_observation
          end

          sig { params(collector: OpenAI::Helpers::Beta::Agents::ResultCollector).void }
          def reconcile(collector)
          end
        end
      end
    end
  end
end
