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
            # @api private
            sig do
              override
                .returns(
                  [[Symbol, OpenAI::Models::Beta::Threads::ImageFileDeltaBlock], [Symbol, OpenAI::Models::Beta::Threads::TextDeltaBlock], [Symbol, OpenAI::Models::Beta::Threads::RefusalDeltaBlock], [Symbol, OpenAI::Models::Beta::Threads::ImageURLDeltaBlock]]
                )
            end
            private def variants
            end
          end
        end
      end
    end
  end
end
