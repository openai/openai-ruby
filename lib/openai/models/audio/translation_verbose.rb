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
        #   @return [Array<OpenAI::Audio::TranscriptionSegment>, nil]
        optional :segments, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Audio::TranscriptionSegment] }

        # @!method initialize(duration:, language:, text:, segments: nil)
        #   @param duration [Float] The duration of the input audio.
        #
        #   @param language [String] The language of the output translation (always `english`).
        #
        #   @param text [String] The translated text.
        #
        #   @param segments [Array<OpenAI::Audio::TranscriptionSegment>] Segments of the translated text and their corresponding details.
      end
    end
  end
end
