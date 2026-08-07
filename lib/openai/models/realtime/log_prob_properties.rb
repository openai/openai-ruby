# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class LogProbProperties < OpenAI::Internal::Type::BaseModel
        # @!attribute token
        #   The token that was used to generate the log probability.
        #
        #   @return [String]
        required :token, String

        # @!attribute bytes
        #   The bytes that were used to generate the log probability.
        #
        #   @return [Array<Integer>]
        required :bytes, OpenAI::Internal::Type::ArrayOf[Integer]

        # @!attribute logprob
        #   The log probability of the token.
        #
        #   @return [Float]
        required :logprob, Float

        # @!method initialize(token:, bytes:, logprob:)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::LogProbProperties} for more details.
        #
        #   A log probability object.
        #
        #   @param token [String] The token that was used to generate the log probability.
        #
        #   @param bytes [Array<Integer>] The bytes that were used to generate the log probability.
        #
        #   @param logprob [Float] The log probability of the token.
      end
    end
  end
end
