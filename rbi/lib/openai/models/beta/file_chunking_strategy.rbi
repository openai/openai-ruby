# typed: strong

module OpenAI
  module Models
    module Beta
      # The strategy used to chunk the file.
      class FileChunkingStrategy < OpenAI::Union
        abstract!

        class << self
          sig do
            override
              .returns(
                [OpenAI::Models::Beta::StaticFileChunkingStrategyObject, OpenAI::Models::Beta::OtherFileChunkingStrategyObject]
              )
          end
          def variants
          end
        end
      end
    end
  end
end
