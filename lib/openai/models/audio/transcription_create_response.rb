# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # Represents a transcription response returned by model, based on the provided
      # input.
      #
      # @see OpenAI::Resources::Audio::Transcriptions#create
      #
      # @see OpenAI::Resources::Audio::Transcriptions#create_streaming
      module TranscriptionCreateResponse
        extend OpenAI::Internal::Type::Union

        # Represents a transcription response returned by model, based on the provided input.
        variant -> { OpenAI::Audio::Transcription }

        # Represents a verbose json transcription response returned by model, based on the provided input.
        variant -> { OpenAI::Audio::TranscriptionVerbose }

        # @!method self.variants
        #   @return [Array(OpenAI::Audio::Transcription, OpenAI::Audio::TranscriptionVerbose)]
      end
    end
  end
end
