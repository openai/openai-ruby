# typed: strong

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferDtmfEventReceivedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::InputAudioBufferDtmfEventReceivedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The telephone keypad that was pressed by the user.
        sig { returns(String) }
        attr_accessor :event

        # UTC Unix Timestamp when DTMF Event was received by server.
        sig { returns(Integer) }
        attr_accessor :received_at

        # The event type, must be `input_audio_buffer.dtmf_event_received`.
        sig { returns(Symbol) }
        attr_accessor :type

        # **SIP Only:** Returned when an DTMF event is received. A DTMF event is a message
        # that represents a telephone keypad press (0–9, \*, #, A–D). The `event` property
        # is the keypad that the user press. The `received_at` is the UTC Unix Timestamp
        # that the server received the event.
        sig do
          params(event: String, received_at: Integer, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # The telephone keypad that was pressed by the user.
          event:,
          # UTC Unix Timestamp when DTMF Event was received by server.
          received_at:,
          # The event type, must be `input_audio_buffer.dtmf_event_received`.
          type: :"input_audio_buffer.dtmf_event_received"
        )
        end

        sig do
          override.returns(
            { event: String, received_at: Integer, type: Symbol }
          )
        end
        def to_hash
        end
      end
    end
  end
end
