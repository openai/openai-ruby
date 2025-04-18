# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseUsage < OpenAI::Internal::Type::BaseModel
        # @!attribute input_tokens
        #   The number of input tokens.
        #
        #   @return [Integer]
        required :input_tokens, Integer

        # @!attribute input_tokens_details
        #   A detailed breakdown of the input tokens.
        #
        #   @return [OpenAI::Models::Responses::ResponseUsage::InputTokensDetails]
        required :input_tokens_details, -> { OpenAI::Models::Responses::ResponseUsage::InputTokensDetails }

        # @!attribute output_tokens
        #   The number of output tokens.
        #
        #   @return [Integer]
        required :output_tokens, Integer

        # @!attribute output_tokens_details
        #   A detailed breakdown of the output tokens.
        #
        #   @return [OpenAI::Models::Responses::ResponseUsage::OutputTokensDetails]
        required :output_tokens_details, -> { OpenAI::Models::Responses::ResponseUsage::OutputTokensDetails }

        # @!attribute total_tokens
        #   The total number of tokens used.
        #
        #   @return [Integer]
        required :total_tokens, Integer

        # @!method initialize(input_tokens:, input_tokens_details:, output_tokens:, output_tokens_details:, total_tokens:)
        #   Represents token usage details including input tokens, output tokens, a
        #   breakdown of output tokens, and the total tokens used.
        #
        #   @param input_tokens [Integer]
        #   @param input_tokens_details [OpenAI::Models::Responses::ResponseUsage::InputTokensDetails]
        #   @param output_tokens [Integer]
        #   @param output_tokens_details [OpenAI::Models::Responses::ResponseUsage::OutputTokensDetails]
        #   @param total_tokens [Integer]

        # @see OpenAI::Models::Responses::ResponseUsage#input_tokens_details
        class InputTokensDetails < OpenAI::Internal::Type::BaseModel
          # @!attribute cached_tokens
          #   The number of tokens that were retrieved from the cache.
          #   [More on prompt caching](https://platform.openai.com/docs/guides/prompt-caching).
          #
          #   @return [Integer]
          required :cached_tokens, Integer

          # @!method initialize(cached_tokens:)
          #   A detailed breakdown of the input tokens.
          #
          #   @param cached_tokens [Integer]
        end

        # @see OpenAI::Models::Responses::ResponseUsage#output_tokens_details
        class OutputTokensDetails < OpenAI::Internal::Type::BaseModel
          # @!attribute reasoning_tokens
          #   The number of reasoning tokens.
          #
          #   @return [Integer]
          required :reasoning_tokens, Integer

          # @!method initialize(reasoning_tokens:)
          #   A detailed breakdown of the output tokens.
          #
          #   @param reasoning_tokens [Integer]
        end
      end
    end
  end
end
