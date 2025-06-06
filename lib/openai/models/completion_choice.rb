# frozen_string_literal: true

module OpenAI
  module Models
    class CompletionChoice < OpenAI::Internal::Type::BaseModel
      # @!attribute finish_reason
      #   The reason the model stopped generating tokens. This will be `stop` if the model
      #   hit a natural stop point or a provided stop sequence, `length` if the maximum
      #   number of tokens specified in the request was reached, or `content_filter` if
      #   content was omitted due to a flag from our content filters.
      #
      #   @return [Symbol, OpenAI::Models::CompletionChoice::FinishReason]
      required :finish_reason, enum: -> { OpenAI::CompletionChoice::FinishReason }

      # @!attribute index
      #
      #   @return [Integer]
      required :index, Integer

      # @!attribute logprobs
      #
      #   @return [OpenAI::Models::CompletionChoice::Logprobs, nil]
      required :logprobs, -> { OpenAI::CompletionChoice::Logprobs }, nil?: true

      # @!attribute text
      #
      #   @return [String]
      required :text, String

      # @!method initialize(finish_reason:, index:, logprobs:, text:)
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::CompletionChoice} for more details.
      #
      #   @param finish_reason [Symbol, OpenAI::Models::CompletionChoice::FinishReason] The reason the model stopped generating tokens. This will be `stop` if the model
      #
      #   @param index [Integer]
      #
      #   @param logprobs [OpenAI::Models::CompletionChoice::Logprobs, nil]
      #
      #   @param text [String]

      # The reason the model stopped generating tokens. This will be `stop` if the model
      # hit a natural stop point or a provided stop sequence, `length` if the maximum
      # number of tokens specified in the request was reached, or `content_filter` if
      # content was omitted due to a flag from our content filters.
      #
      # @see OpenAI::Models::CompletionChoice#finish_reason
      module FinishReason
        extend OpenAI::Internal::Type::Enum

        STOP = :stop
        LENGTH = :length
        CONTENT_FILTER = :content_filter

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # @see OpenAI::Models::CompletionChoice#logprobs
      class Logprobs < OpenAI::Internal::Type::BaseModel
        # @!attribute text_offset
        #
        #   @return [Array<Integer>, nil]
        optional :text_offset, OpenAI::Internal::Type::ArrayOf[Integer]

        # @!attribute token_logprobs
        #
        #   @return [Array<Float>, nil]
        optional :token_logprobs, OpenAI::Internal::Type::ArrayOf[Float]

        # @!attribute tokens
        #
        #   @return [Array<String>, nil]
        optional :tokens, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute top_logprobs
        #
        #   @return [Array<Hash{Symbol=>Float}>, nil]
        optional :top_logprobs, OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::HashOf[Float]]

        # @!method initialize(text_offset: nil, token_logprobs: nil, tokens: nil, top_logprobs: nil)
        #   @param text_offset [Array<Integer>]
        #   @param token_logprobs [Array<Float>]
        #   @param tokens [Array<String>]
        #   @param top_logprobs [Array<Hash{Symbol=>Float}>]
      end
    end
  end
end
