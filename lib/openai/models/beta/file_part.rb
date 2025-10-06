# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class FilePart < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Unique identifier for the uploaded file.
        #
        #   @return [String]
        required :id, String

        # @!attribute mime_type
        #   MIME type reported for the uploaded file. Defaults to null when unknown.
        #
        #   @return [String, nil]
        required :mime_type, String, nil?: true

        # @!attribute name
        #   Original filename supplied by the uploader. Defaults to null when unnamed.
        #
        #   @return [String, nil]
        required :name, String, nil?: true

        # @!attribute type
        #   Type discriminator that is always `file`.
        #
        #   @return [Symbol, :file]
        required :type, const: :file

        # @!attribute upload_url
        #   Signed URL for downloading the uploaded file. Defaults to null when no download
        #   link is available.
        #
        #   @return [String, nil]
        required :upload_url, String, nil?: true

        # @!method initialize(id:, mime_type:, name:, upload_url:, type: :file)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::FilePart} for more details.
        #
        #   Metadata for a non-image file uploaded through ChatKit.
        #
        #   @param id [String] Unique identifier for the uploaded file.
        #
        #   @param mime_type [String, nil] MIME type reported for the uploaded file. Defaults to null when unknown.
        #
        #   @param name [String, nil] Original filename supplied by the uploader. Defaults to null when unnamed.
        #
        #   @param upload_url [String, nil] Signed URL for downloading the uploaded file. Defaults to null when no download
        #
        #   @param type [Symbol, :file] Type discriminator that is always `file`.
      end
    end
  end
end
