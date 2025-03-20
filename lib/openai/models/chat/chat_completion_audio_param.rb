# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionAudioParam < OpenAI::BaseModel
        # @!attribute format_
        #   Specifies the output audio format. Must be one of `wav`, `mp3`, `flac`, `opus`,
        #     or `pcm16`.
        #
        #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionAudioParam::Format]
        required :format_, enum: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Format }, api_name: :format

        # @!attribute voice
        #   The voice the model uses to respond. Supported voices are `alloy`, `ash`,
        #     `ballad`, `coral`, `echo`, `sage`, and `shimmer`.
        #
        #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice]
        required :voice, enum: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice }

        # @!parse
        #   # Parameters for audio output. Required when audio output is requested with
        #   #   `modalities: ["audio"]`.
        #   #   [Learn more](https://platform.openai.com/docs/guides/audio).
        #   #
        #   # @param format_ [Symbol, OpenAI::Models::Chat::ChatCompletionAudioParam::Format]
        #   # @param voice [Symbol, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice]
        #   #
        #   def initialize(format_:, voice:, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # Specifies the output audio format. Must be one of `wav`, `mp3`, `flac`, `opus`,
        #   or `pcm16`.
        module Format
          extend OpenAI::Enum

          WAV = :wav
          MP3 = :mp3
          FLAC = :flac
          OPUS = :opus
          PCM16 = :pcm16

          finalize!
        end

        # The voice the model uses to respond. Supported voices are `alloy`, `ash`,
        #   `ballad`, `coral`, `echo`, `sage`, and `shimmer`.
        module Voice
          extend OpenAI::Enum

          ALLOY = :alloy
          ASH = :ash
          BALLAD = :ballad
          CORAL = :coral
          ECHO = :echo
          SAGE = :sage
          SHIMMER = :shimmer
          VERSE = :verse

          finalize!
        end
      end
    end

    ChatCompletionAudioParam = Chat::ChatCompletionAudioParam
  end
end
