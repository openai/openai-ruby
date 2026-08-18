# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # Emitted when a diarized transcription returns a completed segment with speaker
      # information. Only emitted when you
      # [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
      # with `stream` set to `true` and `response_format` set to `diarized_json`.
      module TranscriptionStreamEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Emitted when a diarized transcription returns a completed segment with speaker information. Only emitted when you [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription) with `stream` set to `true` and `response_format` set to `diarized_json`.
        variant :"transcript.text.segment", -> { OpenAI::Audio::TranscriptionTextSegmentEvent }

        # Emitted when there is an additional text delta. This is also the first event emitted when the transcription starts. Only emitted when you [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription) with the `Stream` parameter set to `true`.
        variant :"transcript.text.delta", -> { OpenAI::Audio::TranscriptionTextDeltaEvent }

        # Emitted when the transcription is complete. Contains the complete transcription text. Only emitted when you [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription) with the `Stream` parameter set to `true`.
        variant :"transcript.text.done", -> { OpenAI::Audio::TranscriptionTextDoneEvent }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Audio::TranscriptionTextSegmentEvent, OpenAI::Models::Audio::TranscriptionTextDeltaEvent, OpenAI::Models::Audio::TranscriptionTextDoneEvent)]
      end
    end
  end
end
