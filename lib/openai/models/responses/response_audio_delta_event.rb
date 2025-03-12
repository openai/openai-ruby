# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseAudioDeltaEvent < OpenAI::BaseModel
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

        # @!parse
        #   # Emitted when there is a partial audio response.
        #   #
        #   # @param delta [String]
        #   # @param type [Symbol, :"response.audio.delta"]
        #   #
        #   def initialize(delta:, type: :"response.audio.delta", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
