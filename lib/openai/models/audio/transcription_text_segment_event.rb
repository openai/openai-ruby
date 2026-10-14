# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class TranscriptionTextSegmentEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Unique identifier for the segment.
        #
        #   @return [String]
        required :id, String

        # @!attribute end_
        #   End timestamp of the segment in seconds.
        #
        #   @return [Float]
        required :end_, Float, api_name: :end

        # @!attribute speaker
        #   Speaker label for this segment.
        #
        #   @return [String]
        required :speaker, String

        # @!attribute start
        #   Start timestamp of the segment in seconds.
        #
        #   @return [Float]
        required :start, Float

        # @!attribute text
        #   Transcript text for this segment.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the event. Always `transcript.text.segment`.
        #
        #   @return [Symbol, :"transcript.text.segment"]
        required :type, const: :"transcript.text.segment"

        # @!method initialize(id:, end_:, speaker:, start:, text:, type: :"transcript.text.segment")
        #   Emitted when a diarized transcription returns a completed segment with speaker
        #   information. Only emitted when you
        #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   with `stream` set to `true` and `response_format` set to `diarized_json`.
        #
        #   @param id [String] Unique identifier for the segment.
        #
        #   @param end_ [Float] End timestamp of the segment in seconds.
        #
        #   @param speaker [String] Speaker label for this segment.
        #
        #   @param start [Float] Start timestamp of the segment in seconds.
        #
        #   @param text [String] Transcript text for this segment.
        #
        #   @param type [Symbol, :"transcript.text.segment"] The type of the event. Always `transcript.text.segment`.
      end
    end
  end
end
