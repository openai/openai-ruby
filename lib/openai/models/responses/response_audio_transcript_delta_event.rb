# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseAudioTranscriptDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   The partial transcript of the audio response.
        #
        #   @return [String]
        required :delta, String

        # @!attribute type
        #   The type of the event. Always `response.audio.transcript.delta`.
        #
        #   @return [Symbol, :"response.audio.transcript.delta"]
        required :type, const: :"response.audio.transcript.delta"

        # @!method initialize(delta:, type: :"response.audio.transcript.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseAudioTranscriptDeltaEvent} for more details.
        #
        #   Emitted when there is a partial transcript of audio.
        #
        #   @param delta [String] The partial transcript of the audio response.
        #
        #   @param type [Symbol, :"response.audio.transcript.delta"] The type of the event. Always `response.audio.transcript.delta`.
      end
    end
  end
end
