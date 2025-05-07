# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Uploads#create
    class UploadCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute bytes
      #   The number of bytes in the file you are uploading.
      #
      #   @return [Integer]
      required :bytes, Integer

      # @!attribute filename
      #   The name of the file to upload.
      #
      #   @return [String]
      required :filename, String

      # @!attribute mime_type
      #   The MIME type of the file.
      #
      #   This must fall within the supported MIME types for your file purpose. See the
      #   supported MIME types for assistants and vision.
      #
      #   @return [String]
      required :mime_type, String

      # @!attribute purpose
      #   The intended purpose of the uploaded file.
      #
      #   See the
      #   [documentation on File purposes](https://platform.openai.com/docs/api-reference/files/create#files-create-purpose).
      #
      #   @return [Symbol, OpenAI::FilePurpose]
      required :purpose, enum: -> { OpenAI::FilePurpose }

      # @!method initialize(bytes:, filename:, mime_type:, purpose:, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::UploadCreateParams} for more details.
      #
      #   @param bytes [Integer] The number of bytes in the file you are uploading.
      #
      #   @param filename [String] The name of the file to upload.
      #
      #   @param mime_type [String] The MIME type of the file.
      #
      #   @param purpose [Symbol, OpenAI::FilePurpose] The intended purpose of the uploaded file.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
