# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class SpeechCreateParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::RequestParameters::Converter
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
        #     `coral`, `echo`, `fable`, `onyx`, `nova`, `sage` and `shimmer`. Previews of the
        #     voices are available in the
        #     [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
        #
        #   @return [Symbol, OpenAI::Models::Audio::SpeechCreateParams::Voice]
        required :voice, enum: -> { OpenAI::Models::Audio::SpeechCreateParams::Voice }

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
        #   # @param voice [Symbol, OpenAI::Models::Audio::SpeechCreateParams::Voice]
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
          #   class << self
          #     # @return [Array(String, Symbol, OpenAI::Models::Audio::SpeechModel)]
          #     def variants; end
          #   end
        end

        # The voice to use when generating the audio. Supported voices are `alloy`, `ash`,
        #   `coral`, `echo`, `fable`, `onyx`, `nova`, `sage` and `shimmer`. Previews of the
        #   voices are available in the
        #   [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options).
        module Voice
          extend OpenAI::Enum

          ALLOY = :alloy
          ASH = :ash
          CORAL = :coral
          ECHO = :echo
          FABLE = :fable
          ONYX = :onyx
          NOVA = :nova
          SAGE = :sage
          SHIMMER = :shimmer

          finalize!

          class << self
            # @!parse
            #   # @return [Array<Symbol>]
            #   def values; end
          end
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

          class << self
            # @!parse
            #   # @return [Array<Symbol>]
            #   def values; end
          end
        end
      end
    end
  end
end
