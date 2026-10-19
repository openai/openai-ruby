# typed: strong

module OpenAI
  module Models

    module Live

      class OutputAudioFixturePlayEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::OutputAudioFixturePlayEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # Base64-encoded raw mono PCM16 audio, little-endian, at 24 kHz. Do not include a
        # WAV or other container header.
        sig { returns(String) }
        attr_accessor :audio

        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client identifier for correlating this command with a server event's
        # client_event_id or error.client_event_id.
        sig { returns(T.nilable(String)) }
        attr_accessor :event_id

        # Play one complete audio fixture through the session output. Send this event over
        # the primary WebSocket or a server sideband. Audio must be raw mono PCM16
        # little-endian at 24 kHz, regardless of the session audio format, and at most 30
        # seconds. The entire payload is validated before model speech is interrupted and
        # input is muted. Only one fixture can be active. fixture.playing acknowledges
        # acceptance and fixture.played reports server mixer drain. These notifications
        # are not exact transport-media boundaries. Input arriving during playback is
        # dropped and not replayed.
        sig do
          params(

            audio: String,

            event_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Base64-encoded raw mono PCM16 audio, little-endian, at 24 kHz. Do not include a
          # WAV or other container header.
          audio:,

          # Optional client identifier for correlating this command with a server event's
          # client_event_id or error.client_event_id.
          event_id: nil,

          type: :"session.output_audio.fixture.play"
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
