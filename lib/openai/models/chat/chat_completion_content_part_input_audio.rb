# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionContentPartInputAudio < OpenAI::Internal::Type::BaseModel
        # @!attribute input_audio
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio]
        required :input_audio, -> { OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio }

        # @!attribute type
        #   The type of the content part. Always `input_audio`.
        #
        #   @return [Symbol, :input_audio]
        required :type, const: :input_audio

        # @!attribute prompt_cache_breakpoint
        #   Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        #   from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
        #   token block.
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::PromptCacheBreakpoint, nil]
        optional :prompt_cache_breakpoint,
                 -> { OpenAI::Chat::ChatCompletionContentPartInputAudio::PromptCacheBreakpoint }

        # @!method initialize(input_audio:, prompt_cache_breakpoint: nil, type: :input_audio)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Chat::ChatCompletionContentPartInputAudio} for more details.
        #
        #   Learn about [audio inputs](https://platform.openai.com/docs/guides/audio).
        #
        #   @param input_audio [OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio]
        #
        #   @param prompt_cache_breakpoint [OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::PromptCacheBreakpoint] Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
        #
        #   @param type [Symbol, :input_audio] The type of the content part. Always `input_audio`.

        # @see OpenAI::Models::Chat::ChatCompletionContentPartInputAudio#input_audio
        class InputAudio < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Base64 encoded audio data.
          #
          #   @return [String]
          required :data, String

          # @!attribute format_
          #   The format of the encoded audio data. Currently supports "wav" and "mp3".
          #
          #   @return [Symbol, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format]
          required :format_,
                   enum: -> { OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format },
                   api_name: :format

          # @!method initialize(data:, format_:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio} for more
          #   details.
          #
          #   @param data [String] Base64 encoded audio data.
          #
          #   @param format_ [Symbol, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format] The format of the encoded audio data. Currently supports "wav" and "mp3".

          # The format of the encoded audio data. Currently supports "wav" and "mp3".
          #
          # @see OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio#format_
          module Format
            extend OpenAI::Internal::Type::Enum

            WAV = :wav
            MP3 = :mp3

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # @see OpenAI::Models::Chat::ChatCompletionContentPartInputAudio#prompt_cache_breakpoint
        class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
          # @!attribute mode
          #   The breakpoint mode. Always `explicit`.
          #
          #   @return [Symbol, :explicit]
          required :mode, const: :explicit

          # @!method initialize(mode: :explicit)
          #   Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          #   from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          #   token block.
          #
          #   @param mode [Symbol, :explicit] The breakpoint mode. Always `explicit`.
        end
      end
    end

    ChatCompletionContentPartInputAudio = Chat::ChatCompletionContentPartInputAudio
  end
end
