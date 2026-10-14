# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInputAudio < OpenAI::Internal::Type::BaseModel
        # @!attribute input_audio
        #
        #   @return [OpenAI::Models::Responses::ResponseInputAudio::InputAudio]
        required :input_audio, -> { OpenAI::Responses::ResponseInputAudio::InputAudio }

        # @!attribute type
        #   The type of the input item. Always `input_audio`.
        #
        #   @return [Symbol, :input_audio]
        required :type, const: :input_audio

        # @!method initialize(input_audio:, type: :input_audio)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseInputAudio} for more details.
        #
        #   An audio input to the model.
        #
        #   @param input_audio [OpenAI::Models::Responses::ResponseInputAudio::InputAudio]
        #
        #   @param type [Symbol, :input_audio] The type of the input item. Always `input_audio`.

        # @see OpenAI::Models::Responses::ResponseInputAudio#input_audio
        class InputAudio < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Base64-encoded audio data.
          #
          #   @return [String]
          required :data, String

          # @!attribute format_
          #   The format of the audio data. Currently supported formats are `mp3` and `wav`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::ResponseInputAudio::InputAudio::Format]
          required :format_,
                   enum: -> { OpenAI::Responses::ResponseInputAudio::InputAudio::Format },
                   api_name: :format

          # @!method initialize(data:, format_:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponseInputAudio::InputAudio} for more details.
          #
          #   @param data [String] Base64-encoded audio data.
          #
          #   @param format_ [Symbol, OpenAI::Models::Responses::ResponseInputAudio::InputAudio::Format] The format of the audio data. Currently supported formats are `mp3` and

          # The format of the audio data. Currently supported formats are `mp3` and `wav`.
          #
          # @see OpenAI::Models::Responses::ResponseInputAudio::InputAudio#format_
          module Format
            extend OpenAI::Internal::Type::Enum

            MP3 = :mp3
            WAV = :wav

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
