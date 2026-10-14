# typed: strong

module OpenAI
  module Models
    # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
    # strategy. Only applicable if `file_ids` is non-empty.
    module FileChunkingStrategyParam
      extend OpenAI::Internal::Type::Union

      Variants =
        T.type_alias do
          T.any(
            OpenAI::AutoFileChunkingStrategyParam,
            OpenAI::StaticFileChunkingStrategyObjectParam
          )
        end

      sig do
        override.returns(T::Array[OpenAI::FileChunkingStrategyParam::Variants])
      end
      def self.variants
      end
    end
  end
end
