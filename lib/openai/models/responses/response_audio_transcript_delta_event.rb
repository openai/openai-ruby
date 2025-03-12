# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseAudioTranscriptDeltaEvent < OpenAI::BaseModel
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

        # @!parse
        #   # Emitted when there is a partial transcript of audio.
        #   #
        #   # @param delta [String]
        #   # @param type [Symbol, :"response.audio.transcript.delta"]
        #   #
        #   def initialize(delta:, type: :"response.audio.transcript.delta", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
