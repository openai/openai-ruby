# typed: strong

module OpenAI
  module Models
    module Beta
      class ChatKitUploadFileParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::ChatKitUploadFileParams,
              OpenAI::Internal::AnyHash
            )
          end

        # Binary file contents to store with the ChatKit session. Supports PDFs and PNG,
        # JPG, JPEG, GIF, or WEBP images.
        sig { returns(OpenAI::Internal::FileInput) }
        attr_accessor :file

        sig do
          params(
            file: OpenAI::Internal::FileInput,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Binary file contents to store with the ChatKit session. Supports PDFs and PNG,
          # JPG, JPEG, GIF, or WEBP images.
          file:,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              file: OpenAI::Internal::FileInput,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
