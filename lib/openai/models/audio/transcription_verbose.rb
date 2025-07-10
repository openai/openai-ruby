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

        # @!attribute usage
        #   Usage statistics for models billed by audio input duration.
        #
        #   @return [OpenAI::Models::Audio::TranscriptionVerbose::Usage, nil]
        optional :usage, -> { OpenAI::Audio::TranscriptionVerbose::Usage }

        # @!attribute words
        #   Extracted words and their corresponding timestamps.
        #
        #   @return [Array<OpenAI::Models::Audio::TranscriptionWord>, nil]
        optional :words, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Audio::TranscriptionWord] }

        # @!method initialize(duration:, language:, text:, segments: nil, usage: nil, words: nil)
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
        #   @param usage [OpenAI::Models::Audio::TranscriptionVerbose::Usage] Usage statistics for models billed by audio input duration.
        #
        #   @param words [Array<OpenAI::Models::Audio::TranscriptionWord>] Extracted words and their corresponding timestamps.

        # @see OpenAI::Models::Audio::TranscriptionVerbose#usage
        class Usage < OpenAI::Internal::Type::BaseModel
          # @!attribute seconds
          #   Duration of the input audio in seconds.
          #
          #   @return [Float]
          required :seconds, Float

          # @!attribute type
          #   The type of the usage object. Always `duration` for this variant.
          #
          #   @return [Symbol, :duration]
          required :type, const: :duration

          # @!method initialize(seconds:, type: :duration)
          #   Usage statistics for models billed by audio input duration.
          #
          #   @param seconds [Float] Duration of the input audio in seconds.
          #
          #   @param type [Symbol, :duration] The type of the usage object. Always `duration` for this variant.
        end
      end
    end
  end
end
