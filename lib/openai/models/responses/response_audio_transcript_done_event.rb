# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseAudioTranscriptDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.audio.transcript.done`.
        #
        #   @return [Symbol, :"response.audio.transcript.done"]
        required :type, const: :"response.audio.transcript.done"

        # @!method initialize(sequence_number:, type: :"response.audio.transcript.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent} for more details.
        #
        #   Emitted when the full audio transcript is completed.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.audio.transcript.done"] The type of the event. Always `response.audio.transcript.done`.
      end
    end
  end
end
