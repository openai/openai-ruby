# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        # References an image [File](https://platform.openai.com/docs/api-reference/files)
        # in the content of a message.
        module MessageContentDelta
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Beta::Threads::ImageFileDeltaBlock,
                OpenAI::Beta::Threads::TextDeltaBlock,
                OpenAI::Beta::Threads::RefusalDeltaBlock,
                OpenAI::Beta::Threads::ImageURLDeltaBlock
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Beta::Threads::MessageContentDelta::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
