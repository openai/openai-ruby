# typed: strong

module OpenAI
  module Models
    module Audio
      # Emitted when there is an additional text delta. This is also the first event
      #   emitted when the transcription starts. Only emitted when you
      #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
      #   with the `Stream` parameter set to `true`.
      module TranscriptionStreamEvent
        extend OpenAI::Union

        Variants =
          type_template(:out) do
            {
              fixed: T.any(
                OpenAI::Models::Audio::TranscriptionTextDeltaEvent,
                OpenAI::Models::Audio::TranscriptionTextDoneEvent
              )
            }
          end
      end
    end
  end
end
