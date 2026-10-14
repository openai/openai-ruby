# typed: strong

module OpenAI
  module Models
    BetaResponseAudioTranscriptDeltaEvent =
      Beta::BetaResponseAudioTranscriptDeltaEvent

    module Beta
      class BetaResponseAudioTranscriptDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseAudioTranscriptDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The partial transcript of the audio response.
        sig { returns(String) }
        attr_accessor :delta

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.audio.transcript.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseAudioTranscriptDeltaEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseAudioTranscriptDeltaEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when there is a partial transcript of audio.
        sig do
          params(
            delta: String,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseAudioTranscriptDeltaEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The partial transcript of the audio response.
          delta:,
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.audio.transcript.delta`.
          type: :"response.audio.transcript.delta"
        )
        end

        sig do
          override.returns(
            {
              delta: String,
              sequence_number: Integer,
              type: Symbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseAudioTranscriptDeltaEvent::Agent
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
                OpenAI::Beta::BetaResponseAudioTranscriptDeltaEvent::Agent,
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
