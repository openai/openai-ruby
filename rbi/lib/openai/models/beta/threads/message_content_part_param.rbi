# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        # References an image [File](https://platform.openai.com/docs/api-reference/files)
        #   in the content of a message.
        class MessageContentPartParam < OpenAI::Union
          abstract!

          Variants = type_template(:out) do
            {
              fixed: T.any(
                OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                OpenAI::Models::Beta::Threads::TextContentBlockParam
              )
            }
          end
        end
      end
    end
  end
end
