# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module Audio
      class TranscriptionLanguage < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #   The code of a language detected in the audio.
        #
        #   @return [String]
        required :code, String

        # @!method initialize(code:)
        #   A language detected in transcribed audio.
        #
        #   @param code [String] The code of a language detected in the audio.
      end
    end
  end
end
