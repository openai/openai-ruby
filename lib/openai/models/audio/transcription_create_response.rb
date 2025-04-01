# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # Represents a transcription response returned by model, based on the provided
      #   input.
      #
      # @see OpenAI::Resources::Audio::Transcriptions#create
      #
      # @see OpenAI::Resources::Audio::Transcriptions#create_streaming
      module TranscriptionCreateResponse
        extend OpenAI::Union

        # Represents a transcription response returned by model, based on the provided input.
        variant -> { OpenAI::Models::Audio::Transcription }

        # Represents a verbose json transcription response returned by model, based on the provided input.
        variant -> { OpenAI::Models::Audio::TranscriptionVerbose }

        # @!parse
        #   # @return [Array(OpenAI::Models::Audio::Transcription, OpenAI::Models::Audio::TranscriptionVerbose)]
        #   def self.variants; end
      end
    end
  end
end
