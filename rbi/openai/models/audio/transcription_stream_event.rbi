# typed: strong

module OpenAI
  module Models
    module Audio
      # Emitted when a diarized transcription returns a completed segment with speaker
      # information. Only emitted when you
      # [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
      # with `stream` set to `true` and `response_format` set to `diarized_json`.
      module TranscriptionStreamEvent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Audio::TranscriptionTextSegmentEvent,
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
