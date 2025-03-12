# typed: strong

module OpenAI
  module Models
    class FileChunkingStrategyParam < OpenAI::Union
      abstract!

      class << self
        sig do
          override
            .returns(
              [[Symbol, OpenAI::Models::AutoFileChunkingStrategyParam], [Symbol, OpenAI::Models::StaticFileChunkingStrategyObjectParam]]
            )
        end
        private def variants
        end
      end
    end
  end
end
