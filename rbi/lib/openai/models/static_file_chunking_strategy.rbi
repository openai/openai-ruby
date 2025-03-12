# typed: strong

module OpenAI
  module Models
    class StaticFileChunkingStrategy < OpenAI::BaseModel
      sig { returns(Integer) }
      def chunk_overlap_tokens
      end

      sig { params(_: Integer).returns(Integer) }
      def chunk_overlap_tokens=(_)
      end

      sig { returns(Integer) }
      def max_chunk_size_tokens
      end

      sig { params(_: Integer).returns(Integer) }
      def max_chunk_size_tokens=(_)
      end

      sig { params(chunk_overlap_tokens: Integer, max_chunk_size_tokens: Integer).returns(T.attached_class) }
      def self.new(chunk_overlap_tokens:, max_chunk_size_tokens:)
      end

      sig { override.returns({chunk_overlap_tokens: Integer, max_chunk_size_tokens: Integer}) }
      def to_hash
      end
    end
  end
end
