# typed: strong

module OpenAI
  module Models
    class AutoFileChunkingStrategyParam < OpenAI::Internal::Type::BaseModel
      OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

      # Always `auto`.
      sig { returns(Symbol) }
      attr_accessor :type

      # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of
      # `800` and `chunk_overlap_tokens` of `400`.
      sig { params(type: Symbol).returns(T.attached_class) }
      def self.new(
        # Always `auto`.
        type: :auto
      )
      end

      sig { override.returns({ type: Symbol }) }
      def to_hash
      end
    end
  end
end
