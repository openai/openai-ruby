# typed: strong

module OpenAI
  module Models
    # The strategy used to chunk the file.
    module FileChunkingStrategy
      extend OpenAI::Internal::Type::Union

      Variants =
        T.type_alias do
          T.any(
            OpenAI::StaticFileChunkingStrategyObject,
            OpenAI::OtherFileChunkingStrategyObject
          )
        end

      sig { override.returns(T::Array[OpenAI::FileChunkingStrategy::Variants]) }
      def self.variants
      end
    end
  end
end
