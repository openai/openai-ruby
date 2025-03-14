# typed: strong

module OpenAI
  module Models
    # The strategy used to chunk the file.
    class FileChunkingStrategy < OpenAI::Union
      abstract!

      class << self
        # @api private
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
