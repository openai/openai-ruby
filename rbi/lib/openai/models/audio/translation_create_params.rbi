# typed: strong

module OpenAI
  module Models
    module Audio
      class TranslationCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # The audio file object (not file name) translate, in one of these formats: flac,
        # mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
        sig { returns(T.any(Pathname, StringIO)) }
        attr_accessor :file

        # ID of the model to use. Only `whisper-1` (which is powered by our open source
        # Whisper V2 model) is currently available.
        sig { returns(T.any(String, OpenAI::Models::AudioModel::OrSymbol)) }
        attr_accessor :model

        # An optional text to guide the model's style or continue a previous audio
        # segment. The
        # [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
        # should be in English.
        sig { returns(T.nilable(String)) }
        attr_reader :prompt

        sig { params(prompt: String).void }
        attr_writer :prompt

        # The format of the output, in one of these options: `json`, `text`, `srt`,
        # `verbose_json`, or `vtt`.
        sig { returns(T.nilable(OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::OrSymbol)) }
        attr_reader :response_format

        sig { params(response_format: OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::OrSymbol).void }
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

        sig do
          params(
            file: T.any(Pathname, StringIO),
            model: T.any(String, OpenAI::Models::AudioModel::OrSymbol),
            prompt: String,
            response_format: OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::OrSymbol,
            temperature: Float,
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(
          # The audio file object (not file name) translate, in one of these formats: flac,
          # mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
          file:,
          # ID of the model to use. Only `whisper-1` (which is powered by our open source
          # Whisper V2 model) is currently available.
          model:,
          # An optional text to guide the model's style or continue a previous audio
          # segment. The
          # [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
          # should be in English.
          prompt: nil,
          # The format of the output, in one of these options: `json`, `text`, `srt`,
          # `verbose_json`, or `vtt`.
          response_format: nil,
          # The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
          # output more random, while lower values like 0.2 will make it more focused and
          # deterministic. If set to 0, the model will use
          # [log probability](https://en.wikipedia.org/wiki/Log_probability) to
          # automatically increase the temperature until certain thresholds are hit.
          temperature: nil,
          request_options: {}
        ); end
        sig do
          override
            .returns(
              {
                file: T.any(Pathname, StringIO),
                model: T.any(String, OpenAI::Models::AudioModel::OrSymbol),
                prompt: String,
                response_format: OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::OrSymbol,
                temperature: Float,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash; end

        # ID of the model to use. Only `whisper-1` (which is powered by our open source
        # Whisper V2 model) is currently available.
        module Model
          extend OpenAI::Internal::Type::Union

          sig { override.returns([String, OpenAI::Models::AudioModel::TaggedSymbol]) }
          def self.variants; end
        end

        # The format of the output, in one of these options: `json`, `text`, `srt`,
        # `verbose_json`, or `vtt`.
        module ResponseFormat
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          JSON = T.let(:json, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol)
          TEXT = T.let(:text, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol)
          SRT = T.let(:srt, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol)
          VERBOSE_JSON =
            T.let(:verbose_json, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol)
          VTT = T.let(:vtt, OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol]) }
          def self.values; end
        end
      end
    end
  end
end
