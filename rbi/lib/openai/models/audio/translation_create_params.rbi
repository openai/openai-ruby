# typed: strong

module OpenAI
  module Models
    module Audio
      class TranslationCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # The audio file object (not file name) translate, in one of these formats: flac,
        #   mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
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

        # An optional text to guide the model's style or continue a previous audio
        #   segment. The
        #   [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
        #   should be in English.
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

        sig do
          params(
            file: T.any(IO, StringIO),
            model: T.any(String, Symbol),
            prompt: String,
            response_format: Symbol,
            temperature: Float,
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(file:, model:, prompt: nil, response_format: nil, temperature: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                file: T.any(IO, StringIO),
                model: T.any(String, Symbol),
                prompt: String,
                response_format: Symbol,
                temperature: Float,
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
      end
    end
  end
end
