# typed: strong

module OpenAI
  module Models
    class StaticFileChunkingStrategyObjectParam < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(
            OpenAI::StaticFileChunkingStrategyObjectParam,
            OpenAI::Internal::AnyHash
          )
        end

      sig { returns(OpenAI::StaticFileChunkingStrategy) }
      attr_reader :static

      sig { params(static: OpenAI::StaticFileChunkingStrategy::OrHash).void }
      attr_writer :static

      # Always `static`.
      sig { returns(Symbol) }
      attr_accessor :type

      # Customize your own chunking strategy by setting chunk size and chunk overlap.
      sig do
        params(
          static: OpenAI::StaticFileChunkingStrategy::OrHash,
          type: Symbol
        ).returns(T.attached_class)
      end
      def self.new(
        static:,
        # Always `static`.
        type: :static
      )
      end

      sig do
        override.returns(
          { static: OpenAI::StaticFileChunkingStrategy, type: Symbol }
        )
      end
      def to_hash
      end
    end
  end
end
