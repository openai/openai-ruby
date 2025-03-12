# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @abstract
      #
      # Represents a transcription response returned by model, based on the provided
      #   input.
      class TranscriptionCreateResponse < OpenAI::Union
        # Represents a transcription response returned by model, based on the provided input.
        variant -> { OpenAI::Models::Audio::Transcription }

        # Represents a verbose json transcription response returned by model, based on the provided input.
        variant -> { OpenAI::Models::Audio::TranscriptionVerbose }
      end
    end
  end
end
