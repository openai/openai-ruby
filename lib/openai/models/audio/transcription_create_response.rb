# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # Represents a transcription response returned by model, based on the provided
      #   input.
      module TranscriptionCreateResponse
        extend OpenAI::Union

        # Represents a transcription response returned by model, based on the provided input.
        variant -> { OpenAI::Models::Audio::Transcription }

        # Represents a verbose json transcription response returned by model, based on the provided input.
        variant -> { OpenAI::Models::Audio::TranscriptionVerbose }

        # @!parse
        #   class << self
        #     # @return [Array(OpenAI::Models::Audio::Transcription, OpenAI::Models::Audio::TranscriptionVerbose)]
        #     def variants; end
        #   end
      end
    end
  end
end
