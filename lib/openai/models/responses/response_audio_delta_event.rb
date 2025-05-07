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

        # @!attribute type
        #   The type of the event. Always `response.audio.delta`.
        #
        #   @return [Symbol, :"response.audio.delta"]
        required :type, const: :"response.audio.delta"

        # @!method initialize(delta:, type: :"response.audio.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseAudioDeltaEvent} for more details.
        #
        #   Emitted when there is a partial audio response.
        #
        #   @param delta [String] A chunk of Base64 encoded response audio bytes.
        #
        #   @param type [Symbol, :"response.audio.delta"] The type of the event. Always `response.audio.delta`.
      end
    end
  end
end
