# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class OutputAudioFixturePlayingEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute type
        #
        #   @return [Symbol, :"session.output_audio.fixture.playing"]
        required :type, const: :"session.output_audio.fixture.playing"

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!method initialize(event_id:, client_event_id: nil, type: :"session.output_audio.fixture.playing")
        #   The existing playback path has accepted the validated audio fixture. This
        #   acknowledgment does not identify when the listener receives the first sample.
        #   The optional client_event_id echoes the play command.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param type [Symbol, :"session.output_audio.fixture.playing"]
      end
    end
  end
end
