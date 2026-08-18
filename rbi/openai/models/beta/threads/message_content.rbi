# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        # References an image [File](https://platform.openai.com/docs/api-reference/files)
        # in the content of a message.
        module MessageContent
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Beta::Threads::ImageFileContentBlock,
                OpenAI::Beta::Threads::ImageURLContentBlock,
                OpenAI::Beta::Threads::TextContentBlock,
                OpenAI::Beta::Threads::RefusalContentBlock
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Beta::Threads::MessageContent::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
