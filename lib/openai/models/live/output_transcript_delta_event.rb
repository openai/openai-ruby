# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class OutputTranscriptDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The transcript text fragment for the audio in this time range. Append fragments
        #   in delivery order to build the transcript.
        #
        #   @return [String]
        required :delta, String

        # @!attribute end_ms
        #   The end of this event on the Live session timeline, in milliseconds from the
        #   beginning of the session. For appended context, this can equal start_ms.
        #
        #   @return [Integer]
        required :end_ms, Integer

        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute start_ms
        #   The start of this event on the Live session timeline, in milliseconds from the
        #   beginning of the session.
        #
        #   @return [Integer]
        required :start_ms, Integer

        # @!attribute type
        #   The event type, always `session.output_transcript.delta`.
        #
        #   @return [Symbol, :"session.output_transcript.delta"]
        required :type, const: :"session.output_transcript.delta"

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!method initialize(delta:, end_ms:, event_id:, start_ms:, client_event_id: nil, type: :"session.output_transcript.delta")
        #   A transcript fragment for assistant output audio in the Live session. Accumulate
        #   fragments in delivery order; these events do not define complete turns or
        #   include a transcript-done event.
        #
        #   @param delta [String]
        #     The transcript text fragment for the audio in this time range. Append fragments
        #     in delivery order to build the transcript.
        #
        #   @param end_ms [Integer]
        #     The end of this event on the Live session timeline, in milliseconds from the
        #     beginning of the session. For appended context, this can equal start_ms.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param start_ms [Integer]
        #     The start of this event on the Live session timeline, in milliseconds from the
        #     beginning of the session.
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param type [Symbol, :"session.output_transcript.delta"]
        #     The event type, always `session.output_transcript.delta`.
      end
    end
  end
end
