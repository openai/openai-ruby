# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseAudioTranscriptDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the event. Always `response.audio.transcript.done`.
        #
        #   @return [Symbol, :"response.audio.transcript.done"]
        required :type, const: :"response.audio.transcript.done"

        # @!method initialize(type: :"response.audio.transcript.done")
        #   Emitted when the full audio transcript is completed.
        #
        #   @param type [Symbol, :"response.audio.transcript.done"]
      end
    end
  end
end
