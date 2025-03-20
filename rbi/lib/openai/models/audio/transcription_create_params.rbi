# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # The audio file object (not file name) to transcribe, in one of these formats:
        #   flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
        sig { returns(T.any(IO, StringIO)) }
        def file
        end

        sig { params(_: T.any(IO, StringIO)).returns(T.any(IO, StringIO)) }
        def file=(_)
        end

        # ID of the model to use. The options are `gpt-4o-transcribe`,
        #   `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
        #   Whisper V2 model).
        sig { returns(T.any(String, OpenAI::Models::AudioModel::OrSymbol)) }
        def model
        end

        sig do
          params(_: T.any(String, OpenAI::Models::AudioModel::OrSymbol))
            .returns(T.any(String, OpenAI::Models::AudioModel::OrSymbol))
        end
        def model=(_)
        end

        # Additional information to include in the transcription response. `logprobs` will
        #   return the log probabilities of the tokens in the response to understand the
        #   model's confidence in the transcription. `logprobs` only works with
        #   response_format set to `json` and only with the models `gpt-4o-transcribe` and
        #   `gpt-4o-mini-transcribe`.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionInclude::OrSymbol])) }
        def include
        end

        sig do
          params(_: T::Array[OpenAI::Models::Audio::TranscriptionInclude::OrSymbol])
            .returns(T::Array[OpenAI::Models::Audio::TranscriptionInclude::OrSymbol])
        end
        def include=(_)
        end

        # The language of the input audio. Supplying the input language in
        #   [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
        #   format will improve accuracy and latency.
        sig { returns(T.nilable(String)) }
        def language
        end

        sig { params(_: String).returns(String) }
        def language=(_)
        end

        # An optional text to guide the model's style or continue a previous audio
        #   segment. The
        #   [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
        #   should match the audio language.
        sig { returns(T.nilable(String)) }
        def prompt
        end

        sig { params(_: String).returns(String) }
        def prompt=(_)
        end

        # The format of the output, in one of these options: `json`, `text`, `srt`,
        #   `verbose_json`, or `vtt`. For `gpt-4o-transcribe` and `gpt-4o-mini-transcribe`,
        #   the only supported format is `json`.
        sig { returns(T.nilable(OpenAI::Models::AudioResponseFormat::OrSymbol)) }
        def response_format
        end

        sig do
          params(_: OpenAI::Models::AudioResponseFormat::OrSymbol)
            .returns(OpenAI::Models::AudioResponseFormat::OrSymbol)
        end
        def response_format=(_)
        end

        # The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #   output more random, while lower values like 0.2 will make it more focused and
        #   deterministic. If set to 0, the model will use
        #   [log probability](https://en.wikipedia.org/wiki/Log_probability) to
        #   automatically increase the temperature until certain thresholds are hit.
        sig { returns(T.nilable(Float)) }
        def temperature
        end

        sig { params(_: Float).returns(Float) }
        def temperature=(_)
        end

        # The timestamp granularities to populate for this transcription.
        #   `response_format` must be set `verbose_json` to use timestamp granularities.
        #   Either or both of these options are supported: `word`, or `segment`. Note: There
        #   is no additional latency for segment timestamps, but generating word timestamps
        #   incurs additional latency.
        sig do
          returns(
            T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol])
          )
        end
        def timestamp_granularities
        end

        sig do
          params(_: T::Array[OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol])
            .returns(T::Array[OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol])
        end
        def timestamp_granularities=(_)
        end

        sig do
          params(
            file: T.any(IO, StringIO),
            model: T.any(String, OpenAI::Models::AudioModel::OrSymbol),
            include: T::Array[OpenAI::Models::Audio::TranscriptionInclude::OrSymbol],
            language: String,
            prompt: String,
            response_format: OpenAI::Models::AudioResponseFormat::OrSymbol,
            temperature: Float,
            timestamp_granularities: T::Array[OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol],
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(
          file:,
          model:,
          include: nil,
          language: nil,
          prompt: nil,
          response_format: nil,
          temperature: nil,
          timestamp_granularities: nil,
          request_options: {}
        )
        end

        sig do
          override
            .returns(
              {
                file: T.any(IO, StringIO),
                model: T.any(String, OpenAI::Models::AudioModel::OrSymbol),
                include: T::Array[OpenAI::Models::Audio::TranscriptionInclude::OrSymbol],
                language: String,
                prompt: String,
                response_format: OpenAI::Models::AudioResponseFormat::OrSymbol,
                temperature: Float,
                timestamp_granularities: T::Array[OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol],
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # ID of the model to use. The options are `gpt-4o-transcribe`,
        #   `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
        #   Whisper V2 model).
        module Model
          extend OpenAI::Union

          Variants = type_template(:out) { {fixed: T.any(String, OpenAI::Models::AudioModel::OrSymbol)} }

          class << self
            sig { override.returns([String, OpenAI::Models::AudioModel::OrSymbol]) }
            def variants
            end
          end
        end

        module TimestampGranularity
          extend OpenAI::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::TaggedSymbol) }

          WORD = T.let(:word, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::TaggedSymbol)
          SEGMENT =
            T.let(:segment, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::TaggedSymbol)

          class << self
            sig do
              override
                .returns(T::Array[OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::TaggedSymbol])
            end
            def values
            end
          end
        end
      end
    end
  end
end
