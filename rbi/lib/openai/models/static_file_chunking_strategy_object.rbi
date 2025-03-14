# typed: strong

module OpenAI
  module Models
    class StaticFileChunkingStrategyObject < OpenAI::BaseModel
      sig { returns(OpenAI::Models::StaticFileChunkingStrategy) }
      def static
      end

      sig { params(_: OpenAI::Models::StaticFileChunkingStrategy).returns(OpenAI::Models::StaticFileChunkingStrategy) }
      def static=(_)
      end

      # Always `static`.
      sig { returns(Symbol) }
      def type
      end

      sig { params(_: Symbol).returns(Symbol) }
      def type=(_)
      end

      sig { params(static: OpenAI::Models::StaticFileChunkingStrategy, type: Symbol).returns(T.attached_class) }
      def self.new(static:, type: :static)
      end

      sig { override.returns({static: OpenAI::Models::StaticFileChunkingStrategy, type: Symbol}) }
      def to_hash
      end
    end
  end
end
