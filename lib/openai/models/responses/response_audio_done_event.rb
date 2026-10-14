# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseAudioDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute sequence_number
        #   The sequence number of the delta.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.audio.done`.
        #
        #   @return [Symbol, :"response.audio.done"]
        required :type, const: :"response.audio.done"

        # @!method initialize(sequence_number:, type: :"response.audio.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseAudioDoneEvent} for more details.
        #
        #   Emitted when the audio response is complete.
        #
        #   @param sequence_number [Integer] The sequence number of the delta.
        #
        #   @param type [Symbol, :"response.audio.done"] The type of the event. Always `response.audio.done`.
      end
    end
  end
end
