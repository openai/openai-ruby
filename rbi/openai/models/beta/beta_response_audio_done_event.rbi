# typed: strong

module OpenAI
  module Models
    BetaResponseAudioDoneEvent = Beta::BetaResponseAudioDoneEvent

    module Beta
      class BetaResponseAudioDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseAudioDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The sequence number of the delta.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.audio.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(T.nilable(OpenAI::Beta::BetaResponseAudioDoneEvent::Agent))
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(OpenAI::Beta::BetaResponseAudioDoneEvent::Agent::OrHash)
          ).void
        end
        attr_writer :agent

        # Emitted when the audio response is complete.
        sig do
          params(
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseAudioDoneEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The sequence number of the delta.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.audio.done`.
          type: :"response.audio.done"
        )
        end

        sig do
          override.returns(
            {
              sequence_number: Integer,
              type: Symbol,
              agent: T.nilable(OpenAI::Beta::BetaResponseAudioDoneEvent::Agent)
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseAudioDoneEvent::Agent,
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
