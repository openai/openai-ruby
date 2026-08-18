# typed: strong

module OpenAI
  module Models
    BetaResponseQueuedEvent = Beta::BetaResponseQueuedEvent

    module Beta
      class BetaResponseQueuedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseQueuedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The full response object that is queued.
        sig { returns(OpenAI::Beta::BetaResponse) }
        attr_reader :response

        sig { params(response: OpenAI::Beta::BetaResponse::OrHash).void }
        attr_writer :response

        # The sequence number for this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always 'response.queued'.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseQueuedEvent::Agent)) }
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(OpenAI::Beta::BetaResponseQueuedEvent::Agent::OrHash)
          ).void
        end
        attr_writer :agent

        # Emitted when a response is queued and waiting to be processed.
        sig do
          params(
            response: OpenAI::Beta::BetaResponse::OrHash,
            sequence_number: Integer,
            agent:
              T.nilable(OpenAI::Beta::BetaResponseQueuedEvent::Agent::OrHash),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The full response object that is queued.
          response:,
          # The sequence number for this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always 'response.queued'.
          type: :"response.queued"
        )
        end

        sig do
          override.returns(
            {
              response: OpenAI::Beta::BetaResponse,
              sequence_number: Integer,
              type: Symbol,
              agent: T.nilable(OpenAI::Beta::BetaResponseQueuedEvent::Agent)
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseQueuedEvent::Agent,
                OpenAI::Internal::AnyHash
              )
            end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that owns this multi-agent streaming event.
          sig { params(agent_name: String).returns(T.attached_class) }
          def self.new(
            # The canonical name of the agent that produced this item.
            agent_name:
          )
          end

          sig { override.returns({ agent_name: String }) }
          def to_hash
          end
        end
      end
    end
  end
end
