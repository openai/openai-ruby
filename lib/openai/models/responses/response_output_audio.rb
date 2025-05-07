# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseOutputAudio < OpenAI::Internal::Type::BaseModel
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

        # @!method initialize(data:, transcript:, type: :output_audio)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseOutputAudio} for more details.
        #
        #   An audio output from the model.
        #
        #   @param data [String] Base64-encoded audio data from the model.
        #
        #   @param transcript [String] The transcript of the audio data from the model.
        #
        #   @param type [Symbol, :output_audio] The type of the output audio. Always `output_audio`.
      end
    end
  end
end
