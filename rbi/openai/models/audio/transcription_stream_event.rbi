# typed: strong

module OpenAI
  module Models
    module Audio
      # Emitted when there is an additional text delta. This is also the first event
      # emitted when the transcription starts. Only emitted when you
      # [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
      # with the `Stream` parameter set to `true`.
      module TranscriptionStreamEvent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Audio::TranscriptionTextDeltaEvent,
              OpenAI::Audio::TranscriptionTextDoneEvent
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::Audio::TranscriptionStreamEvent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
