# typed: strong

module OpenAI
  module Models
    class FileChunkingStrategy < OpenAI::Union
      abstract!

      class << self
        sig do
          override
            .returns(
              [[Symbol, OpenAI::Models::StaticFileChunkingStrategyObject], [Symbol, OpenAI::Models::OtherFileChunkingStrategyObject]]
            )
        end
        private def variants
        end
      end
    end
  end
end
