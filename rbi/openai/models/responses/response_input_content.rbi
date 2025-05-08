# typed: strong

module OpenAI
  module Models
    module Responses
      # A text input to the model.
      module ResponseInputContent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseInputText,
              OpenAI::Responses::ResponseInputImage,
              OpenAI::Responses::ResponseInputFile
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::Responses::ResponseInputContent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
