# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class TranscriptionWord < OpenAI::Internal::Type::BaseModel
        # @!attribute end_
        #   End time of the word in seconds.
        #
        #   @return [Float]
        required :end_, Float, api_name: :end

        # @!attribute start
        #   Start time of the word in seconds.
        #
        #   @return [Float]
        required :start, Float

        # @!attribute word
        #   The text content of the word.
        #
        #   @return [String]
        required :word, String

        # @!method initialize(end_:, start:, word:)
        #   @param end_ [Float]
        #   @param start [Float]
        #   @param word [String]
      end
    end
  end
end
