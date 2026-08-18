# typed: strong

module OpenAI
  module Models
    BetaResponseFailedEvent = Beta::BetaResponseFailedEvent

    module Beta
      class BetaResponseFailedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseFailedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The response that failed.
        sig { returns(OpenAI::Beta::BetaResponse) }
        attr_reader :response

        sig { params(response: OpenAI::Beta::BetaResponse::OrHash).void }
        attr_writer :response

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.failed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseFailedEvent::Agent)) }
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(OpenAI::Beta::BetaResponseFailedEvent::Agent::OrHash)
          ).void
        end
        attr_writer :agent

        # An event that is emitted when a response fails.
        sig do
          params(
            response: OpenAI::Beta::BetaResponse::OrHash,
            sequence_number: Integer,
            agent:
              T.nilable(OpenAI::Beta::BetaResponseFailedEvent::Agent::OrHash),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The response that failed.
          response:,
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.failed`.
          type: :"response.failed"
        )
        end

        sig do
          override.returns(
            {
              response: OpenAI::Beta::BetaResponse,
              sequence_number: Integer,
              type: Symbol,
              agent: T.nilable(OpenAI::Beta::BetaResponseFailedEvent::Agent)
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseFailedEvent::Agent,
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
