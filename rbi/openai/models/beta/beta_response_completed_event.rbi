# typed: strong

module OpenAI
  module Models
    BetaResponseCompletedEvent = Beta::BetaResponseCompletedEvent

    module Beta
      class BetaResponseCompletedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseCompletedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Properties of the completed response.
        sig { returns(OpenAI::Beta::BetaResponse) }
        attr_reader :response

        sig { params(response: OpenAI::Beta::BetaResponse::OrHash).void }
        attr_writer :response

        # The sequence number for this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.completed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(T.nilable(OpenAI::Beta::BetaResponseCompletedEvent::Agent))
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(OpenAI::Beta::BetaResponseCompletedEvent::Agent::OrHash)
          ).void
        end
        attr_writer :agent

        # Emitted when the model response is complete.
        sig do
          params(
            response: OpenAI::Beta::BetaResponse::OrHash,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseCompletedEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Properties of the completed response.
          response:,
          # The sequence number for this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.completed`.
          type: :"response.completed"
        )
        end

        sig do
          override.returns(
            {
              response: OpenAI::Beta::BetaResponse,
              sequence_number: Integer,
              type: Symbol,
              agent: T.nilable(OpenAI::Beta::BetaResponseCompletedEvent::Agent)
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseCompletedEvent::Agent,
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
