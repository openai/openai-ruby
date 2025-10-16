# typed: strong

module OpenAI
  module Models
    module Realtime
      class AudioTranscription < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::AudioTranscription,
              OpenAI::Internal::AnyHash
            )
          end

        # The language of the input audio. Supplying the input language in
        # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
        # format will improve accuracy and latency.
        sig { returns(T.nilable(String)) }
        attr_reader :language

        sig { params(language: String).void }
        attr_writer :language

        # The model to use for transcription. Current options are `whisper-1`,
        # `gpt-4o-mini-transcribe`, `gpt-4o-transcribe`, and `gpt-4o-transcribe-diarize`.
        # Use `gpt-4o-transcribe-diarize` when you need diarization with speaker labels.
        sig do
          returns(
            T.nilable(OpenAI::Realtime::AudioTranscription::Model::OrSymbol)
          )
        end
        attr_reader :model

        sig do
          params(
            model: OpenAI::Realtime::AudioTranscription::Model::OrSymbol
          ).void
        end
        attr_writer :model

        # An optional text to guide the model's style or continue a previous audio
        # segment. For `whisper-1`, the
        # [prompt is a list of keywords](https://platform.openai.com/docs/guides/speech-to-text#prompting).
        # For `gpt-4o-transcribe` models (excluding `gpt-4o-transcribe-diarize`), the
        # prompt is a free text string, for example "expect words related to technology".
        sig { returns(T.nilable(String)) }
        attr_reader :prompt

        sig { params(prompt: String).void }
        attr_writer :prompt

        sig do
          params(
            language: String,
            model: OpenAI::Realtime::AudioTranscription::Model::OrSymbol,
            prompt: String
          ).returns(T.attached_class)
        end
        def self.new(
          # The language of the input audio. Supplying the input language in
          # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
          # format will improve accuracy and latency.
          language: nil,
          # The model to use for transcription. Current options are `whisper-1`,
          # `gpt-4o-mini-transcribe`, `gpt-4o-transcribe`, and `gpt-4o-transcribe-diarize`.
          # Use `gpt-4o-transcribe-diarize` when you need diarization with speaker labels.
          model: nil,
          # An optional text to guide the model's style or continue a previous audio
          # segment. For `whisper-1`, the
          # [prompt is a list of keywords](https://platform.openai.com/docs/guides/speech-to-text#prompting).
          # For `gpt-4o-transcribe` models (excluding `gpt-4o-transcribe-diarize`), the
          # prompt is a free text string, for example "expect words related to technology".
          prompt: nil
        )
        end

        sig do
          override.returns(
            {
              language: String,
              model: OpenAI::Realtime::AudioTranscription::Model::OrSymbol,
              prompt: String
            }
          )
        end
        def to_hash
        end

        # The model to use for transcription. Current options are `whisper-1`,
        # `gpt-4o-mini-transcribe`, `gpt-4o-transcribe`, and `gpt-4o-transcribe-diarize`.
        # Use `gpt-4o-transcribe-diarize` when you need diarization with speaker labels.
        module Model
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Realtime::AudioTranscription::Model)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          WHISPER_1 =
            T.let(
              :"whisper-1",
              OpenAI::Realtime::AudioTranscription::Model::TaggedSymbol
            )
          GPT_4O_MINI_TRANSCRIBE =
            T.let(
              :"gpt-4o-mini-transcribe",
              OpenAI::Realtime::AudioTranscription::Model::TaggedSymbol
            )
          GPT_4O_TRANSCRIBE =
            T.let(
              :"gpt-4o-transcribe",
              OpenAI::Realtime::AudioTranscription::Model::TaggedSymbol
            )
          GPT_4O_TRANSCRIBE_DIARIZE =
            T.let(
              :"gpt-4o-transcribe-diarize",
              OpenAI::Realtime::AudioTranscription::Model::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::AudioTranscription::Model::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
