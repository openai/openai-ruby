# typed: strong

module OpenAI
  module Models
    ChatCompletionContentPartInputAudio =
      Chat::ChatCompletionContentPartInputAudio

    module Chat
      class ChatCompletionContentPartInputAudio < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionContentPartInputAudio,
              OpenAI::Internal::AnyHash
            )
          end

        sig do
          returns(OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio)
        end
        attr_reader :input_audio

        sig do
          params(
            input_audio:
              OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::OrHash
          ).void
        end
        attr_writer :input_audio

        # The type of the content part. Always `input_audio`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Learn about [audio inputs](https://platform.openai.com/docs/guides/audio).
        sig do
          params(
            input_audio:
              OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          input_audio:,
          # The type of the content part. Always `input_audio`.
          type: :input_audio
        )
        end

        sig do
          override.returns(
            {
              input_audio:
                OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class InputAudio < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio,
                OpenAI::Internal::AnyHash
              )
            end

          # Base64 encoded audio data.
          sig { returns(String) }
          attr_accessor :data

          # The format of the encoded audio data. Currently supports "wav" and "mp3".
          sig do
            returns(
              OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::OrSymbol
            )
          end
          attr_accessor :format_

          sig do
            params(
              data: String,
              format_:
                OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Base64 encoded audio data.
            data:,
            # The format of the encoded audio data. Currently supports "wav" and "mp3".
            format_:
          )
          end

          sig do
            override.returns(
              {
                data: String,
                format_:
                  OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The format of the encoded audio data. Currently supports "wav" and "mp3".
          module Format
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            WAV =
              T.let(
                :wav,
                OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::TaggedSymbol
              )
            MP3 =
              T.let(
                :mp3,
                OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
