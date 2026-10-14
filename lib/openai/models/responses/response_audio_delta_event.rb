# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseAudioDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   A chunk of Base64 encoded response audio bytes.
        #
        #   @return [String]
        required :delta, String

        # @!attribute sequence_number
        #   A sequence number for this chunk of the stream response.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.audio.delta`.
        #
        #   @return [Symbol, :"response.audio.delta"]
        required :type, const: :"response.audio.delta"

        # @!method initialize(delta:, sequence_number:, type: :"response.audio.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseAudioDeltaEvent} for more details.
        #
        #   Emitted when there is a partial audio response.
        #
        #   @param delta [String] A chunk of Base64 encoded response audio bytes.
        #
        #   @param sequence_number [Integer] A sequence number for this chunk of the stream response.
        #
        #   @param type [Symbol, :"response.audio.delta"] The type of the event. Always `response.audio.delta`.
      end
    end
  end
end
