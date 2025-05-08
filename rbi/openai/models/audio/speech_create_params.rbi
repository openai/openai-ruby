# typed: strong

module OpenAI
  module Models
    module Audio
      class SpeechCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The text to generate audio for. The maximum length is 4096 characters.
        sig { returns(String) }
        attr_accessor :input

        # One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        # `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
        sig { returns(T.any(String, OpenAI::Audio::SpeechModel::OrSymbol)) }
        attr_accessor :model

        # The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
        # `ballad`, `coral`, `echo`, `fable`, `onyx`, `nova`, `sage`, `shimmer`, and
        # `verse`. Previews of the voices are available in the
        # [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
        sig do
          returns(
            T.any(String, OpenAI::Audio::SpeechCreateParams::Voice::OrSymbol)
          )
        end
        attr_accessor :voice

        # Control the voice of your generated audio with additional instructions. Does not
        # work with `tts-1` or `tts-1-hd`.
        sig { returns(T.nilable(String)) }
        attr_reader :instructions

        sig { params(instructions: String).void }
        attr_writer :instructions

        # The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
        # `wav`, and `pcm`.
        sig do
          returns(
            T.nilable(
              OpenAI::Audio::SpeechCreateParams::ResponseFormat::OrSymbol
            )
          )
        end
        attr_reader :response_format

        sig do
          params(
            response_format:
              OpenAI::Audio::SpeechCreateParams::ResponseFormat::OrSymbol
          ).void
        end
        attr_writer :response_format

        # The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is
        # the default. Does not work with `gpt-4o-mini-tts`.
        sig { returns(T.nilable(Float)) }
        attr_reader :speed

        sig { params(speed: Float).void }
        attr_writer :speed

        sig do
          params(
            input: String,
            model: T.any(String, OpenAI::Audio::SpeechModel::OrSymbol),
            voice:
              T.any(String, OpenAI::Audio::SpeechCreateParams::Voice::OrSymbol),
            instructions: String,
            response_format:
              OpenAI::Audio::SpeechCreateParams::ResponseFormat::OrSymbol,
            speed: Float,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # The text to generate audio for. The maximum length is 4096 characters.
          input:,
          # One of the available [TTS models](https://platform.openai.com/docs/models#tts):
          # `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
          model:,
          # The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
          # `ballad`, `coral`, `echo`, `fable`, `onyx`, `nova`, `sage`, `shimmer`, and
          # `verse`. Previews of the voices are available in the
          # [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
          voice:,
          # Control the voice of your generated audio with additional instructions. Does not
          # work with `tts-1` or `tts-1-hd`.
          instructions: nil,
          # The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
          # `wav`, and `pcm`.
          response_format: nil,
          # The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is
          # the default. Does not work with `gpt-4o-mini-tts`.
          speed: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              input: String,
              model: T.any(String, OpenAI::Audio::SpeechModel::OrSymbol),
              voice:
                T.any(
                  String,
                  OpenAI::Audio::SpeechCreateParams::Voice::OrSymbol
                ),
              instructions: String,
              response_format:
                OpenAI::Audio::SpeechCreateParams::ResponseFormat::OrSymbol,
              speed: Float,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        # `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
        module Model
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(String, OpenAI::Audio::SpeechModel::TaggedSymbol)
            end

          sig do
            override.returns(
              T::Array[OpenAI::Audio::SpeechCreateParams::Model::Variants]
            )
          end
          def self.variants
          end
        end

        # The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
        # `ballad`, `coral`, `echo`, `fable`, `onyx`, `nova`, `sage`, `shimmer`, and
        # `verse`. Previews of the voices are available in the
        # [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
        module Voice
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                OpenAI::Audio::SpeechCreateParams::Voice::TaggedSymbol
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Audio::SpeechCreateParams::Voice::Variants]
            )
          end
          def self.variants
          end

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Audio::SpeechCreateParams::Voice)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ALLOY =
            T.let(
              :alloy,
              OpenAI::Audio::SpeechCreateParams::Voice::TaggedSymbol
            )
          ASH =
            T.let(:ash, OpenAI::Audio::SpeechCreateParams::Voice::TaggedSymbol)
          BALLAD =
            T.let(
              :ballad,
              OpenAI::Audio::SpeechCreateParams::Voice::TaggedSymbol
            )
          CORAL =
            T.let(
              :coral,
              OpenAI::Audio::SpeechCreateParams::Voice::TaggedSymbol
            )
          ECHO =
            T.let(:echo, OpenAI::Audio::SpeechCreateParams::Voice::TaggedSymbol)
          FABLE =
            T.let(
              :fable,
              OpenAI::Audio::SpeechCreateParams::Voice::TaggedSymbol
            )
          ONYX =
            T.let(:onyx, OpenAI::Audio::SpeechCreateParams::Voice::TaggedSymbol)
          NOVA =
            T.let(:nova, OpenAI::Audio::SpeechCreateParams::Voice::TaggedSymbol)
          SAGE =
            T.let(:sage, OpenAI::Audio::SpeechCreateParams::Voice::TaggedSymbol)
          SHIMMER =
            T.let(
              :shimmer,
              OpenAI::Audio::SpeechCreateParams::Voice::TaggedSymbol
            )
          VERSE =
            T.let(
              :verse,
              OpenAI::Audio::SpeechCreateParams::Voice::TaggedSymbol
            )
        end

        # The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
        # `wav`, and `pcm`.
        module ResponseFormat
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Audio::SpeechCreateParams::ResponseFormat)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MP3 =
            T.let(
              :mp3,
              OpenAI::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol
            )
          OPUS =
            T.let(
              :opus,
              OpenAI::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol
            )
          AAC =
            T.let(
              :aac,
              OpenAI::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol
            )
          FLAC =
            T.let(
              :flac,
              OpenAI::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol
            )
          WAV =
            T.let(
              :wav,
              OpenAI::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol
            )
          PCM =
            T.let(
              :pcm,
              OpenAI::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Audio::SpeechCreateParams::ResponseFormat::TaggedSymbol
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
