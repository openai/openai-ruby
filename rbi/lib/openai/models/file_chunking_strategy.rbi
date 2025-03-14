# typed: strong

module OpenAI
  module Models
    # The strategy used to chunk the file.
    class FileChunkingStrategy < OpenAI::Union
      abstract!

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
