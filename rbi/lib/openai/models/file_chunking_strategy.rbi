# typed: strong

module OpenAI
  module Models
    # The strategy used to chunk the file.
    module FileChunkingStrategy
      extend OpenAI::Union

      Variants =
        type_template(:out) do
          {
            fixed: T.any(OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject)
          }
        end

      class << self
        sig do
          override
            .returns(
              [OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject]
            )
        end
        def variants
        end
      end
    end
  end
end
