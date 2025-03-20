# typed: strong

module OpenAI
  module Models
    class StaticFileChunkingStrategyObjectParam < OpenAI::BaseModel
      sig { returns(OpenAI::Models::StaticFileChunkingStrategy) }
      def static
      end

      sig do
        params(_: T.any(OpenAI::Models::StaticFileChunkingStrategy, OpenAI::Util::AnyHash))
          .returns(T.any(OpenAI::Models::StaticFileChunkingStrategy, OpenAI::Util::AnyHash))
      end
      def static=(_)
      end

      # Always `static`.
      sig { returns(Symbol) }
      def type
      end

      sig { params(_: Symbol).returns(Symbol) }
      def type=(_)
      end

      # Customize your own chunking strategy by setting chunk size and chunk overlap.
      sig { params(static: OpenAI::Models::StaticFileChunkingStrategy, type: Symbol).returns(T.attached_class) }
      def self.new(static:, type: :static)
      end

      sig { override.returns({static: OpenAI::Models::StaticFileChunkingStrategy, type: Symbol}) }
      def to_hash
      end
    end
  end
end
