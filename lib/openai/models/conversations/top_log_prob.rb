# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class TopLogProb < OpenAI::Internal::Type::BaseModel
        # @!attribute token
        #
        #   @return [String]
        required :token, String

        # @!attribute bytes
        #
        #   @return [Array<Integer>]
        required :bytes, OpenAI::Internal::Type::ArrayOf[Integer]

        # @!attribute logprob
        #
        #   @return [Float]
        required :logprob, Float

        # @!method initialize(token:, bytes:, logprob:)
        #   @param token [String]
        #   @param bytes [Array<Integer>]
        #   @param logprob [Float]
      end
    end
  end
end
