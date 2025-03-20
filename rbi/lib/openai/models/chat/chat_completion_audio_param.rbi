# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionAudioParam < OpenAI::BaseModel
        # Specifies the output audio format. Must be one of `wav`, `mp3`, `flac`, `opus`,
        #   or `pcm16`.
        sig { returns(OpenAI::Models::Chat::ChatCompletionAudioParam::Format::OrSymbol) }
        def format_
        end

        sig do
          params(_: OpenAI::Models::Chat::ChatCompletionAudioParam::Format::OrSymbol)
            .returns(OpenAI::Models::Chat::ChatCompletionAudioParam::Format::OrSymbol)
        end
        def format_=(_)
        end

        # The voice the model uses to respond. Supported voices are `alloy`, `ash`,
        #   `ballad`, `coral`, `echo`, `sage`, and `shimmer`.
        sig { returns(OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::OrSymbol) }
        def voice
        end

        sig do
          params(_: OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::OrSymbol)
            .returns(OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::OrSymbol)
        end
        def voice=(_)
        end

        # Parameters for audio output. Required when audio output is requested with
        #   `modalities: ["audio"]`.
        #   [Learn more](https://platform.openai.com/docs/guides/audio).
        sig do
          params(
            format_: OpenAI::Models::Chat::ChatCompletionAudioParam::Format::OrSymbol,
            voice: OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::OrSymbol
          )
            .returns(T.attached_class)
        end
        def self.new(format_:, voice:)
        end

        sig do
          override
            .returns(
              {
                format_: OpenAI::Models::Chat::ChatCompletionAudioParam::Format::OrSymbol,
                voice: OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::OrSymbol
              }
            )
        end
        def to_hash
        end

        # Specifies the output audio format. Must be one of `wav`, `mp3`, `flac`, `opus`,
        #   or `pcm16`.
        module Format
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionAudioParam::Format) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Chat::ChatCompletionAudioParam::Format::TaggedSymbol) }

          WAV = T.let(:wav, OpenAI::Models::Chat::ChatCompletionAudioParam::Format::TaggedSymbol)
          MP3 = T.let(:mp3, OpenAI::Models::Chat::ChatCompletionAudioParam::Format::TaggedSymbol)
          FLAC = T.let(:flac, OpenAI::Models::Chat::ChatCompletionAudioParam::Format::TaggedSymbol)
          OPUS = T.let(:opus, OpenAI::Models::Chat::ChatCompletionAudioParam::Format::TaggedSymbol)
          PCM16 = T.let(:pcm16, OpenAI::Models::Chat::ChatCompletionAudioParam::Format::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletionAudioParam::Format::TaggedSymbol]) }
            def values
            end
          end
        end

        # The voice the model uses to respond. Supported voices are `alloy`, `ash`,
        #   `ballad`, `coral`, `echo`, `sage`, and `shimmer`.
        module Voice
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol) }

          ALLOY = T.let(:alloy, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol)
          ASH = T.let(:ash, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol)
          BALLAD = T.let(:ballad, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol)
          CORAL = T.let(:coral, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol)
          ECHO = T.let(:echo, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol)
          SAGE = T.let(:sage, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol)
          SHIMMER = T.let(:shimmer, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol)
          VERSE = T.let(:verse, OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletionAudioParam::Voice::TaggedSymbol]) }
            def values
            end
          end
        end
      end
    end

    ChatCompletionAudioParam = Chat::ChatCompletionAudioParam
  end
end
