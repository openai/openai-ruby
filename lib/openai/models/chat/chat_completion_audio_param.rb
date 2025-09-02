# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionAudioParam < OpenAI::Internal::Type::BaseModel
        # @!attribute format_
        #   Specifies the output audio format. Must be one of `wav`, `mp3`, `flac`, `opus`,
        #   or `pcm16`.
        #
        #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionAudioParam::Format]
        required :format_, enum: -> { OpenAI::Chat::ChatCompletionAudioParam::Format }, api_name: :format

        # @!attribute voice
        #   The voice the model uses to respond. Supported voices are `alloy`, `ash`,
        #   `ballad`, `coral`, `echo`, `fable`, `nova`, `onyx`, `sage`, and `shimmer`.
        #
        #   @return [String, Symbol, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice]
        required :voice, union: -> { OpenAI::Chat::ChatCompletionAudioParam::Voice }

        # @!method initialize(format_:, voice:)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Chat::ChatCompletionAudioParam} for more details.
        #
        #   Parameters for audio output. Required when audio output is requested with
        #   `modalities: ["audio"]`.
        #   [Learn more](https://platform.openai.com/docs/guides/audio).
        #
        #   @param format_ [Symbol, OpenAI::Models::Chat::ChatCompletionAudioParam::Format] Specifies the output audio format. Must be one of `wav`, `mp3`, `flac`,
        #
        #   @param voice [String, Symbol, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice] The voice the model uses to respond. Supported voices are

        # Specifies the output audio format. Must be one of `wav`, `mp3`, `flac`, `opus`,
        # or `pcm16`.
        #
        # @see OpenAI::Models::Chat::ChatCompletionAudioParam#format_
        module Format
          extend OpenAI::Internal::Type::Enum

          WAV = :wav
          AAC = :aac
          MP3 = :mp3
          FLAC = :flac
          OPUS = :opus
          PCM16 = :pcm16

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The voice the model uses to respond. Supported voices are `alloy`, `ash`,
        # `ballad`, `coral`, `echo`, `fable`, `nova`, `onyx`, `sage`, and `shimmer`.
        #
        # @see OpenAI::Models::Chat::ChatCompletionAudioParam#voice
        module Voice
          extend OpenAI::Internal::Type::Union

          variant String

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::ALLOY }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::ASH }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::BALLAD }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::CORAL }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::ECHO }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::SAGE }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::SHIMMER }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::VERSE }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::MARIN }

          variant const: -> { OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::CEDAR }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol) }
          end

          # @!group

          ALLOY = :alloy
          ASH = :ash
          BALLAD = :ballad
          CORAL = :coral
          ECHO = :echo
          SAGE = :sage
          SHIMMER = :shimmer
          VERSE = :verse
          MARIN = :marin
          CEDAR = :cedar

          # @!endgroup
        end
      end
    end

    ChatCompletionAudioParam = Chat::ChatCompletionAudioParam
  end
end
