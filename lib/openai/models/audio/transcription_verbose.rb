# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class TranscriptionVerbose < OpenAI::Internal::Type::BaseModel
        # @!attribute duration
        #   The duration of the input audio.
        #
        #   @return [Float]
        required :duration, Float

        # @!attribute language
        #   The language of the input audio.
        #
        #   @return [String]
        required :language, String

        # @!attribute text
        #   The transcribed text.
        #
        #   @return [String]
        required :text, String

        # @!attribute segments
        #   Segments of the transcribed text and their corresponding details.
        #
        #   @return [Array<OpenAI::Models::Audio::TranscriptionSegment>, nil]
        optional :segments, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Audio::TranscriptionSegment] }

        # @!attribute words
        #   Extracted words and their corresponding timestamps.
        #
        #   @return [Array<OpenAI::Models::Audio::TranscriptionWord>, nil]
        optional :words, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Audio::TranscriptionWord] }

        # @!method initialize(duration:, language:, text:, segments: nil, words: nil)
        #   Represents a verbose json transcription response returned by model, based on the
        #   provided input.
        #
        #   @param duration [Float] The duration of the input audio.
        #
        #   @param language [String] The language of the input audio.
        #
        #   @param text [String] The transcribed text.
        #
        #   @param segments [Array<OpenAI::Models::Audio::TranscriptionSegment>] Segments of the transcribed text and their corresponding details.
        #
        #   @param words [Array<OpenAI::Models::Audio::TranscriptionWord>] Extracted words and their corresponding timestamps.
      end
    end
  end
end
