# typed: strong

module OpenAI
  module Models
    class UploadCreateParams < OpenAI::BaseModel
      extend OpenAI::Type::RequestParameters::Converter
      include OpenAI::RequestParameters

      # The number of bytes in the file you are uploading.
      sig { returns(Integer) }
      attr_accessor :bytes

      # The name of the file to upload.
      sig { returns(String) }
      attr_accessor :filename

      # The MIME type of the file.
      #
      #   This must fall within the supported MIME types for your file purpose. See the
      #   supported MIME types for assistants and vision.
      sig { returns(String) }
      attr_accessor :mime_type

      # The intended purpose of the uploaded file.
      #
      #   See the
      #   [documentation on File purposes](https://platform.openai.com/docs/api-reference/files/create#files-create-purpose).
      sig { returns(OpenAI::Models::FilePurpose::OrSymbol) }
      attr_accessor :purpose

      sig do
        params(
          bytes: Integer,
          filename: String,
          mime_type: String,
          purpose: OpenAI::Models::FilePurpose::OrSymbol,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(bytes:, filename:, mime_type:, purpose:, request_options: {})
      end

      sig do
        override
          .returns(
            {
              bytes: Integer,
              filename: String,
              mime_type: String,
              purpose: OpenAI::Models::FilePurpose::OrSymbol,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end
    end
  end
end
