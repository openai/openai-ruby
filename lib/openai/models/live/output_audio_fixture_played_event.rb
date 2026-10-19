# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class OutputAudioFixturePlayedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute type
        #
        #   @return [Symbol, :"session.output_audio.fixture.played"]
        required :type, const: :"session.output_audio.fixture.played"

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!method initialize(event_id:, client_event_id: nil, type: :"session.output_audio.fixture.played")
        #   The complete audio fixture has drained from the server mixer and normal
        #   inference has resumed. Transport buffers may still contain audio; this event
        #   does not prove listener-side completion. The optional client_event_id echoes the
        #   play command. This event is not emitted for canceled or failed playback.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param type [Symbol, :"session.output_audio.fixture.played"]
      end
    end
  end
end
