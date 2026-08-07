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
      #   @return [Symbol, OpenAI::Models::FilePurpose]
      required :purpose, enum: -> { OpenAI::FilePurpose }

      # @!attribute expires_after
      #   The expiration policy for a file. By default, files with `purpose=batch` expire
      #   after 30 days and all other files are persisted until they are manually deleted.
      #
      #   @return [OpenAI::Models::UploadCreateParams::ExpiresAfter, nil]
      optional :expires_after, -> { OpenAI::UploadCreateParams::ExpiresAfter }

      # @!method initialize(bytes:, filename:, mime_type:, purpose:, expires_after: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::UploadCreateParams} for more details.
      #
      #   @param bytes [Integer] The number of bytes in the file you are uploading.
      #
      #   @param filename [String] The name of the file to upload.
      #
      #   @param mime_type [String] The MIME type of the file.
      #
      #   @param purpose [Symbol, OpenAI::Models::FilePurpose] The intended purpose of the uploaded file.
      #
      #   @param expires_after [OpenAI::Models::UploadCreateParams::ExpiresAfter] The expiration policy for a file. By default, files with `purpose=batch` expire
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      class ExpiresAfter < OpenAI::Internal::Type::BaseModel
        # @!attribute anchor
        #   Anchor timestamp after which the expiration policy applies. Supported anchors:
        #   `created_at`.
        #
        #   @return [Symbol, :created_at]
        required :anchor, const: :created_at

        # @!attribute seconds
        #   The number of seconds after the anchor time that the file will expire. Must be
        #   between 3600 (1 hour) and 2592000 (30 days).
        #
        #   @return [Integer]
        required :seconds, Integer

        # @!method initialize(seconds:, anchor: :created_at)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::UploadCreateParams::ExpiresAfter} for more details.
        #
        #   The expiration policy for a file. By default, files with `purpose=batch` expire
        #   after 30 days and all other files are persisted until they are manually deleted.
        #
        #   @param seconds [Integer] The number of seconds after the anchor time that the file will expire. Must be b
        #
        #   @param anchor [Symbol, :created_at] Anchor timestamp after which the expiration policy applies. Supported anchors: `
      end
    end
  end
end
