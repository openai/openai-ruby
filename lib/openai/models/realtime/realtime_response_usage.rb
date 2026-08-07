# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeResponseUsage < OpenAI::Internal::Type::BaseModel
        # @!attribute input_token_details
        #   Details about the input tokens used in the Response. Cached tokens are tokens
        #   from previous turns in the conversation that are included as context for the
        #   current response. Cached tokens here are counted as a subset of input tokens,
        #   meaning input tokens will include cached and uncached tokens.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeResponseUsageInputTokenDetails, nil]
        optional :input_token_details, -> { OpenAI::Realtime::RealtimeResponseUsageInputTokenDetails }

        # @!attribute input_tokens
        #   The number of input tokens used in the Response, including text and audio
        #   tokens.
        #
        #   @return [Integer, nil]
        optional :input_tokens, Integer

        # @!attribute output_token_details
        #   Details about the output tokens used in the Response.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeResponseUsageOutputTokenDetails, nil]
        optional :output_token_details, -> { OpenAI::Realtime::RealtimeResponseUsageOutputTokenDetails }

        # @!attribute output_tokens
        #   The number of output tokens sent in the Response, including text and audio
        #   tokens.
        #
        #   @return [Integer, nil]
        optional :output_tokens, Integer

        # @!attribute total_tokens
        #   The total number of tokens in the Response including input and output text and
        #   audio tokens.
        #
        #   @return [Integer, nil]
        optional :total_tokens, Integer

        # @!method initialize(input_token_details: nil, input_tokens: nil, output_token_details: nil, output_tokens: nil, total_tokens: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeResponseUsage} for more details.
        #
        #   Usage statistics for the Response, this will correspond to billing. A Realtime
        #   API session will maintain a conversation context and append new Items to the
        #   Conversation, thus output from previous turns (text and audio tokens) will
        #   become the input for later turns.
        #
        #   @param input_token_details [OpenAI::Models::Realtime::RealtimeResponseUsageInputTokenDetails] Details about the input tokens used in the Response. Cached tokens are tokens fr
        #
        #   @param input_tokens [Integer] The number of input tokens used in the Response, including text and
        #
        #   @param output_token_details [OpenAI::Models::Realtime::RealtimeResponseUsageOutputTokenDetails] Details about the output tokens used in the Response.
        #
        #   @param output_tokens [Integer] The number of output tokens sent in the Response, including text and
        #
        #   @param total_tokens [Integer] The total number of tokens in the Response including input and output
      end
    end
  end
end
