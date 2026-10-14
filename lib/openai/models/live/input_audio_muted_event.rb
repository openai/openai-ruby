# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class InputAudioMutedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute type
        #   The event type, always `session.input_audio.muted`.
        #
        #   @return [Symbol, :"session.input_audio.muted"]
        required :type, const: :"session.input_audio.muted"

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!method initialize(event_id:, client_event_id: nil, type: :"session.input_audio.muted")
        #   Returned when a session.input_audio.mute command is accepted. Input audio is no
        #   longer sent to the model; sideband audio reflection continues.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param type [Symbol, :"session.input_audio.muted"]
        #     The event type, always `session.input_audio.muted`.
      end
    end
  end
end
