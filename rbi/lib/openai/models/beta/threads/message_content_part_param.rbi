# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        # References an image [File](https://platform.openai.com/docs/api-reference/files)
        # in the content of a message.
        module MessageContentPartParam
          extend OpenAI::Internal::Type::Union

          sig do
            override
              .returns(
                [OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlockParam]
              )
          end
          def self.variants; end
        end
      end
    end
  end
end
