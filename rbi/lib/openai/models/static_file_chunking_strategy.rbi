# typed: strong

module OpenAI
  module Models
    class StaticFileChunkingStrategy < OpenAI::Internal::Type::BaseModel
      # The number of tokens that overlap between chunks. The default value is `400`.
      #
      #   Note that the overlap must not exceed half of `max_chunk_size_tokens`.
      sig { returns(Integer) }
      attr_accessor :chunk_overlap_tokens

      # The maximum number of tokens in each chunk. The default value is `800`. The
      #   minimum value is `100` and the maximum value is `4096`.
      sig { returns(Integer) }
      attr_accessor :max_chunk_size_tokens

      sig { params(chunk_overlap_tokens: Integer, max_chunk_size_tokens: Integer).returns(T.attached_class) }
      def self.new(chunk_overlap_tokens:, max_chunk_size_tokens:); end

      sig { override.returns({chunk_overlap_tokens: Integer, max_chunk_size_tokens: Integer}) }
      def to_hash; end
    end
  end
end
