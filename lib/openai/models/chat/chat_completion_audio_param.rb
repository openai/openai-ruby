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
        #   @return [String, Symbol]
        required :voice, union: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice }

        # @!parse
        #   # Parameters for audio output. Required when audio output is requested with
        #   #   `modalities: ["audio"]`.
        #   #   [Learn more](https://platform.openai.com/docs/guides/audio).
        #   #
        #   # @param format_ [Symbol, OpenAI::Models::Chat::ChatCompletionAudioParam::Format]
        #   # @param voice [String, Symbol]
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

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end

        # The voice the model uses to respond. Supported voices are `alloy`, `ash`,
        #   `ballad`, `coral`, `echo`, `sage`, and `shimmer`.
        module Voice
          extend OpenAI::Union

          variant String

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::ALLOY }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::ASH }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::BALLAD }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::CORAL }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::ECHO }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::FABLE }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::ONYX }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::NOVA }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::SAGE }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::SHIMMER }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::VERSE }

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
      end
    end

    ChatCompletionAudioParam = Chat::ChatCompletionAudioParam
  end
end
