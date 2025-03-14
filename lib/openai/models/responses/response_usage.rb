# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseUsage < OpenAI::BaseModel
        # @!attribute input_tokens
        #   The number of input tokens.
        #
        #   @return [Integer]
        required :input_tokens, Integer

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

        # @!parse
        #   # Represents token usage details including input tokens, output tokens, a
        #   #   breakdown of output tokens, and the total tokens used.
        #   #
        #   # @param input_tokens [Integer]
        #   # @param output_tokens [Integer]
        #   # @param output_tokens_details [OpenAI::Models::Responses::ResponseUsage::OutputTokensDetails]
        #   # @param total_tokens [Integer]
        #   #
        #   def initialize(input_tokens:, output_tokens:, output_tokens_details:, total_tokens:, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        class OutputTokensDetails < OpenAI::BaseModel
          # @!attribute reasoning_tokens
          #   The number of reasoning tokens.
          #
          #   @return [Integer]
          required :reasoning_tokens, Integer

          # @!parse
          #   # A detailed breakdown of the output tokens.
          #   #
          #   # @param reasoning_tokens [Integer]
          #   #
          #   def initialize(reasoning_tokens:, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end
  end
end
