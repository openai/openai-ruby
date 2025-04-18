# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # The audio file object (not file name) to transcribe, in one of these formats:
        # flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
        sig { returns(T.any(Pathname, StringIO)) }
        attr_accessor :file

        # ID of the model to use. The options are `gpt-4o-transcribe`,
        # `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
        # Whisper V2 model).
        sig { returns(T.any(String, OpenAI::Models::AudioModel::OrSymbol)) }
        attr_accessor :model

        # Additional information to include in the transcription response. `logprobs` will
        # return the log probabilities of the tokens in the response to understand the
        # model's confidence in the transcription. `logprobs` only works with
        # response_format set to `json` and only with the models `gpt-4o-transcribe` and
        # `gpt-4o-mini-transcribe`.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionInclude::OrSymbol])) }
        attr_reader :include

        sig { params(include: T::Array[OpenAI::Models::Audio::TranscriptionInclude::OrSymbol]).void }
        attr_writer :include

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
        # should match the audio language.
        sig { returns(T.nilable(String)) }
        attr_reader :prompt

        sig { params(prompt: String).void }
        attr_writer :prompt

        # The format of the output, in one of these options: `json`, `text`, `srt`,
        # `verbose_json`, or `vtt`. For `gpt-4o-transcribe` and `gpt-4o-mini-transcribe`,
        # the only supported format is `json`.
        sig { returns(T.nilable(OpenAI::Models::AudioResponseFormat::OrSymbol)) }
        attr_reader :response_format

        sig { params(response_format: OpenAI::Models::AudioResponseFormat::OrSymbol).void }
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
        # incurs additional latency.
        sig do
          returns(
            T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol])
          )
        end
        attr_reader :timestamp_granularities

        sig do
          params(
            timestamp_granularities: T::Array[OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol]
          )
            .void
        end
        attr_writer :timestamp_granularities

        sig do
          params(
            file: T.any(Pathname, StringIO),
            model: T.any(String, OpenAI::Models::AudioModel::OrSymbol),
            include: T::Array[OpenAI::Models::Audio::TranscriptionInclude::OrSymbol],
            language: String,
            prompt: String,
            response_format: OpenAI::Models::AudioResponseFormat::OrSymbol,
            temperature: Float,
            timestamp_granularities: T::Array[OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::OrSymbol],
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
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
        ); end
        sig do
          override
            .returns(
              {
                file: T.any(Pathname, StringIO),
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
        def to_hash; end

        # ID of the model to use. The options are `gpt-4o-transcribe`,
        # `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source
        # Whisper V2 model).
        module Model
          extend OpenAI::Internal::Type::Union

          sig { override.returns([String, OpenAI::Models::AudioModel::TaggedSymbol]) }
          def self.variants; end
        end

        module TimestampGranularity
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          WORD = T.let(:word, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::TaggedSymbol)
          SEGMENT =
            T.let(:segment, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::TaggedSymbol)

          sig do
            override
              .returns(T::Array[OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity::TaggedSymbol])
          end
          def self.values; end
        end
      end
    end
  end
end
