# typed: strong

module OpenAI
  module Models
    ChatCompletionAudioParam = Chat::ChatCompletionAudioParam

    module Chat
      class ChatCompletionAudioParam < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionAudioParam,
              OpenAI::Internal::AnyHash
            )
          end

        # Specifies the output audio format. Must be one of `wav`, `mp3`, `flac`, `opus`,
        # or `pcm16`.
        sig do
          returns(OpenAI::Chat::ChatCompletionAudioParam::Format::OrSymbol)
        end
        attr_accessor :format_

        # The voice the model uses to respond. Supported voices are `alloy`, `ash`,
        # `ballad`, `coral`, `echo`, `fable`, `nova`, `onyx`, `sage`, and `shimmer`.
        sig do
          returns(
            T.any(
              String,
              OpenAI::Chat::ChatCompletionAudioParam::Voice::OrSymbol
            )
          )
        end
        attr_accessor :voice

        # Parameters for audio output. Required when audio output is requested with
        # `modalities: ["audio"]`.
        # [Learn more](https://platform.openai.com/docs/guides/audio).
        sig do
          params(
            format_: OpenAI::Chat::ChatCompletionAudioParam::Format::OrSymbol,
            voice:
              T.any(
                String,
                OpenAI::Chat::ChatCompletionAudioParam::Voice::OrSymbol
              )
          ).returns(T.attached_class)
        end
        def self.new(
          # Specifies the output audio format. Must be one of `wav`, `mp3`, `flac`, `opus`,
          # or `pcm16`.
          format_:,
          # The voice the model uses to respond. Supported voices are `alloy`, `ash`,
          # `ballad`, `coral`, `echo`, `fable`, `nova`, `onyx`, `sage`, and `shimmer`.
          voice:
        )
        end

        sig do
          override.returns(
            {
              format_: OpenAI::Chat::ChatCompletionAudioParam::Format::OrSymbol,
              voice:
                T.any(
                  String,
                  OpenAI::Chat::ChatCompletionAudioParam::Voice::OrSymbol
                )
            }
          )
        end
        def to_hash
        end

        # Specifies the output audio format. Must be one of `wav`, `mp3`, `flac`, `opus`,
        # or `pcm16`.
        module Format
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Chat::ChatCompletionAudioParam::Format)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          WAV =
            T.let(
              :wav,
              OpenAI::Chat::ChatCompletionAudioParam::Format::TaggedSymbol
            )
          AAC =
            T.let(
              :aac,
              OpenAI::Chat::ChatCompletionAudioParam::Format::TaggedSymbol
            )
          MP3 =
            T.let(
              :mp3,
              OpenAI::Chat::ChatCompletionAudioParam::Format::TaggedSymbol
            )
          FLAC =
            T.let(
              :flac,
              OpenAI::Chat::ChatCompletionAudioParam::Format::TaggedSymbol
            )
          OPUS =
            T.let(
              :opus,
              OpenAI::Chat::ChatCompletionAudioParam::Format::TaggedSymbol
            )
          PCM16 =
            T.let(
              :pcm16,
              OpenAI::Chat::ChatCompletionAudioParam::Format::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Chat::ChatCompletionAudioParam::Format::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The voice the model uses to respond. Supported voices are `alloy`, `ash`,
        # `ballad`, `coral`, `echo`, `fable`, `nova`, `onyx`, `sage`, and `shimmer`.
        module Voice
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                OpenAI::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Chat::ChatCompletionAudioParam::Voice::Variants]
            )
          end
          def self.variants
          end

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Chat::ChatCompletionAudioParam::Voice)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ALLOY =
            T.let(
              :alloy,
              OpenAI::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol
            )
          ASH =
            T.let(
              :ash,
              OpenAI::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol
            )
          BALLAD =
            T.let(
              :ballad,
              OpenAI::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol
            )
          CORAL =
            T.let(
              :coral,
              OpenAI::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol
            )
          ECHO =
            T.let(
              :echo,
              OpenAI::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol
            )
          SAGE =
            T.let(
              :sage,
              OpenAI::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol
            )
          SHIMMER =
            T.let(
              :shimmer,
              OpenAI::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol
            )
          VERSE =
            T.let(
              :verse,
              OpenAI::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol
            )
        end
      end
    end
  end
end
