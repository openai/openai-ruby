# typed: strong

module OpenAI
  module Models
    # The strategy used to chunk the file.
    class FileChunkingStrategy < OpenAI::Union
      abstract!

      Variants =
        type_template(:out) do
          {
            fixed: T.any(OpenAI::Models::StaticFileChunkingStrategyObject, OpenAI::Models::OtherFileChunkingStrategyObject)
          }
        end
    end
  end
end
