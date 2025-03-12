# typed: strong

module OpenAI
  module Models
    ChatCompletionContentPartInputAudio = T.type_alias { Chat::ChatCompletionContentPartInputAudio }

    module Chat
      class ChatCompletionContentPartInputAudio < OpenAI::BaseModel
        sig { returns(OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio) }
        def input_audio
        end

        sig do
          params(_: OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio)
            .returns(OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio)
        end
        def input_audio=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig do
          params(input_audio: OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio, type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(input_audio:, type: :input_audio)
        end

        sig do
          override
            .returns(
              {input_audio: OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio, type: Symbol}
            )
        end
        def to_hash
        end

        class InputAudio < OpenAI::BaseModel
          sig { returns(String) }
          def data
          end

          sig { params(_: String).returns(String) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def format_
          end

          sig { params(_: Symbol).returns(Symbol) }
          def format_=(_)
          end

          sig { params(data: String, format_: Symbol).returns(T.attached_class) }
          def self.new(data:, format_:)
          end

          sig { override.returns({data: String, format_: Symbol}) }
          def to_hash
          end

          class Format < OpenAI::Enum
            abstract!

            WAV = :wav
            MP3 = :mp3

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
end
