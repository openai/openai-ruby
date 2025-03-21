# typed: strong

module OpenAI
  module Models
    module Audio
      class SpeechCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # The text to generate audio for. The maximum length is 4096 characters.
        sig { returns(String) }
        attr_accessor :input

        # One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        #   `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
        sig { returns(T.any(String, OpenAI::Models::Audio::SpeechModel::OrSymbol)) }
        attr_accessor :model

        # The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
        #   `coral`, `echo`, `fable`, `onyx`, `nova`, `sage` and `shimmer`. Previews of the
        #   voices are available in the
        #   [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
        sig { returns(OpenAI::Models::Audio::SpeechCreateParams::Voice::OrSymbol) }
        attr_accessor :voice

        # Control the voice of your generated audio with additional instructions. Does not
        #   work with `tts-1` or `tts-1-hd`.
        sig { returns(T.nilable(String)) }
        attr_reader :instructions

        sig { params(instructions: String).void }
        attr_writer :instructions

        # The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
        #   `wav`, and `pcm`.
        sig { returns(T.nilable(OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat::OrSymbol)) }
        attr_reader :response_format

        sig { params(response_format: OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat::OrSymbol).void }
        attr_writer :response_format

        # The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is
        #   the default.
        sig { returns(T.nilable(Float)) }
        attr_reader :speed

        sig { params(speed: Float).void }
        attr_writer :speed

        sig do
          params(
            input: String,
            model: T.any(String, OpenAI::Models::Audio::SpeechModel::OrSymbol),
            voice: OpenAI::Models::Audio::SpeechCreateParams::Voice::OrSymbol,
            instructions: String,
            response_format: OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat::OrSymbol,
            speed: Float,
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(input:, model:, voice:, instructions: nil, response_format: nil, speed: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                input: String,
                model: T.any(String, OpenAI::Models::Audio::SpeechModel::OrSymbol),
                voice: OpenAI::Models::Audio::SpeechCreateParams::Voice::OrSymbol,
                instructions: String,
                response_format: OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat::OrSymbol,
                speed: Float,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        #   `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
        module Model
          extend OpenAI::Union

          sig { override.returns([String, OpenAI::Models::Audio::SpeechModel::OrSymbol]) }
          def self.variants
          end
        end

        # The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
        #   `coral`, `echo`, `fable`, `onyx`, `nova`, `sage` and `shimmer`. Previews of the
        #   voices are available in the
        #   [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
        module Voice
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Audio::SpeechCreateParams::Voice) }
          OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::Audio::SpeechCreateParams::Voice::TaggedSymbol) }

          ALLOY = T.let(:alloy, OpenAI::Models::Audio::SpeechCreateParams::Voice::TaggedSymbol)
          ASH = T.let(:ash, OpenAI::Models::Audio::SpeechCreateParams::Voice::TaggedSymbol)
          CORAL = T.let(:coral, OpenAI::Models::Audio::SpeechCreateParams::Voice::TaggedSymbol)
          ECHO = T.let(:echo, OpenAI::Models::Audio::SpeechCreateParams::Voice::TaggedSymbol)
          FABLE = T.let(:fable, OpenAI::Models::Audio::SpeechCreateParams::Voice::TaggedSymbol)
          ONYX = T.let(:onyx, OpenAI::Models::Audio::SpeechCreateParams::Voice::TaggedSymbol)
          NOVA = T.let(:nova, OpenAI::Models::Audio::SpeechCreateParams::Voice::TaggedSymbol)
          SAGE = T.let(:sage, OpenAI::Models::Audio::SpeechCreateParams::Voice::TaggedSymbol)
          SHIMMER = T.let(:shimmer, OpenAI::Models::Audio::SpeechCreateParams::Voice::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Audio::SpeechCreateParams::Voice::TaggedSymbol]) }
          def self.values
          end
        end

        # The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
        #   `wav`, and `pcm`.
        module ResponseFormat
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol) }

          MP3 = T.let(:mp3, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol)
          OPUS = T.let(:opus, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol)
          AAC = T.let(:aac, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol)
          FLAC = T.let(:flac, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol)
          WAV = T.let(:wav, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol)
          PCM = T.let(:pcm, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol]) }
          def self.values
          end
        end
      end
    end
  end
end
