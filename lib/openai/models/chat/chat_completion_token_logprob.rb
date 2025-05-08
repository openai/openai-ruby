# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionTokenLogprob < OpenAI::Internal::Type::BaseModel
        # @!attribute token
        #   The token.
        #
        #   @return [String]
        required :token, String

        # @!attribute bytes
        #   A list of integers representing the UTF-8 bytes representation of the token.
        #   Useful in instances where characters are represented by multiple tokens and
        #   their byte representations must be combined to generate the correct text
        #   representation. Can be `null` if there is no bytes representation for the token.
        #
        #   @return [Array<Integer>, nil]
        required :bytes, OpenAI::Internal::Type::ArrayOf[Integer], nil?: true

        # @!attribute logprob
        #   The log probability of this token, if it is within the top 20 most likely
        #   tokens. Otherwise, the value `-9999.0` is used to signify that the token is very
        #   unlikely.
        #
        #   @return [Float]
        required :logprob, Float

        # @!attribute top_logprobs
        #   List of the most likely tokens and their log probability, at this token
        #   position. In rare cases, there may be fewer than the number of requested
        #   `top_logprobs` returned.
        #
        #   @return [Array<OpenAI::Chat::ChatCompletionTokenLogprob::TopLogprob>]
        required :top_logprobs,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionTokenLogprob::TopLogprob] }

        # @!method initialize(token:, bytes:, logprob:, top_logprobs:)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Chat::ChatCompletionTokenLogprob} for more details.
        #
        #   @param token [String] The token.
        #
        #   @param bytes [Array<Integer>, nil] A list of integers representing the UTF-8 bytes representation of the token. Use
        #
        #   @param logprob [Float] The log probability of this token, if it is within the top 20 most likely tokens
        #
        #   @param top_logprobs [Array<OpenAI::Chat::ChatCompletionTokenLogprob::TopLogprob>] List of the most likely tokens and their log probability, at this token position

        class TopLogprob < OpenAI::Internal::Type::BaseModel
          # @!attribute token
          #   The token.
          #
          #   @return [String]
          required :token, String

          # @!attribute bytes
          #   A list of integers representing the UTF-8 bytes representation of the token.
          #   Useful in instances where characters are represented by multiple tokens and
          #   their byte representations must be combined to generate the correct text
          #   representation. Can be `null` if there is no bytes representation for the token.
          #
          #   @return [Array<Integer>, nil]
          required :bytes, OpenAI::Internal::Type::ArrayOf[Integer], nil?: true

          # @!attribute logprob
          #   The log probability of this token, if it is within the top 20 most likely
          #   tokens. Otherwise, the value `-9999.0` is used to signify that the token is very
          #   unlikely.
          #
          #   @return [Float]
          required :logprob, Float

          # @!method initialize(token:, bytes:, logprob:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Chat::ChatCompletionTokenLogprob::TopLogprob} for more details.
          #
          #   @param token [String] The token.
          #
          #   @param bytes [Array<Integer>, nil] A list of integers representing the UTF-8 bytes representation of the token. Use
          #
          #   @param logprob [Float] The log probability of this token, if it is within the top 20 most likely tokens
        end
      end
    end

    ChatCompletionTokenLogprob = Chat::ChatCompletionTokenLogprob
  end
end
