# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class TranslationVerbose < OpenAI::BaseModel
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

        # @!attribute [r] segments
        #   Segments of the translated text and their corresponding details.
        #
        #   @return [Array<OpenAI::Models::Audio::TranscriptionSegment>, nil]
        optional :segments, -> { OpenAI::ArrayOf[OpenAI::Models::Audio::TranscriptionSegment] }

        # @!parse
        #   # @return [Array<OpenAI::Models::Audio::TranscriptionSegment>]
        #   attr_writer :segments

        # @!parse
        #   # @param duration [Float]
        #   # @param language [String]
        #   # @param text [String]
        #   # @param segments [Array<OpenAI::Models::Audio::TranscriptionSegment>]
        #   #
        #   def initialize(duration:, language:, text:, segments: nil, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
