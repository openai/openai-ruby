# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Audio::TranscriptionCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

        # The audio file object (not file name) to transcribe, in one of these formats:
        # flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
        sig { returns(OpenAI::Internal::FileInput) }
        attr_accessor :file

        # ID of the model to use. The options are `gpt-4o-transcribe`,
        # `gpt-4o-mini-transcribe`, `whisper-1` (which is powered by our open source
        # Whisper V2 model), and `gpt-4o-transcribe-diarize`.
        sig { returns(T.any(String, OpenAI::AudioModel::OrSymbol)) }
        attr_accessor :model

        # Controls how the audio is cut into chunks. When set to `"auto"`, the server
        # first normalizes loudness and then uses voice activity detection (VAD) to choose
        # boundaries. `server_vad` object can be provided to tweak VAD detection
        # parameters manually. If unset, the audio is transcribed as a single block.
        # Required when using `gpt-4o-transcribe-diarize` for inputs longer than 30
        # seconds.
        sig do
          returns(
            T.nilable(
              T.any(
                Symbol,
                OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig
              )
            )
          )
        end
        attr_accessor :chunking_strategy

        # Additional information to include in the transcription response. `logprobs` will
        # return the log probabilities of the tokens in the response to understand the
        # model's confidence in the transcription. `logprobs` only works with
        # response_format set to `json` and only with the models `gpt-4o-transcribe` and
        # `gpt-4o-mini-transcribe`. This field is not supported when using
        # `gpt-4o-transcribe-diarize`.
        sig do
          returns(
            T.nilable(T::Array[OpenAI::Audio::TranscriptionInclude::OrSymbol])
          )
        end
        attr_reader :include

        sig do
          params(
            include: T::Array[OpenAI::Audio::TranscriptionInclude::OrSymbol]
          ).void
        end
        attr_writer :include

        # Optional list of speaker names that correspond to the audio samples provided in
        # `known_speaker_references[]`. Each entry should be a short identifier (for
        # example `customer` or `agent`). Up to 4 speakers are supported.
        sig { returns(T.nilable(T::Array[String])) }
        attr_reader :known_speaker_names

        sig { params(known_speaker_names: T::Array[String]).void }
        attr_writer :known_speaker_names

        # Optional list of audio samples (as
        # [data URLs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URLs))
        # that contain known speaker references matching `known_speaker_names[]`. Each
        # sample must be between 2 and 10 seconds, and can use any of the same input audio
        # formats supported by `file`.
        sig { returns(T.nilable(T::Array[String])) }
        attr_reader :known_speaker_references

        sig { params(known_speaker_references: T::Array[String]).void }
        attr_writer :known_speaker_references

        # The language of the input audio. Supplying the input language in
        # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
        # format will improve accuracy and latency.
        sig { returns(T.nilable(String)) }
        attr_reader :language

        sig { params(language: String).void }
        attr_writer :language

        # An optional text to guide the model's style or continue a previous audio
        # segment. The
        # [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
        # should match the audio language. This field is not supported when using
        # `gpt-4o-transcribe-diarize`.
        sig { returns(T.nilable(String)) }
        attr_reader :prompt

        sig { params(prompt: String).void }
        attr_writer :prompt

        # The format of the output, in one of these options: `json`, `text`, `srt`,
        # `verbose_json`, `vtt`, or `diarized_json`. For `gpt-4o-transcribe` and
        # `gpt-4o-mini-transcribe`, the only supported format is `json`. For
        # `gpt-4o-transcribe-diarize`, the supported formats are `json`, `text`, and
        # `diarized_json`, with `diarized_json` required to receive speaker annotations.
        sig { returns(T.nilable(OpenAI::AudioResponseFormat::OrSymbol)) }
        attr_reader :response_format

        sig do
          params(response_format: OpenAI::AudioResponseFormat::OrSymbol).void
        end
        attr_writer :response_format

        # The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        # output more random, while lower values like 0.2 will make it more focused and
        # deterministic. If set to 0, the model will use
        # [log probability](https://en.wikipedia.org/wiki/Log_probability) to
        # automatically increase the temperature until certain thresholds are hit.
        sig { returns(T.nilable(Float)) }
        attr_reader :temperature

        sig { params(temperature: Float).void }
        attr_writer :temperature

        # The timestamp granularities to populate for this transcription.
        # `response_format` must be set `verbose_json` to use timestamp granularities.
        # Either or both of these options are supported: `word`, or `segment`. Note: There
        # is no additional latency for segment timestamps, but generating word timestamps
        # incurs additional latency. This option is not available for
        # `gpt-4o-transcribe-diarize`.
        sig do
          returns(
            T.nilable(
              T::Array[
                OpenAI::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol
              ]
            )
          )
        end
        attr_reader :timestamp_granularities

        sig do
          params(
            timestamp_granularities:
              T::Array[
                OpenAI::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol
              ]
          ).void
        end
        attr_writer :timestamp_granularities

        sig do
          params(
            file: OpenAI::Internal::FileInput,
            model: T.any(String, OpenAI::AudioModel::OrSymbol),
            chunking_strategy:
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig::OrHash
                )
              ),
            include: T::Array[OpenAI::Audio::TranscriptionInclude::OrSymbol],
            known_speaker_names: T::Array[String],
            known_speaker_references: T::Array[String],
            language: String,
            prompt: String,
            response_format: OpenAI::AudioResponseFormat::OrSymbol,
            temperature: Float,
            timestamp_granularities:
              T::Array[
                OpenAI::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol
              ],
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # The audio file object (not file name) to transcribe, in one of these formats:
          # flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
          file:,
          # ID of the model to use. The options are `gpt-4o-transcribe`,
          # `gpt-4o-mini-transcribe`, `whisper-1` (which is powered by our open source
          # Whisper V2 model), and `gpt-4o-transcribe-diarize`.
          model:,
          # Controls how the audio is cut into chunks. When set to `"auto"`, the server
          # first normalizes loudness and then uses voice activity detection (VAD) to choose
          # boundaries. `server_vad` object can be provided to tweak VAD detection
          # parameters manually. If unset, the audio is transcribed as a single block.
          # Required when using `gpt-4o-transcribe-diarize` for inputs longer than 30
          # seconds.
          chunking_strategy: nil,
          # Additional information to include in the transcription response. `logprobs` will
          # return the log probabilities of the tokens in the response to understand the
          # model's confidence in the transcription. `logprobs` only works with
          # response_format set to `json` and only with the models `gpt-4o-transcribe` and
          # `gpt-4o-mini-transcribe`. This field is not supported when using
          # `gpt-4o-transcribe-diarize`.
          include: nil,
          # Optional list of speaker names that correspond to the audio samples provided in
          # `known_speaker_references[]`. Each entry should be a short identifier (for
          # example `customer` or `agent`). Up to 4 speakers are supported.
          known_speaker_names: nil,
          # Optional list of audio samples (as
          # [data URLs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URLs))
          # that contain known speaker references matching `known_speaker_names[]`. Each
          # sample must be between 2 and 10 seconds, and can use any of the same input audio
          # formats supported by `file`.
          known_speaker_references: nil,
          # The language of the input audio. Supplying the input language in
          # [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
          # format will improve accuracy and latency.
          language: nil,
          # An optional text to guide the model's style or continue a previous audio
          # segment. The
          # [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
          # should match the audio language. This field is not supported when using
          # `gpt-4o-transcribe-diarize`.
          prompt: nil,
          # The format of the output, in one of these options: `json`, `text`, `srt`,
          # `verbose_json`, `vtt`, or `diarized_json`. For `gpt-4o-transcribe` and
          # `gpt-4o-mini-transcribe`, the only supported format is `json`. For
          # `gpt-4o-transcribe-diarize`, the supported formats are `json`, `text`, and
          # `diarized_json`, with `diarized_json` required to receive speaker annotations.
          response_format: nil,
          # The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
          # output more random, while lower values like 0.2 will make it more focused and
          # deterministic. If set to 0, the model will use
          # [log probability](https://en.wikipedia.org/wiki/Log_probability) to
          # automatically increase the temperature until certain thresholds are hit.
          temperature: nil,
          # The timestamp granularities to populate for this transcription.
          # `response_format` must be set `verbose_json` to use timestamp granularities.
          # Either or both of these options are supported: `word`, or `segment`. Note: There
          # is no additional latency for segment timestamps, but generating word timestamps
          # incurs additional latency. This option is not available for
          # `gpt-4o-transcribe-diarize`.
          timestamp_granularities: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              file: OpenAI::Internal::FileInput,
              model: T.any(String, OpenAI::AudioModel::OrSymbol),
              chunking_strategy:
                T.nilable(
                  T.any(
                    Symbol,
                    OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig
                  )
                ),
              include: T::Array[OpenAI::Audio::TranscriptionInclude::OrSymbol],
              known_speaker_names: T::Array[String],
              known_speaker_references: T::Array[String],
              language: String,
              prompt: String,
              response_format: OpenAI::AudioResponseFormat::OrSymbol,
              temperature: Float,
              timestamp_granularities:
                T::Array[
                  OpenAI::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol
                ],
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # ID of the model to use. The options are `gpt-4o-transcribe`,
        # `gpt-4o-mini-transcribe`, `whisper-1` (which is powered by our open source
        # Whisper V2 model), and `gpt-4o-transcribe-diarize`.
        module Model
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias { T.any(String, OpenAI::AudioModel::TaggedSymbol) }

          sig do
            override.returns(
              T::Array[
                OpenAI::Audio::TranscriptionCreateParams::Model::Variants
              ]
            )
          end
          def self.variants
          end
        end

        # Controls how the audio is cut into chunks. When set to `"auto"`, the server
        # first normalizes loudness and then uses voice activity detection (VAD) to choose
        # boundaries. `server_vad` object can be provided to tweak VAD detection
        # parameters manually. If unset, the audio is transcribed as a single block.
        # Required when using `gpt-4o-transcribe-diarize` for inputs longer than 30
        # seconds.
        module ChunkingStrategy
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                Symbol,
                OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig
              )
            end

          class VadConfig < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig,
                  OpenAI::Internal::AnyHash
                )
              end

            # Must be set to `server_vad` to enable manual chunking using server side VAD.
            sig do
              returns(
                OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig::Type::OrSymbol
              )
            end
            attr_accessor :type

            # Amount of audio to include before the VAD detected speech (in milliseconds).
            sig { returns(T.nilable(Integer)) }
            attr_reader :prefix_padding_ms

            sig { params(prefix_padding_ms: Integer).void }
            attr_writer :prefix_padding_ms

            # Duration of silence to detect speech stop (in milliseconds). With shorter values
            # the model will respond more quickly, but may jump in on short pauses from the
            # user.
            sig { returns(T.nilable(Integer)) }
            attr_reader :silence_duration_ms

            sig { params(silence_duration_ms: Integer).void }
            attr_writer :silence_duration_ms

            # Sensitivity threshold (0.0 to 1.0) for voice activity detection. A higher
            # threshold will require louder audio to activate the model, and thus might
            # perform better in noisy environments.
            sig { returns(T.nilable(Float)) }
            attr_reader :threshold

            sig { params(threshold: Float).void }
            attr_writer :threshold

            sig do
              params(
                type:
                  OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig::Type::OrSymbol,
                prefix_padding_ms: Integer,
                silence_duration_ms: Integer,
                threshold: Float
              ).returns(T.attached_class)
            end
            def self.new(
              # Must be set to `server_vad` to enable manual chunking using server side VAD.
              type:,
              # Amount of audio to include before the VAD detected speech (in milliseconds).
              prefix_padding_ms: nil,
              # Duration of silence to detect speech stop (in milliseconds). With shorter values
              # the model will respond more quickly, but may jump in on short pauses from the
              # user.
              silence_duration_ms: nil,
              # Sensitivity threshold (0.0 to 1.0) for voice activity detection. A higher
              # threshold will require louder audio to activate the model, and thus might
              # perform better in noisy environments.
              threshold: nil
            )
            end

            sig do
              override.returns(
                {
                  type:
                    OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig::Type::OrSymbol,
                  prefix_padding_ms: Integer,
                  silence_duration_ms: Integer,
                  threshold: Float
                }
              )
            end
            def to_hash
            end

            # Must be set to `server_vad` to enable manual chunking using server side VAD.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig::Type
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              SERVER_VAD =
                T.let(
                  :server_vad,
                  OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig::Type::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::Variants
              ]
            )
          end
          def self.variants
          end
        end

        module TimestampGranularity
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Audio::TranscriptionCreateParams::TimestampGranularity
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          WORD =
            T.let(
              :word,
              OpenAI::Audio::TranscriptionCreateParams::TimestampGranularity::TaggedSymbol
            )
          SEGMENT =
            T.let(
              :segment,
              OpenAI::Audio::TranscriptionCreateParams::TimestampGranularity::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Audio::TranscriptionCreateParams::TimestampGranularity::TaggedSymbol
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
