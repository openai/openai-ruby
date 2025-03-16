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

        # The type of the content part. Always `input_audio`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Learn about [audio inputs](https://platform.openai.com/docs/guides/audio).
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
          # Base64 encoded audio data.
          sig { returns(String) }
          def data
          end

          sig { params(_: String).returns(String) }
          def data=(_)
          end

          # The format of the encoded audio data. Currently supports "wav" and "mp3".
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

          # The format of the encoded audio data. Currently supports "wav" and "mp3".
          class Format < OpenAI::Enum
            abstract!

            Value = type_template(:out) { {fixed: Symbol} }

            WAV = :wav
            MP3 = :mp3
          end
        end
      end
    end
  end
end
