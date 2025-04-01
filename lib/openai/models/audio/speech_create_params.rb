# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::Speech#create
      class SpeechCreateParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::Type::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!attribute input
        #   The text to generate audio for. The maximum length is 4096 characters.
        #
        #   @return [String]
        required :input, String

        # @!attribute model
        #   One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        #     `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
        #
        #   @return [String, Symbol, OpenAI::Models::Audio::SpeechModel]
        required :model, union: -> { OpenAI::Models::Audio::SpeechCreateParams::Model }

        # @!attribute voice
        #   The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
        #     `ballad`, `coral`, `echo`, `fable`, `onyx`, `nova`, `sage`, `shimmer`, and
        #     `verse`. Previews of the voices are available in the
        #     [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
        #
        #   @return [String, Symbol]
        required :voice, union: -> { OpenAI::Models::Audio::SpeechCreateParams::Voice }

        # @!attribute [r] instructions
        #   Control the voice of your generated audio with additional instructions. Does not
        #     work with `tts-1` or `tts-1-hd`.
        #
        #   @return [String, nil]
        optional :instructions, String

        # @!parse
        #   # @return [String]
        #   attr_writer :instructions

        # @!attribute [r] response_format
        #   The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`,
        #     `wav`, and `pcm`.
        #
        #   @return [Symbol, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat, nil]
        optional :response_format, enum: -> { OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat]
        #   attr_writer :response_format

        # @!attribute [r] speed
        #   The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is
        #     the default.
        #
        #   @return [Float, nil]
        optional :speed, Float

        # @!parse
        #   # @return [Float]
        #   attr_writer :speed

        # @!parse
        #   # @param input [String]
        #   # @param model [String, Symbol, OpenAI::Models::Audio::SpeechModel]
        #   # @param voice [String, Symbol]
        #   # @param instructions [String]
        #   # @param response_format [Symbol, OpenAI::Models::Audio::SpeechCreateParams::ResponseFormat]
        #   # @param speed [Float]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(input:, model:, voice:, instructions: nil, response_format: nil, speed: nil, request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # One of the available [TTS models](https://platform.openai.com/docs/models#tts):
        #   `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
        module Model
          extend OpenAI::Union

          variant String

          # One of the available [TTS models](https://platform.openai.com/docs/models#tts): `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
          variant enum: -> { OpenAI::Models::Audio::SpeechModel }

          # @!parse
          #   # @return [Array(String, Symbol, OpenAI::Models::Audio::SpeechModel)]
          #   def self.variants; end
        end

        # The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
        #   `ballad`, `coral`, `echo`, `fable`, `onyx`, `nova`, `sage`, `shimmer`, and
        #   `verse`. Previews of the voices are available in the
        #   [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
        module Voice
          extend OpenAI::Union

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

          # @!parse
          #   # @return [Array(String, Symbol)]
          #   def self.variants; end

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
        #   `wav`, and `pcm`.
        module ResponseFormat
          extend OpenAI::Enum

          MP3 = :mp3
          OPUS = :opus
          AAC = :aac
          FLAC = :flac
          WAV = :wav
          PCM = :pcm

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end
  end
end
