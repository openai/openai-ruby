# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class LobProb < OpenAI::Internal::Type::BaseModel
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

        # @!attribute top_logprobs
        #
        #   @return [Array<OpenAI::Models::Conversations::TopLogProb>]
        required :top_logprobs, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Conversations::TopLogProb] }

        # @!method initialize(token:, bytes:, logprob:, top_logprobs:)
        #   @param token [String]
        #   @param bytes [Array<Integer>]
        #   @param logprob [Float]
        #   @param top_logprobs [Array<OpenAI::Models::Conversations::TopLogProb>]
      end
    end
  end
end
