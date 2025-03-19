# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionAudioParam < OpenAI::BaseModel
        # Specifies the output audio format. Must be one of `wav`, `mp3`, `flac`, `opus`,
        #   or `pcm16`.
        sig { returns(Symbol) }
        def format_
        end

        sig { params(_: Symbol).returns(Symbol) }
        def format_=(_)
        end

        # The voice the model uses to respond. Supported voices are `alloy`, `ash`,
        #   `ballad`, `coral`, `echo`, `sage`, and `shimmer`.
        sig { returns(Symbol) }
        def voice
        end

        sig { params(_: Symbol).returns(Symbol) }
        def voice=(_)
        end

        # Parameters for audio output. Required when audio output is requested with
        #   `modalities: ["audio"]`.
        #   [Learn more](https://platform.openai.com/docs/guides/audio).
        sig { params(format_: Symbol, voice: Symbol).returns(T.attached_class) }
        def self.new(format_:, voice:)
        end

        sig { override.returns({format_: Symbol, voice: Symbol}) }
        def to_hash
        end

        # Specifies the output audio format. Must be one of `wav`, `mp3`, `flac`, `opus`,
        #   or `pcm16`.
        class Format < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          WAV = :wav
          MP3 = :mp3
          FLAC = :flac
          OPUS = :opus
          PCM16 = :pcm16
        end

        # The voice the model uses to respond. Supported voices are `alloy`, `ash`,
        #   `ballad`, `coral`, `echo`, `sage`, and `shimmer`.
        class Voice < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          ALLOY = :alloy
          ASH = :ash
          BALLAD = :ballad
          CORAL = :coral
          ECHO = :echo
          SAGE = :sage
          SHIMMER = :shimmer
          VERSE = :verse
        end
      end
    end

    ChatCompletionAudioParam = Chat::ChatCompletionAudioParam
  end
end
