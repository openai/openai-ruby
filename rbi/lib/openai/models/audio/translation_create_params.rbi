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
        sig { returns(T.any(String, OpenAI::Models::AudioModel::OrSymbol)) }
        def model
        end

        sig do
          params(_: T.any(String, OpenAI::Models::AudioModel::OrSymbol))
            .returns(T.any(String, OpenAI::Models::AudioModel::OrSymbol))
        end
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
        sig { returns(T.nilable(OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::OrSymbol)) }
        def response_format
        end

        sig do
          params(_: OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::OrSymbol)
            .returns(OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::OrSymbol)
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

        sig do
          params(
            file: T.any(IO, StringIO),
            model: T.any(String, OpenAI::Models::AudioModel::OrSymbol),
            prompt: String,
            response_format: OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::OrSymbol,
            temperature: Float,
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
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
                model: T.any(String, OpenAI::Models::AudioModel::OrSymbol),
                prompt: String,
                response_format: OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::OrSymbol,
                temperature: Float,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # ID of the model to use. Only `whisper-1` (which is powered by our open source
        #   Whisper V2 model) is currently available.
        module Model
          extend OpenAI::Union

          Variants = type_template(:out) { {fixed: T.any(String, OpenAI::Models::AudioModel::OrSymbol)} }

          class << self
            sig { override.returns([String, OpenAI::Models::AudioModel::OrSymbol]) }
            def variants
            end
          end
        end

        # The format of the output, in one of these options: `json`, `text`, `srt`,
        #   `verbose_json`, or `vtt`.
        module ResponseFormat
          extend OpenAI::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol) }

          JSON = T.let(:json, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol)
          TEXT = T.let(:text, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol)
          SRT = T.let(:srt, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol)
          VERBOSE_JSON =
            T.let(:verbose_json, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol)
          VTT = T.let(:vtt, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
