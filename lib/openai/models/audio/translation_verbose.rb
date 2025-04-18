# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class TranslationVerbose < OpenAI::Internal::Type::BaseModel
        # @!attribute duration
        #   The duration of the input audio.
        #
        #   @return [Float]
        required :duration, Float

        # @!attribute language
        #   The language of the output translation (always `english`).
        #
        #   @return [String]
        required :language, String

        # @!attribute text
        #   The translated text.
        #
        #   @return [String]
        required :text, String

        # @!attribute segments
        #   Segments of the translated text and their corresponding details.
        #
        #   @return [Array<OpenAI::Models::Audio::TranscriptionSegment>, nil]
        optional :segments, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Audio::TranscriptionSegment] }

        # @!method initialize(duration:, language:, text:, segments: nil)
        #   @param duration [Float]
        #   @param language [String]
        #   @param text [String]
        #   @param segments [Array<OpenAI::Models::Audio::TranscriptionSegment>]
      end
    end
  end
end
