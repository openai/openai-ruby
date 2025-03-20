# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionContentPartInputAudio < OpenAI::BaseModel
        sig { returns(OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio) }
        def input_audio
        end

        sig do
          params(
            _: T.any(OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio, OpenAI::Util::AnyHash)
          )
            .returns(
              T.any(OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio, OpenAI::Util::AnyHash)
            )
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
          sig { returns(OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::OrSymbol) }
          def format_
          end

          sig do
            params(_: OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::OrSymbol)
              .returns(OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::OrSymbol)
          end
          def format_=(_)
          end

          sig do
            params(
              data: String,
              format_: OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(data:, format_:)
          end

          sig do
            override
              .returns(
                {
                  data: String,
                  format_: OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::OrSymbol
                }
              )
          end
          def to_hash
          end

          # The format of the encoded audio data. Currently supports "wav" and "mp3".
          module Format
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format) }
            OrSymbol =
              T.type_alias { T.any(Symbol, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::TaggedSymbol) }

            WAV =
              T.let(:wav, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::OrSymbol)
            MP3 =
              T.let(:mp3, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::OrSymbol)
          end
        end
      end
    end

    ChatCompletionContentPartInputAudio = Chat::ChatCompletionContentPartInputAudio
  end
end
