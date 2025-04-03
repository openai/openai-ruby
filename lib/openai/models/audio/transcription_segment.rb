# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      class TranscriptionSegment < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Unique identifier of the segment.
        #
        #   @return [Integer]
        required :id, Integer

        # @!attribute avg_logprob
        #   Average logprob of the segment. If the value is lower than -1, consider the
        #     logprobs failed.
        #
        #   @return [Float]
        required :avg_logprob, Float

        # @!attribute compression_ratio
        #   Compression ratio of the segment. If the value is greater than 2.4, consider the
        #     compression failed.
        #
        #   @return [Float]
        required :compression_ratio, Float

        # @!attribute end_
        #   End time of the segment in seconds.
        #
        #   @return [Float]
        required :end_, Float, api_name: :end

        # @!attribute no_speech_prob
        #   Probability of no speech in the segment. If the value is higher than 1.0 and the
        #     `avg_logprob` is below -1, consider this segment silent.
        #
        #   @return [Float]
        required :no_speech_prob, Float

        # @!attribute seek
        #   Seek offset of the segment.
        #
        #   @return [Integer]
        required :seek, Integer

        # @!attribute start
        #   Start time of the segment in seconds.
        #
        #   @return [Float]
        required :start, Float

        # @!attribute temperature
        #   Temperature parameter used for generating the segment.
        #
        #   @return [Float]
        required :temperature, Float

        # @!attribute text
        #   Text content of the segment.
        #
        #   @return [String]
        required :text, String

        # @!attribute tokens
        #   Array of token IDs for the text content.
        #
        #   @return [Array<Integer>]
        required :tokens, OpenAI::Internal::Type::ArrayOf[Integer]

        # @!parse
        #   # @param id [Integer]
        #   # @param avg_logprob [Float]
        #   # @param compression_ratio [Float]
        #   # @param end_ [Float]
        #   # @param no_speech_prob [Float]
        #   # @param seek [Integer]
        #   # @param start [Float]
        #   # @param temperature [Float]
        #   # @param text [String]
        #   # @param tokens [Array<Integer>]
        #   #
        #   def initialize(
        #     id:,
        #     avg_logprob:,
        #     compression_ratio:,
        #     end_:,
        #     no_speech_prob:,
        #     seek:,
        #     start:,
        #     temperature:,
        #     text:,
        #     tokens:,
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
