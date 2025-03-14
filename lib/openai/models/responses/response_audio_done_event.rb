# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseAudioDoneEvent < OpenAI::BaseModel
        # @!attribute type
        #   The type of the event. Always `response.audio.done`.
        #
        #   @return [Symbol, :"response.audio.done"]
        required :type, const: :"response.audio.done"

        # @!parse
        #   # Emitted when the audio response is complete.
        #   #
        #   # @param type [Symbol, :"response.audio.done"]
        #   #
        #   def initialize(type: :"response.audio.done", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
