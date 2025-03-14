# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        # References an image [File](https://platform.openai.com/docs/api-reference/files)
        #   in the content of a message.
        class MessageContentPartParam < OpenAI::Union
          abstract!

          class << self
            # @api private
            sig do
              override
                .returns(
                  [[Symbol, OpenAI::Models::Beta::Threads::ImageFileContentBlock], [Symbol, OpenAI::Models::Beta::Threads::ImageURLContentBlock], [Symbol, OpenAI::Models::Beta::Threads::TextContentBlockParam]]
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
