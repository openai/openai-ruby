# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # Emitted when there is an additional text delta. This is also the first event
      #   emitted when the transcription starts. Only emitted when you
      #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
      #   with the `Stream` parameter set to `true`.
      module TranscriptionStreamEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Emitted when there is an additional text delta. This is also the first event emitted when the transcription starts. Only emitted when you [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription) with the `Stream` parameter set to `true`.
        variant :"transcript.text.delta", -> { OpenAI::Models::Audio::TranscriptionTextDeltaEvent }

        # Emitted when the transcription is complete. Contains the complete transcription text. Only emitted when you [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription) with the `Stream` parameter set to `true`.
        variant :"transcript.text.done", -> { OpenAI::Models::Audio::TranscriptionTextDoneEvent }

        # @!parse
        #   # @return [Array(OpenAI::Models::Audio::TranscriptionTextDeltaEvent, OpenAI::Models::Audio::TranscriptionTextDoneEvent)]
        #   def self.variants; end
      end
    end
  end
end
