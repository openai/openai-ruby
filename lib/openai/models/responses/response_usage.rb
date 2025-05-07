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
        #   @return [OpenAI::Responses::ResponseUsage::InputTokensDetails]
        required :input_tokens_details, -> { OpenAI::Responses::ResponseUsage::InputTokensDetails }

        # @!attribute output_tokens
        #   The number of output tokens.
        #
        #   @return [Integer]
        required :output_tokens, Integer

        # @!attribute output_tokens_details
        #   A detailed breakdown of the output tokens.
        #
        #   @return [OpenAI::Responses::ResponseUsage::OutputTokensDetails]
        required :output_tokens_details, -> { OpenAI::Responses::ResponseUsage::OutputTokensDetails }

        # @!attribute total_tokens
        #   The total number of tokens used.
        #
        #   @return [Integer]
        required :total_tokens, Integer

        # @!method initialize(input_tokens:, input_tokens_details:, output_tokens:, output_tokens_details:, total_tokens:)
        #   Represents token usage details including input tokens, output tokens, a
        #   breakdown of output tokens, and the total tokens used.
        #
        #   @param input_tokens [Integer] The number of input tokens.
        #
        #   @param input_tokens_details [OpenAI::Responses::ResponseUsage::InputTokensDetails] A detailed breakdown of the input tokens.
        #
        #   @param output_tokens [Integer] The number of output tokens.
        #
        #   @param output_tokens_details [OpenAI::Responses::ResponseUsage::OutputTokensDetails] A detailed breakdown of the output tokens.
        #
        #   @param total_tokens [Integer] The total number of tokens used.

        # @see OpenAI::Responses::ResponseUsage#input_tokens_details
        class InputTokensDetails < OpenAI::Internal::Type::BaseModel
          # @!attribute cached_tokens
          #   The number of tokens that were retrieved from the cache.
          #   [More on prompt caching](https://platform.openai.com/docs/guides/prompt-caching).
          #
          #   @return [Integer]
          required :cached_tokens, Integer

          # @!method initialize(cached_tokens:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Responses::ResponseUsage::InputTokensDetails} for more details.
          #
          #   A detailed breakdown of the input tokens.
          #
          #   @param cached_tokens [Integer] The number of tokens that were retrieved from the cache.
        end

        # @see OpenAI::Responses::ResponseUsage#output_tokens_details
        class OutputTokensDetails < OpenAI::Internal::Type::BaseModel
          # @!attribute reasoning_tokens
          #   The number of reasoning tokens.
          #
          #   @return [Integer]
          required :reasoning_tokens, Integer

          # @!method initialize(reasoning_tokens:)
          #   A detailed breakdown of the output tokens.
          #
          #   @param reasoning_tokens [Integer] The number of reasoning tokens.
        end
      end
    end
  end
end
