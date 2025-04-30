# frozen_string_literal: true

module OpenAI
  module Models
    class StaticFileChunkingStrategy < OpenAI::Internal::Type::BaseModel
      # @!attribute chunk_overlap_tokens
      #   The number of tokens that overlap between chunks. The default value is `400`.
      #
      #   Note that the overlap must not exceed half of `max_chunk_size_tokens`.
      #
      #   @return [Integer]
      required :chunk_overlap_tokens, Integer

      # @!attribute max_chunk_size_tokens
      #   The maximum number of tokens in each chunk. The default value is `800`. The
      #   minimum value is `100` and the maximum value is `4096`.
      #
      #   @return [Integer]
      required :max_chunk_size_tokens, Integer

      # @!method initialize(chunk_overlap_tokens:, max_chunk_size_tokens:)
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::StaticFileChunkingStrategy} for more details.
      #
      #   @param chunk_overlap_tokens [Integer] The number of tokens that overlap between chunks. The default value is `400`.
      #   ...
      #
      #   @param max_chunk_size_tokens [Integer] The maximum number of tokens in each chunk. The default value is `800`. The mini
      #   ...
    end
  end
end
