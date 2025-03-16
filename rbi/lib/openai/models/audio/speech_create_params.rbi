# typed: strong

module OpenAI
  module Models
    module Audio
      class SpeechCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # The text to generate audio for. The maximum length is 4096 characters.
        sig { returns(String) }
        def input
        end

        sig { params(_: String).returns(String) }
        def input=(_)
        end

        # One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        #   `tts-1` or `tts-1-hd`
        sig { returns(T.any(String, Symbol)) }
        def model
        end

        sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
        def model=(_)
        end

        # The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
        #   `coral`, `echo`, `fable`, `onyx`, `nova`, `sage` and `shimmer`. Previews of the
        #   voices are available in the
        #   [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
        sig { returns(Symbol) }
        def voice
        end

        sig { params(_: Symbol).returns(Symbol) }
        def voice=(_)
        end

        # The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
        #   `wav`, and `pcm`.
        sig { returns(T.nilable(Symbol)) }
        def response_format
        end

        sig { params(_: Symbol).returns(Symbol) }
        def response_format=(_)
        end

        # The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is
        #   the default.
        sig { returns(T.nilable(Float)) }
        def speed
        end

        sig { params(_: Float).returns(Float) }
        def speed=(_)
        end

        sig do
          params(
            input: String,
            model: T.any(String, Symbol),
            voice: Symbol,
            response_format: Symbol,
            speed: Float,
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(input:, model:, voice:, response_format: nil, speed: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                input: String,
                model: T.any(String, Symbol),
                voice: Symbol,
                response_format: Symbol,
                speed: Float,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        #   `tts-1` or `tts-1-hd`
        class Model < OpenAI::Union
          abstract!

          Variants = type_template(:out) { {fixed: T.any(String, Symbol)} }
        end

        # The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
        #   `coral`, `echo`, `fable`, `onyx`, `nova`, `sage` and `shimmer`. Previews of the
        #   voices are available in the
        #   [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
        class Voice < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          ALLOY = :alloy
          ASH = :ash
          CORAL = :coral
          ECHO = :echo
          FABLE = :fable
          ONYX = :onyx
          NOVA = :nova
          SAGE = :sage
          SHIMMER = :shimmer
        end

        # The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
        #   `wav`, and `pcm`.
        class ResponseFormat < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          MP3 = :mp3
          OPUS = :opus
          AAC = :aac
          FLAC = :flac
          WAV = :wav
          PCM = :pcm
        end
      end
    end
  end
end
