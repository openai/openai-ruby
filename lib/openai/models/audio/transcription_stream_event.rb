# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # Emitted when there is an additional text delta. This is also the first event
      # emitted when the transcription starts. Only emitted when you
      # [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
      # with the `Stream` parameter set to `true`.
      module TranscriptionStreamEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Emitted when there is an additional text delta. This is also the first event emitted when the transcription starts. Only emitted when you [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription) with the `Stream` parameter set to `true`.
        variant :"transcript.text.delta", -> { OpenAI::Audio::TranscriptionTextDeltaEvent }

        # Emitted when the transcription is complete. Contains the complete transcription text. Only emitted when you [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription) with the `Stream` parameter set to `true`.
        variant :"transcript.text.done", -> { OpenAI::Audio::TranscriptionTextDoneEvent }

        # @!method self.variants
        #   @return [Array(OpenAI::Audio::TranscriptionTextDeltaEvent, OpenAI::Audio::TranscriptionTextDoneEvent)]

        define_sorbet_constant!(:Variants) do
          T.type_alias do
            T.any(OpenAI::Audio::TranscriptionTextDeltaEvent, OpenAI::Audio::TranscriptionTextDoneEvent)
          end
        end
      end
    end
  end
end
