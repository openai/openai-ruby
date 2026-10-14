# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class InputAudioAppendEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute audio
        #   Base64-encoded raw audio in the startup-selected format, without a WAV or other
        #   container header. Primary WebSocket only; media transports use their audio
        #   track. Audio appends have no acknowledgment. Reflected sideband server events
        #   reuse this event type and audio key, with no timestamps or event_id; their audio
        #   is always mono PCM16LE at 24 kHz.
        #
        #   @return [String]
        required :audio, String

        # @!attribute type
        #   The Live client event type. Always `session.input_audio.append`.
        #
        #   @return [Symbol, :"session.input_audio.append"]
        required :type, const: :"session.input_audio.append"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(audio:, event_id: nil, type: :"session.input_audio.append")
        #   Send audio to a Live session over its primary WebSocket. WebRTC and SIP sessions
        #   send audio over their media transport.
        #
        #   @param audio [String]
        #     Base64-encoded raw audio in the startup-selected format, without a WAV or other
        #     container header. Primary WebSocket only; media transports use their audio
        #     track. Audio appends have no acknowledgment. Reflected sideband server events
        #     reuse this event type and audio key, with no timestamps or event_id; their audio
        #     is always mono PCM16LE at 24 kHz.
        #
        #   @param event_id [String, nil]
        #     Optional client identifier for correlating this command with a server event's
        #     client_event_id or error.client_event_id.
        #
        #   @param type [Symbol, :"session.input_audio.append"]
        #     The Live client event type. Always `session.input_audio.append`.
      end
    end
  end
end
