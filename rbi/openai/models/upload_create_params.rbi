# typed: strong

module OpenAI
  module Models
    class UploadCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::UploadCreateParams, OpenAI::Internal::AnyHash)
        end

      # The number of bytes in the file you are uploading.
      sig { returns(Integer) }
      attr_accessor :bytes

      # The name of the file to upload.
      sig { returns(String) }
      attr_accessor :filename

      # The MIME type of the file.
      #
      # This must fall within the supported MIME types for your file purpose. See the
      # supported MIME types for assistants and vision.
      sig { returns(String) }
      attr_accessor :mime_type

      # The intended purpose of the uploaded file.
      #
      # See the
      # [documentation on File purposes](https://platform.openai.com/docs/api-reference/files/create#files-create-purpose).
      sig { returns(OpenAI::FilePurpose::OrSymbol) }
      attr_accessor :purpose

      # The expiration policy for a file. By default, files with `purpose=batch` expire
      # after 30 days and all other files are persisted until they are manually deleted.
      sig { returns(T.nilable(OpenAI::UploadCreateParams::ExpiresAfter)) }
      attr_reader :expires_after

      sig do
        params(
          expires_after: OpenAI::UploadCreateParams::ExpiresAfter::OrHash
        ).void
      end
      attr_writer :expires_after

      sig do
        params(
          bytes: Integer,
          filename: String,
          mime_type: String,
          purpose: OpenAI::FilePurpose::OrSymbol,
          expires_after: OpenAI::UploadCreateParams::ExpiresAfter::OrHash,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # The number of bytes in the file you are uploading.
        bytes:,
        # The name of the file to upload.
        filename:,
        # The MIME type of the file.
        #
        # This must fall within the supported MIME types for your file purpose. See the
        # supported MIME types for assistants and vision.
        mime_type:,
        # The intended purpose of the uploaded file.
        #
        # See the
        # [documentation on File purposes](https://platform.openai.com/docs/api-reference/files/create#files-create-purpose).
        purpose:,
        # The expiration policy for a file. By default, files with `purpose=batch` expire
        # after 30 days and all other files are persisted until they are manually deleted.
        expires_after: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            bytes: Integer,
            filename: String,
            mime_type: String,
            purpose: OpenAI::FilePurpose::OrSymbol,
            expires_after: OpenAI::UploadCreateParams::ExpiresAfter,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      class ExpiresAfter < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::UploadCreateParams::ExpiresAfter,
              OpenAI::Internal::AnyHash
            )
          end

        # Anchor timestamp after which the expiration policy applies. Supported anchors:
        # `created_at`.
        sig { returns(Symbol) }
        attr_accessor :anchor

        # The number of seconds after the anchor time that the file will expire. Must be
        # between 3600 (1 hour) and 2592000 (30 days).
        sig { returns(Integer) }
        attr_accessor :seconds

        # The expiration policy for a file. By default, files with `purpose=batch` expire
        # after 30 days and all other files are persisted until they are manually deleted.
        sig do
          params(seconds: Integer, anchor: Symbol).returns(T.attached_class)
        end
        def self.new(
          # The number of seconds after the anchor time that the file will expire. Must be
          # between 3600 (1 hour) and 2592000 (30 days).
          seconds:,
          # Anchor timestamp after which the expiration policy applies. Supported anchors:
          # `created_at`.
          anchor: :created_at
        )
        end

        sig { override.returns({ anchor: Symbol, seconds: Integer }) }
        def to_hash
        end
      end
    end
  end
end
