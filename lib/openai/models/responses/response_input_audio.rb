# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInputAudio < OpenAI::BaseModel
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

        # @!parse
        #   # An audio input to the model.
        #   #
        #   # @param data [String]
        #   # @param format_ [Symbol, OpenAI::Models::Responses::ResponseInputAudio::Format]
        #   # @param type [Symbol, :input_audio]
        #   #
        #   def initialize(data:, format_:, type: :input_audio, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # The format of the audio data. Currently supported formats are `mp3` and `wav`.
        module Format
          extend OpenAI::Enum

          MP3 = :mp3
          WAV = :wav

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end
  end
end
