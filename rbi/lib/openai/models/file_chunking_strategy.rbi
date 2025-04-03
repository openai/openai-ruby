# typed: strong

module OpenAI
  module Models
    # The strategy used to chunk the file.
    module FileChunkingStrategy
      extend OpenAI::Internal::Type::Union

      sig do
        override
          .returns(
            [OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject]
          )
      end
      def self.variants
      end
    end
  end
end
