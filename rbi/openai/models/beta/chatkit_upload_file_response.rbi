# typed: strong

module OpenAI
  module Models
    module Beta
      # Represents either a file or image attachment.
      module ChatKitUploadFileResponse
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(OpenAI::Beta::FilePart, OpenAI::Beta::ImagePart)
          end

        sig do
          override.returns(
            T::Array[OpenAI::Models::Beta::ChatKitUploadFileResponse::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
