# typed: strong

module OpenAI
  module Models
    module Responses
      # A piece of message content, such as text, an image, or a file.
      module ResponseFunctionCallOutputItem
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseInputTextContent,
              OpenAI::Responses::ResponseInputImageContent,
              OpenAI::Responses::ResponseInputFileContent
            )
          end

        sig do
          override.returns(
            T::Array[
              OpenAI::Responses::ResponseFunctionCallOutputItem::Variants
            ]
          )
        end
        def self.variants
        end
      end
    end
  end
end
