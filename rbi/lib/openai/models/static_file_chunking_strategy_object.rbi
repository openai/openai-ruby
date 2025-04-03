# typed: strong

module OpenAI
  module Models
    class StaticFileChunkingStrategyObject < OpenAI::Internal::Type::BaseModel
      sig { returns(OpenAI::Models::StaticFileChunkingStrategy) }
      attr_reader :static

      sig { params(static: T.any(OpenAI::Models::StaticFileChunkingStrategy, OpenAI::Internal::AnyHash)).void }
      attr_writer :static

      # Always `static`.
      sig { returns(Symbol) }
      attr_accessor :type

      sig do
        params(static: T.any(OpenAI::Models::StaticFileChunkingStrategy, OpenAI::Internal::AnyHash), type: Symbol)
          .returns(T.attached_class)
      end
      def self.new(static:, type: :static)
      end

      sig { override.returns({static: OpenAI::Models::StaticFileChunkingStrategy, type: Symbol}) }
      def to_hash
      end
    end
  end
end
