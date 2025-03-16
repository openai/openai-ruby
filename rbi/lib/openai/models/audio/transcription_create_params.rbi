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

        # ID of the model to use. Only `whisper-1` (which is powered by our open source
        #   Whisper V2 model) is currently available.
        sig { returns(T.any(String, Symbol)) }
        def model
        end

        sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
        def model=(_)
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
        #   `verbose_json`, or `vtt`.
        sig { returns(T.nilable(Symbol)) }
        def response_format
        end

        sig { params(_: Symbol).returns(Symbol) }
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
        sig { returns(T.nilable(T::Array[Symbol])) }
        def timestamp_granularities
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def timestamp_granularities=(_)
        end

        sig do
          params(
            file: T.any(IO, StringIO),
            model: T.any(String, Symbol),
            language: String,
            prompt: String,
            response_format: Symbol,
            temperature: Float,
            timestamp_granularities: T::Array[Symbol],
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(
          file:,
          model:,
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
                model: T.any(String, Symbol),
                language: String,
                prompt: String,
                response_format: Symbol,
                temperature: Float,
                timestamp_granularities: T::Array[Symbol],
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # ID of the model to use. Only `whisper-1` (which is powered by our open source
        #   Whisper V2 model) is currently available.
        class Model < OpenAI::Union
          abstract!

          Variants = type_template(:out) { {fixed: T.any(String, Symbol)} }
        end

        class TimestampGranularity < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          WORD = :word
          SEGMENT = :segment
        end
      end
    end
  end
end
