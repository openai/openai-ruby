# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        # References an image [File](https://platform.openai.com/docs/api-reference/files)
        #   in the content of a message.
        class MessageContentDelta < OpenAI::Union
          abstract!

          class << self
            sig do
              override
                .returns(
                  [OpenAI::Models::Beta::Threads::ImageFileDeltaBlock, OpenAI::Models::Beta::Threads::TextDeltaBlock, OpenAI::Models::Beta::Threads::RefusalDeltaBlock, OpenAI::Models::Beta::Threads::ImageURLDeltaBlock]
                )
            end
            def variants
            end
          end
        end
      end
    end
  end
end
