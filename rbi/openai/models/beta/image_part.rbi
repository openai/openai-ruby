# typed: strong

module OpenAI
  module Models
    module Beta
      class ImagePart < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::ImagePart, OpenAI::Internal::AnyHash)
          end

        # Unique identifier for the uploaded image.
        sig { returns(String) }
        attr_accessor :id

        # MIME type of the uploaded image.
        sig { returns(String) }
        attr_accessor :mime_type

        # Original filename for the uploaded image. Defaults to null when unnamed.
        sig { returns(T.nilable(String)) }
        attr_accessor :name

        # Preview URL that can be rendered inline for the image.
        sig { returns(String) }
        attr_accessor :preview_url

        # Type discriminator that is always `image`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Signed URL for downloading the uploaded image. Defaults to null when no download
        # link is available.
        sig { returns(T.nilable(String)) }
        attr_accessor :upload_url

        # Metadata for an image uploaded through ChatKit.
        sig do
          params(
            id: String,
            mime_type: String,
            name: T.nilable(String),
            preview_url: String,
            upload_url: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Unique identifier for the uploaded image.
          id:,
          # MIME type of the uploaded image.
          mime_type:,
          # Original filename for the uploaded image. Defaults to null when unnamed.
          name:,
          # Preview URL that can be rendered inline for the image.
          preview_url:,
          # Signed URL for downloading the uploaded image. Defaults to null when no download
          # link is available.
          upload_url:,
          # Type discriminator that is always `image`.
          type: :image
        )
        end

        sig do
          override.returns(
            {
              id: String,
              mime_type: String,
              name: T.nilable(String),
              preview_url: String,
              type: Symbol,
              upload_url: T.nilable(String)
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
