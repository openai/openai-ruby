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

        # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        # token block.
        sig do
          returns(
            T.nilable(
              OpenAI::Chat::ChatCompletionContentPartInputAudio::PromptCacheBreakpoint
            )
          )
        end
        attr_reader :prompt_cache_breakpoint

        sig do
          params(
            prompt_cache_breakpoint:
              OpenAI::Chat::ChatCompletionContentPartInputAudio::PromptCacheBreakpoint::OrHash
          ).void
        end
        attr_writer :prompt_cache_breakpoint

        # Learn about [audio inputs](https://platform.openai.com/docs/guides/audio).
        sig do
          params(
            input_audio:
              OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::OrHash,
            prompt_cache_breakpoint:
              OpenAI::Chat::ChatCompletionContentPartInputAudio::PromptCacheBreakpoint::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          input_audio:,
          # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          # token block.
          prompt_cache_breakpoint: nil,
          # The type of the content part. Always `input_audio`.
          type: :input_audio
        )
        end

        sig do
          override.returns(
            {
              input_audio:
                OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio,
              type: Symbol,
              prompt_cache_breakpoint:
                OpenAI::Chat::ChatCompletionContentPartInputAudio::PromptCacheBreakpoint
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

        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Chat::ChatCompletionContentPartInputAudio::PromptCacheBreakpoint,
                OpenAI::Internal::AnyHash
              )
            end

          # The breakpoint mode. Always `explicit`.
          sig { returns(Symbol) }
          attr_accessor :mode

          # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          # token block.
          sig { params(mode: Symbol).returns(T.attached_class) }
          def self.new(
            # The breakpoint mode. Always `explicit`.
            mode: :explicit
          )
          end

          sig { override.returns({ mode: Symbol }) }
          def to_hash
          end
        end
      end
    end
  end
end
