# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionContentPartInputAudio < OpenAI::Internal::Type::BaseModel
        # @!attribute input_audio
        #
        #   @return [OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio]
        required :input_audio, -> { OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio }

        # @!attribute type
        #   The type of the content part. Always `input_audio`.
        #
        #   @return [Symbol, :input_audio]
        required :type, const: :input_audio

        # @!method initialize(input_audio:, type: :input_audio)
        #   Learn about [audio inputs](https://platform.openai.com/docs/guides/audio).
        #
        #   @param input_audio [OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio]
        #
        #   @param type [Symbol, :input_audio] The type of the content part. Always `input_audio`.

        # @see OpenAI::Chat::ChatCompletionContentPartInputAudio#input_audio
        class InputAudio < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Base64 encoded audio data.
          #
          #   @return [String]
          required :data, String

          # @!attribute format_
          #   The format of the encoded audio data. Currently supports "wav" and "mp3".
          #
          #   @return [Symbol, OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format]
          required :format_,
                   enum: -> { OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format },
                   api_name: :format

          # @!method initialize(data:, format_:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio} for more
          #   details.
          #
          #   @param data [String] Base64 encoded audio data.
          #
          #   @param format_ [Symbol, OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format] The format of the encoded audio data. Currently supports "wav" and "mp3".

          # The format of the encoded audio data. Currently supports "wav" and "mp3".
          #
          # @see OpenAI::Chat::ChatCompletionContentPartInputAudio::InputAudio#format_
          module Format
            extend OpenAI::Internal::Type::Enum

            WAV = :wav
            MP3 = :mp3

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end

    ChatCompletionContentPartInputAudio = Chat::ChatCompletionContentPartInputAudio
  end
end
