# typed: strong

module OpenAI
  module Models
    module Responses
      # A text input to the model.
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
