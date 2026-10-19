# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class OutputAudioFixturePlayEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute audio
        #   Base64-encoded raw mono PCM16 audio, little-endian, at 24 kHz. Do not include a
        #   WAV or other container header.
        #
        #   @return [String]
        required :audio, String

        # @!attribute type
        #
        #   @return [Symbol, :"session.output_audio.fixture.play"]
        required :type, const: :"session.output_audio.fixture.play"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(audio:, event_id: nil, type: :"session.output_audio.fixture.play")
        #   Play one complete audio fixture through the session output. Send this event over
        #   the primary WebSocket or a server sideband. Audio must be raw mono PCM16
        #   little-endian at 24 kHz, regardless of the session audio format, and at most 30
        #   seconds. The entire payload is validated before model speech is interrupted and
        #   input is muted. Only one fixture can be active. fixture.playing acknowledges
        #   acceptance and fixture.played reports server mixer drain. These notifications
        #   are not exact transport-media boundaries. Input arriving during playback is
        #   dropped and not replayed.
        #
        #   @param audio [String]
        #     Base64-encoded raw mono PCM16 audio, little-endian, at 24 kHz. Do not include a
        #     WAV or other container header.
        #
        #   @param event_id [String, nil]
        #     Optional client identifier for correlating this command with a server event's
        #     client_event_id or error.client_event_id.
        #
        #   @param type [Symbol, :"session.output_audio.fixture.play"]
      end
    end
  end
end
