# typed: strong

module OpenAI
  module Models

    module Beta

      module Threads

        # References an image
        # [File](https://developers.openai.com/api/reference/resources/files) in the
        # content of a message.
        module MessageContentPartParam
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias do
            T.any(
              OpenAI::Beta::Threads::ImageFileContentBlock,
              OpenAI::Beta::Threads::ImageURLContentBlock,
              OpenAI::Beta::Threads::TextContentBlockParam
            )
          end

          sig { override.returns(T::Array[OpenAI::Beta::Threads::MessageContentPartParam::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
