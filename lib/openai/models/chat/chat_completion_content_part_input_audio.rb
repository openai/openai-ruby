# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionContentPartInputAudio < OpenAI::BaseModel
        # @!attribute input_audio
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio]
        required :input_audio, -> { OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio }

        # @!attribute type
        #   The type of the content part. Always `input_audio`.
        #
        #   @return [Symbol, :input_audio]
        required :type, const: :input_audio

        # @!parse
        #   # Learn about [audio inputs](https://platform.openai.com/docs/guides/audio).
        #   #
        #   # @param input_audio [OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio]
        #   # @param type [Symbol, :input_audio]
        #   #
        #   def initialize(input_audio:, type: :input_audio, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @see OpenAI::Models::Chat::ChatCompletionContentPartInputAudio#input_audio
        class InputAudio < OpenAI::BaseModel
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
                   enum: -> { OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format },
                   api_name: :format

          # @!parse
          #   # @param data [String]
          #   # @param format_ [Symbol, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio::Format]
          #   #
          #   def initialize(data:, format_:, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # The format of the encoded audio data. Currently supports "wav" and "mp3".
          #
          # @see OpenAI::Models::Chat::ChatCompletionContentPartInputAudio::InputAudio#format_
          module Format
            extend OpenAI::Enum

            WAV = :wav
            MP3 = :mp3

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end
        end
      end
    end

    ChatCompletionContentPartInputAudio = Chat::ChatCompletionContentPartInputAudio
  end
end
