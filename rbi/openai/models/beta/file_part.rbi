# typed: strong

module OpenAI
  module Models
    module Beta
      class FilePart < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::FilePart, OpenAI::Internal::AnyHash)
          end

        # Unique identifier for the uploaded file.
        sig { returns(String) }
        attr_accessor :id

        # MIME type reported for the uploaded file. Defaults to null when unknown.
        sig { returns(T.nilable(String)) }
        attr_accessor :mime_type

        # Original filename supplied by the uploader. Defaults to null when unnamed.
        sig { returns(T.nilable(String)) }
        attr_accessor :name

        # Type discriminator that is always `file`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Signed URL for downloading the uploaded file. Defaults to null when no download
        # link is available.
        sig { returns(T.nilable(String)) }
        attr_accessor :upload_url

        # Metadata for a non-image file uploaded through ChatKit.
        sig do
          params(
            id: String,
            mime_type: T.nilable(String),
            name: T.nilable(String),
            upload_url: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Unique identifier for the uploaded file.
          id:,
          # MIME type reported for the uploaded file. Defaults to null when unknown.
          mime_type:,
          # Original filename supplied by the uploader. Defaults to null when unnamed.
          name:,
          # Signed URL for downloading the uploaded file. Defaults to null when no download
          # link is available.
          upload_url:,
          # Type discriminator that is always `file`.
          type: :file
        )
        end

        sig do
          override.returns(
            {
              id: String,
              mime_type: T.nilable(String),
              name: T.nilable(String),
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
