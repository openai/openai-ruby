# typed: strong

module OpenAI
  module Models

    module Live

      class InputAudioAppendEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::InputAudioAppendEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # Base64-encoded raw audio in the startup-selected format, without a WAV or other
        # container header. Primary WebSocket only; media transports use their audio
        # track. Audio appends have no acknowledgment. Reflected sideband server events
        # reuse this event type and audio key, with no timestamps or event_id; their audio
        # is always mono PCM16LE at 24 kHz.
        sig { returns(String) }
        attr_accessor :audio

        # The Live client event type. Always `session.input_audio.append`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client identifier for correlating this command with a server event's
        # client_event_id or error.client_event_id.
        sig { returns(T.nilable(String)) }
        attr_accessor :event_id

        # Send audio to a Live session over its primary WebSocket. WebRTC and SIP sessions
        # send audio over their media transport.
        sig do
          params(

            audio: String,

            event_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Base64-encoded raw audio in the startup-selected format, without a WAV or other
          # container header. Primary WebSocket only; media transports use their audio
          # track. Audio appends have no acknowledgment. Reflected sideband server events
          # reuse this event type and audio key, with no timestamps or event_id; their audio
          # is always mono PCM16LE at 24 kHz.
          audio:,

          # Optional client identifier for correlating this command with a server event's
          # client_event_id or error.client_event_id.
          event_id: nil,

          # The Live client event type. Always `session.input_audio.append`.

          type: :"session.input_audio.append"
        )
        end

        sig do
          override.returns(
            {audio: String, type: Symbol, event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
