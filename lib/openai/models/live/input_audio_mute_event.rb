# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class InputAudioMuteEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The Live client event type. Always `session.input_audio.mute`.
        #
        #   @return [Symbol, :"session.input_audio.mute"]
        required :type, const: :"session.input_audio.mute"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(event_id: nil, type: :"session.input_audio.mute")
        #   Mute audio input to the Live model without closing the session. The server
        #   acknowledges with `session.input_audio.muted`.
        #
        #   @param event_id [String, nil]
        #     Optional client identifier for correlating this command with a server event's
        #     client_event_id or error.client_event_id.
        #
        #   @param type [Symbol, :"session.input_audio.mute"]
        #     The Live client event type. Always `session.input_audio.mute`.
      end
    end
  end
end
