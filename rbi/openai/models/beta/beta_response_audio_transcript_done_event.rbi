# typed: strong

module OpenAI
  module Models
    BetaResponseAudioTranscriptDoneEvent =
      Beta::BetaResponseAudioTranscriptDoneEvent

    module Beta
      class BetaResponseAudioTranscriptDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseAudioTranscriptDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.audio.transcript.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(OpenAI::Beta::BetaResponseAudioTranscriptDoneEvent::Agent)
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseAudioTranscriptDoneEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when the full audio transcript is completed.
        sig do
          params(
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseAudioTranscriptDoneEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.audio.transcript.done`.
          type: :"response.audio.transcript.done"
        )
        end

        sig do
          override.returns(
            {
              sequence_number: Integer,
              type: Symbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseAudioTranscriptDoneEvent::Agent
                )
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseAudioTranscriptDoneEvent::Agent,
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
