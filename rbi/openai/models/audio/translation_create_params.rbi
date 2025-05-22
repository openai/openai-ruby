# typed: strong

module OpenAI
  module Models
    module Audio
      class TranslationCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Audio::TranslationCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

        # The audio file object (not file name) translate, in one of these formats: flac,
        # mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
        sig { returns(OpenAI::Internal::FileInput) }
        attr_accessor :file

        # ID of the model to use. Only `whisper-1` (which is powered by our open source
        # Whisper V2 model) is currently available.
        sig { returns(T.any(String, OpenAI::AudioModel::OrSymbol)) }
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
        sig do
          returns(
            T.nilable(
              OpenAI::Audio::TranslationCreateParams::ResponseFormat::OrSymbol
            )
          )
        end
        attr_reader :response_format

        sig do
          params(
            response_format:
              OpenAI::Audio::TranslationCreateParams::ResponseFormat::OrSymbol
          ).void
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

        sig do
          params(
            file: OpenAI::Internal::FileInput,
            model: T.any(String, OpenAI::AudioModel::OrSymbol),
            prompt: String,
            response_format:
              OpenAI::Audio::TranslationCreateParams::ResponseFormat::OrSymbol,
            temperature: Float,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
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
        )
        end

        sig do
          override.returns(
            {
              file: OpenAI::Internal::FileInput,
              model: T.any(String, OpenAI::AudioModel::OrSymbol),
              prompt: String,
              response_format:
                OpenAI::Audio::TranslationCreateParams::ResponseFormat::OrSymbol,
              temperature: Float,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # ID of the model to use. Only `whisper-1` (which is powered by our open source
        # Whisper V2 model) is currently available.
        module Model
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias { T.any(String, OpenAI::AudioModel::TaggedSymbol) }

          sig do
            override.returns(
              T::Array[OpenAI::Audio::TranslationCreateParams::Model::Variants]
            )
          end
          def self.variants
          end
        end

        # The format of the output, in one of these options: `json`, `text`, `srt`,
        # `verbose_json`, or `vtt`.
        module ResponseFormat
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Audio::TranslationCreateParams::ResponseFormat
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          JSON =
            T.let(
              :json,
              OpenAI::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol
            )
          TEXT =
            T.let(
              :text,
              OpenAI::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol
            )
          SRT =
            T.let(
              :srt,
              OpenAI::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol
            )
          VERBOSE_JSON =
            T.let(
              :verbose_json,
              OpenAI::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol
            )
          VTT =
            T.let(
              :vtt,
              OpenAI::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Audio::TranslationCreateParams::ResponseFormat::TaggedSymbol
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
