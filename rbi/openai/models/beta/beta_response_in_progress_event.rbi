# typed: strong

module OpenAI
  module Models
    BetaResponseInProgressEvent = Beta::BetaResponseInProgressEvent

    module Beta
      class BetaResponseInProgressEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseInProgressEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The response that is in progress.
        sig { returns(OpenAI::Beta::BetaResponse) }
        attr_reader :response

        sig { params(response: OpenAI::Beta::BetaResponse::OrHash).void }
        attr_writer :response

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.in_progress`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(T.nilable(OpenAI::Beta::BetaResponseInProgressEvent::Agent))
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseInProgressEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when the response is in progress.
        sig do
          params(
            response: OpenAI::Beta::BetaResponse::OrHash,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseInProgressEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The response that is in progress.
          response:,
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.in_progress`.
          type: :"response.in_progress"
        )
        end

        sig do
          override.returns(
            {
              response: OpenAI::Beta::BetaResponse,
              sequence_number: Integer,
              type: Symbol,
              agent: T.nilable(OpenAI::Beta::BetaResponseInProgressEvent::Agent)
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseInProgressEvent::Agent,
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
