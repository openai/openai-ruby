# typed: strong

module OpenAI
  module Models
    BetaResponseAudioDeltaEvent = Beta::BetaResponseAudioDeltaEvent

    module Beta
      class BetaResponseAudioDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseAudioDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # A chunk of Base64 encoded response audio bytes.
        sig { returns(String) }
        attr_accessor :delta

        # A sequence number for this chunk of the stream response.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.audio.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(T.nilable(OpenAI::Beta::BetaResponseAudioDeltaEvent::Agent))
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseAudioDeltaEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when there is a partial audio response.
        sig do
          params(
            delta: String,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseAudioDeltaEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A chunk of Base64 encoded response audio bytes.
          delta:,
          # A sequence number for this chunk of the stream response.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.audio.delta`.
          type: :"response.audio.delta"
        )
        end

        sig do
          override.returns(
            {
              delta: String,
              sequence_number: Integer,
              type: Symbol,
              agent: T.nilable(OpenAI::Beta::BetaResponseAudioDeltaEvent::Agent)
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseAudioDeltaEvent::Agent,
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
