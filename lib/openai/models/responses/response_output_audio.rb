# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseOutputAudio < OpenAI::BaseModel
        # @!attribute data
        #   Base64-encoded audio data from the model.
        #
        #   @return [String]
        required :data, String

        # @!attribute transcript
        #   The transcript of the audio data from the model.
        #
        #   @return [String]
        required :transcript, String

        # @!attribute type
        #   The type of the output audio. Always `output_audio`.
        #
        #   @return [Symbol, :output_audio]
        required :type, const: :output_audio

        # @!parse
        #   # An audio output from the model.
        #   #
        #   # @param data [String]
        #   # @param transcript [String]
        #   # @param type [Symbol, :output_audio]
        #   #
        #   def initialize(data:, transcript:, type: :output_audio, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
