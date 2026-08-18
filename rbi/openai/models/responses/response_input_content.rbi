# typed: strong

module OpenAI
  module Models

    module Responses

      # A text input to the model.
      module ResponseInputContent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseInputText,
            OpenAI::Responses::ResponseInputImage,
            OpenAI::Responses::ResponseInputFile
          )
        end

        sig { override.returns(T::Array[OpenAI::Responses::ResponseInputContent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
