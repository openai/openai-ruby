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

        # Controls how long the model waits before emitting transcription text. Higher
        # values can improve transcription accuracy at the cost of latency. Only supported
        # with `gpt-realtime-whisper` in GA Realtime sessions.
        sig do
          returns(
            T.nilable(OpenAI::Realtime::AudioTranscription::Delay::OrSymbol)
          )
        end
        attr_reader :delay

        sig do
          params(
            delay: OpenAI::Realtime::AudioTranscription::Delay::OrSymbol
          ).void
        end
        attr_writer :delay

        # The language of the input audio. Supplying the input language in
        # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
        # format will improve accuracy and latency.
        sig { returns(T.nilable(String)) }
        attr_reader :language

        sig { params(language: String).void }
        attr_writer :language

        # The model to use for transcription. Current options are `whisper-1`,
        # `gpt-4o-mini-transcribe`, `gpt-4o-mini-transcribe-2025-12-15`,
        # `gpt-4o-transcribe`, `gpt-4o-transcribe-diarize`, and `gpt-realtime-whisper`.
        # Use `gpt-4o-transcribe-diarize` when you need diarization with speaker labels.
        sig do
          returns(
            T.nilable(
              T.any(
                String,
                OpenAI::Realtime::AudioTranscription::Model::OrSymbol
              )
            )
          )
        end
        attr_reader :model

        sig do
          params(
            model:
              T.any(
                String,
                OpenAI::Realtime::AudioTranscription::Model::OrSymbol
              )
          ).void
        end
        attr_writer :model

        # An optional text to guide the model's style or continue a previous audio
        # segment. For `whisper-1`, the
        # [prompt is a list of keywords](https://platform.openai.com/docs/guides/speech-to-text#prompting).
        # For `gpt-4o-transcribe` models (excluding `gpt-4o-transcribe-diarize`), the
        # prompt is a free text string, for example "expect words related to technology".
        # Prompt is not supported with `gpt-realtime-whisper` in GA Realtime sessions.
        sig { returns(T.nilable(String)) }
        attr_reader :prompt

        sig { params(prompt: String).void }
        attr_writer :prompt

        sig do
          params(
            delay: OpenAI::Realtime::AudioTranscription::Delay::OrSymbol,
            language: String,
            model:
              T.any(
                String,
                OpenAI::Realtime::AudioTranscription::Model::OrSymbol
              ),
            prompt: String
          ).returns(T.attached_class)
        end
        def self.new(
          # Controls how long the model waits before emitting transcription text. Higher
          # values can improve transcription accuracy at the cost of latency. Only supported
          # with `gpt-realtime-whisper` in GA Realtime sessions.
          delay: nil,
          # The language of the input audio. Supplying the input language in
          # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
          # format will improve accuracy and latency.
          language: nil,
          # The model to use for transcription. Current options are `whisper-1`,
          # `gpt-4o-mini-transcribe`, `gpt-4o-mini-transcribe-2025-12-15`,
          # `gpt-4o-transcribe`, `gpt-4o-transcribe-diarize`, and `gpt-realtime-whisper`.
          # Use `gpt-4o-transcribe-diarize` when you need diarization with speaker labels.
          model: nil,
          # An optional text to guide the model's style or continue a previous audio
          # segment. For `whisper-1`, the
          # [prompt is a list of keywords](https://platform.openai.com/docs/guides/speech-to-text#prompting).
          # For `gpt-4o-transcribe` models (excluding `gpt-4o-transcribe-diarize`), the
          # prompt is a free text string, for example "expect words related to technology".
          # Prompt is not supported with `gpt-realtime-whisper` in GA Realtime sessions.
          prompt: nil
        )
        end

        sig do
          override.returns(
            {
              delay: OpenAI::Realtime::AudioTranscription::Delay::OrSymbol,
              language: String,
              model:
                T.any(
                  String,
                  OpenAI::Realtime::AudioTranscription::Model::OrSymbol
                ),
              prompt: String
            }
          )
        end
        def to_hash
        end

        # Controls how long the model waits before emitting transcription text. Higher
        # values can improve transcription accuracy at the cost of latency. Only supported
        # with `gpt-realtime-whisper` in GA Realtime sessions.
        module Delay
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Realtime::AudioTranscription::Delay)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MINIMAL =
            T.let(
              :minimal,
              OpenAI::Realtime::AudioTranscription::Delay::TaggedSymbol
            )
          LOW =
            T.let(
              :low,
              OpenAI::Realtime::AudioTranscription::Delay::TaggedSymbol
            )
          MEDIUM =
            T.let(
              :medium,
              OpenAI::Realtime::AudioTranscription::Delay::TaggedSymbol
            )
          HIGH =
            T.let(
              :high,
              OpenAI::Realtime::AudioTranscription::Delay::TaggedSymbol
            )
          XHIGH =
            T.let(
              :xhigh,
              OpenAI::Realtime::AudioTranscription::Delay::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::AudioTranscription::Delay::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The model to use for transcription. Current options are `whisper-1`,
        # `gpt-4o-mini-transcribe`, `gpt-4o-mini-transcribe-2025-12-15`,
        # `gpt-4o-transcribe`, `gpt-4o-transcribe-diarize`, and `gpt-realtime-whisper`.
        # Use `gpt-4o-transcribe-diarize` when you need diarization with speaker labels.
        module Model
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                OpenAI::Realtime::AudioTranscription::Model::TaggedSymbol
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Realtime::AudioTranscription::Model::Variants]
            )
          end
          def self.variants
          end

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
          GPT_4O_MINI_TRANSCRIBE_2025_12_15 =
            T.let(
              :"gpt-4o-mini-transcribe-2025-12-15",
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
          GPT_REALTIME_WHISPER =
            T.let(
              :"gpt-realtime-whisper",
              OpenAI::Realtime::AudioTranscription::Model::TaggedSymbol
            )
        end
      end
    end
  end
end
