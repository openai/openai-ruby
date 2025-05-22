# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::Speech#create
      class SpeechCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute input
        #   The text to generate audio for. The maximum length is 4096 characters.
        #
        #   @return [String]
        required :input, String

        # @!attribute model
        #   One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        #   `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
        #
        #   @return [String, Symbol, OpenAI::Models::Audio::SpeechModel]
        required :model, union: -> { OpenAI::Audio::SpeechCreateParams::Model }

        # @!attribute voice
        #   The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
        #   `ballad`, `coral`, `echo`, `fable`, `onyx`, `nova`, `sage`, `shimmer`, and
        #   `verse`. Previews of the voices are available in the
        #   [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
        #
        #   @return [String, Symbol, OpenAI::Models::Audio::SpeechCreateParams::Voice]
        required :voice, union: -> { OpenAI::Audio::SpeechCreateParams::Voice }

        # @!attribute instructions
        #   Control the voice of your generated audio with additional instructions. Does not
        #   work with `tts-1` or `tts-1-hd`.
        #
        #   @return [String, nil]
        optional :instructions, String

        # @!attribute response_format
        #   The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
        #   `wav`, and `pcm`.
        #
        #   @return [Symbol, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat, nil]
        optional :response_format, enum: -> { OpenAI::Audio::SpeechCreateParams::ResponseFormat }

        # @!attribute speed
        #   The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is
        #   the default. Does not work with `gpt-4o-mini-tts`.
        #
        #   @return [Float, nil]
        optional :speed, Float

        # @!method initialize(input:, model:, voice:, instructions: nil, response_format: nil, speed: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Audio::SpeechCreateParams} for more details.
        #
        #   @param input [String] The text to generate audio for. The maximum length is 4096 characters.
        #
        #   @param model [String, Symbol, OpenAI::Models::Audio::SpeechModel] One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        #
        #   @param voice [String, Symbol, OpenAI::Models::Audio::SpeechCreateParams::Voice] The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
        #
        #   @param instructions [String] Control the voice of your generated audio with additional instructions. Does not
        #
        #   @param response_format [Symbol, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat] The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`, `wav
        #
        #   @param speed [Float] The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        # `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          # One of the available [TTS models](https://platform.openai.com/docs/models#tts): `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
          variant enum: -> { OpenAI::Audio::SpeechModel }

          # @!method self.variants
          #   @return [Array(String, Symbol, OpenAI::Models::Audio::SpeechModel)]
        end

        # The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
        # `ballad`, `coral`, `echo`, `fable`, `onyx`, `nova`, `sage`, `shimmer`, and
        # `verse`. Previews of the voices are available in the
        # [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
        module Voice
          extend OpenAI::Internal::Type::Union

          variant String

          variant const: -> { OpenAI::Models::Audio::SpeechCreateParams::Voice::ALLOY }

          variant const: -> { OpenAI::Models::Audio::SpeechCreateParams::Voice::ASH }

          variant const: -> { OpenAI::Models::Audio::SpeechCreateParams::Voice::BALLAD }

          variant const: -> { OpenAI::Models::Audio::SpeechCreateParams::Voice::CORAL }

          variant const: -> { OpenAI::Models::Audio::SpeechCreateParams::Voice::ECHO }

          variant const: -> { OpenAI::Models::Audio::SpeechCreateParams::Voice::FABLE }

          variant const: -> { OpenAI::Models::Audio::SpeechCreateParams::Voice::ONYX }

          variant const: -> { OpenAI::Models::Audio::SpeechCreateParams::Voice::NOVA }

          variant const: -> { OpenAI::Models::Audio::SpeechCreateParams::Voice::SAGE }

          variant const: -> { OpenAI::Models::Audio::SpeechCreateParams::Voice::SHIMMER }

          variant const: -> { OpenAI::Models::Audio::SpeechCreateParams::Voice::VERSE }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::Audio::SpeechCreateParams::Voice::TaggedSymbol) }
          end

          # @!group

          ALLOY = :alloy
          ASH = :ash
          BALLAD = :ballad
          CORAL = :coral
          ECHO = :echo
          FABLE = :fable
          ONYX = :onyx
          NOVA = :nova
          SAGE = :sage
          SHIMMER = :shimmer
          VERSE = :verse

          # @!endgroup
        end

        # The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
        # `wav`, and `pcm`.
        module ResponseFormat
          extend OpenAI::Internal::Type::Enum

          MP3 = :mp3
          OPUS = :opus
          AAC = :aac
          FLAC = :flac
          WAV = :wav
          PCM = :pcm

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
