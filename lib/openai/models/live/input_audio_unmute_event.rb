# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class InputAudioUnmuteEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The Live client event type. Always `session.input_audio.unmute`.
        #
        #   @return [Symbol, :"session.input_audio.unmute"]
        required :type, const: :"session.input_audio.unmute"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(event_id: nil, type: :"session.input_audio.unmute")
        #   Resume audio input to a Live model after muting it. The server acknowledges with
        #   `session.input_audio.unmuted`.
        #
        #   @param event_id [String, nil]
        #     Optional client identifier for correlating this command with a server event's
        #     client_event_id or error.client_event_id.
        #
        #   @param type [Symbol, :"session.input_audio.unmute"]
        #     The Live client event type. Always `session.input_audio.unmute`.
      end
    end
  end
end
