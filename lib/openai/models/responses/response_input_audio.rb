# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInputAudio < OpenAI::Internal::Type::BaseModel
        # @!attribute data
        #   Base64-encoded audio data.
        #
        #   @return [String]
        required :data, String

        # @!attribute format_
        #   The format of the audio data. Currently supported formats are `mp3` and `wav`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseInputAudio::Format]
        required :format_, enum: -> { OpenAI::Models::Responses::ResponseInputAudio::Format }, api_name: :format

        # @!attribute type
        #   The type of the input item. Always `input_audio`.
        #
        #   @return [Symbol, :input_audio]
        required :type, const: :input_audio

        # @!method initialize(data:, format_:, type: :input_audio)
        #   An audio input to the model.
        #
        #   @param data [String]
        #   @param format_ [Symbol, OpenAI::Models::Responses::ResponseInputAudio::Format]
        #   @param type [Symbol, :input_audio]

        # The format of the audio data. Currently supported formats are `mp3` and `wav`.
        #
        # @see OpenAI::Models::Responses::ResponseInputAudio#format_
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
