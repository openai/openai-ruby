# frozen_string_literal: true

module OpenAI
  module Models
    class ImageInputReferenceParam < OpenAI::Internal::Type::BaseModel
      # @!attribute file_id
      #
      #   @return [String, nil]
      optional :file_id, String

      # @!attribute image_url
      #   A fully qualified URL or base64-encoded data URL.
      #
      #   @return [String, nil]
      optional :image_url, String

      # @!method initialize(file_id: nil, image_url: nil)
      #   @param file_id [String]
      #
      #   @param image_url [String] A fully qualified URL or base64-encoded data URL.
    end
  end
end
