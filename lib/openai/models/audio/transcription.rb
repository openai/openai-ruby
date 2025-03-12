# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class Transcription < OpenAI::BaseModel
        # @!attribute text
        #   The transcribed text.
        #
        #   @return [String]
        required :text, String

        # @!parse
        #   # Represents a transcription response returned by model, based on the provided
        #   #   input.
        #   #
        #   # @param text [String]
        #   #
        #   def initialize(text:, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
