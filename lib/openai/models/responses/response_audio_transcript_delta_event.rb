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

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.audio.transcript.delta`.
        #
        #   @return [Symbol, :"response.audio.transcript.delta"]
        required :type, const: :"response.audio.transcript.delta"

        # @!method initialize(delta:, sequence_number:, type: :"response.audio.transcript.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent} for more details.
        #
        #   Emitted when there is a partial transcript of audio.
        #
        #   @param delta [String] The partial transcript of the audio response.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.audio.transcript.delta"] The type of the event. Always `response.audio.transcript.delta`.
      end
    end
  end
end
