# typed: strong

module OpenAI
  module Models
    module Audio
      # Emitted when there is an additional text delta. This is also the first event
      #   emitted when the transcription starts. Only emitted when you
      #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
      #   with the `Stream` parameter set to `true`.
      module TranscriptionStreamEvent
        extend OpenAI::Internal::Type::Union

        sig do
          override
            .returns(
              [OpenAI::Models::Audio::TranscriptionTextDeltaEvent, OpenAI::Models::Audio::TranscriptionTextDoneEvent]
            )
        end
        def self.variants
        end
      end
    end
  end
end
