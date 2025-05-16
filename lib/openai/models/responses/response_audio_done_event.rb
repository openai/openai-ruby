# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseAudioDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the event. Always `response.audio.done`.
        #
        #   @return [Symbol, :"response.audio.done"]
        required :type, const: :"response.audio.done"

        # @!method initialize(type: :"response.audio.done")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseAudioDoneEvent} for more details.
        #
        #   Emitted when the audio response is complete.
        #
        #   @param type [Symbol, :"response.audio.done"] The type of the event. Always `response.audio.done`.
      end
    end
  end
end
