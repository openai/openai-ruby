# typed: strong

module OpenAI
  module Models
    ChatCompletionAudioParam = T.type_alias { Chat::ChatCompletionAudioParam }

    module Chat
      class ChatCompletionAudioParam < OpenAI::BaseModel
        sig { returns(Symbol) }
        def format_
        end

        sig { params(_: Symbol).returns(Symbol) }
        def format_=(_)
        end

        sig { returns(Symbol) }
        def voice
        end

        sig { params(_: Symbol).returns(Symbol) }
        def voice=(_)
        end

        sig { params(format_: Symbol, voice: Symbol).returns(T.attached_class) }
        def self.new(format_:, voice:)
        end

        sig { override.returns({format_: Symbol, voice: Symbol}) }
        def to_hash
        end

        class Format < OpenAI::Enum
          abstract!

          WAV = :wav
          MP3 = :mp3
          FLAC = :flac
          OPUS = :opus
          PCM16 = :pcm16

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class Voice < OpenAI::Enum
          abstract!

          ALLOY = :alloy
          ASH = :ash
          BALLAD = :ballad
          CORAL = :coral
          ECHO = :echo
          SAGE = :sage
          SHIMMER = :shimmer
          VERSE = :verse

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
