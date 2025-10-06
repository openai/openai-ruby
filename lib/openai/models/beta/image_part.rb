# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class ImagePart < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Unique identifier for the uploaded image.
        #
        #   @return [String]
        required :id, String

        # @!attribute mime_type
        #   MIME type of the uploaded image.
        #
        #   @return [String]
        required :mime_type, String

        # @!attribute name
        #   Original filename for the uploaded image. Defaults to null when unnamed.
        #
        #   @return [String, nil]
        required :name, String, nil?: true

        # @!attribute preview_url
        #   Preview URL that can be rendered inline for the image.
        #
        #   @return [String]
        required :preview_url, String

        # @!attribute type
        #   Type discriminator that is always `image`.
        #
        #   @return [Symbol, :image]
        required :type, const: :image

        # @!attribute upload_url
        #   Signed URL for downloading the uploaded image. Defaults to null when no download
        #   link is available.
        #
        #   @return [String, nil]
        required :upload_url, String, nil?: true

        # @!method initialize(id:, mime_type:, name:, preview_url:, upload_url:, type: :image)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::ImagePart} for more details.
        #
        #   Metadata for an image uploaded through ChatKit.
        #
        #   @param id [String] Unique identifier for the uploaded image.
        #
        #   @param mime_type [String] MIME type of the uploaded image.
        #
        #   @param name [String, nil] Original filename for the uploaded image. Defaults to null when unnamed.
        #
        #   @param preview_url [String] Preview URL that can be rendered inline for the image.
        #
        #   @param upload_url [String, nil] Signed URL for downloading the uploaded image. Defaults to null when no download
        #
        #   @param type [Symbol, :image] Type discriminator that is always `image`.
      end
    end
  end
end
