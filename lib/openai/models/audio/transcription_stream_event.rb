# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @abstract
      #
      # Emitted when there is an additional text delta. This is also the first event
      #   emitted when the transcription starts. Only emitted when you
      #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
      #   with the `Stream` parameter set to `true`.
      class TranscriptionStreamEvent < OpenAI::Union
        discriminator :type

        # Emitted when there is an additional text delta. This is also the first event emitted when the transcription starts. Only emitted when you [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription) with the `Stream` parameter set to `true`.
        variant :"transcript.text.delta", -> { OpenAI::Models::Audio::TranscriptionTextDeltaEvent }

        # Emitted when the transcription is complete. Contains the complete transcription text. Only emitted when you [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription) with the `Stream` parameter set to `true`.
        variant :"transcript.text.done", -> { OpenAI::Models::Audio::TranscriptionTextDoneEvent }

        # @!parse
        #   class << self
        #     # @return [Array(OpenAI::Models::Audio::TranscriptionTextDeltaEvent, OpenAI::Models::Audio::TranscriptionTextDoneEvent)]
        #     def variants; end
        #   end
      end
    end
  end
end
