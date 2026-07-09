# typed: strong

module OpenAI
  module Models
    BetaResponseErrorEvent = Beta::BetaResponseErrorEvent

    module Beta
      class BetaResponseErrorEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseErrorEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The error code.
        sig { returns(T.nilable(String)) }
        attr_accessor :code

        # The error message.
        sig { returns(String) }
        attr_accessor :message

        # The error parameter.
        sig { returns(T.nilable(String)) }
        attr_accessor :param

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `error`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseErrorEvent::Agent)) }
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(OpenAI::Beta::BetaResponseErrorEvent::Agent::OrHash)
          ).void
        end
        attr_writer :agent

        # Emitted when an error occurs.
        sig do
          params(
            code: T.nilable(String),
            message: String,
            param: T.nilable(String),
            sequence_number: Integer,
            agent:
              T.nilable(OpenAI::Beta::BetaResponseErrorEvent::Agent::OrHash),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The error code.
          code:,
          # The error message.
          message:,
          # The error parameter.
          param:,
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `error`.
          type: :error
        )
        end

        sig do
          override.returns(
            {
              code: T.nilable(String),
              message: String,
              param: T.nilable(String),
              sequence_number: Integer,
              type: Symbol,
              agent: T.nilable(OpenAI::Beta::BetaResponseErrorEvent::Agent)
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseErrorEvent::Agent,
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
