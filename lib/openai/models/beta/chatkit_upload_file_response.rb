# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Represents either a file or image attachment.
      #
      # @see OpenAI::Resources::Beta::ChatKit#upload_file
      module ChatKitUploadFileResponse
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Metadata for a non-image file uploaded through ChatKit.
        variant :file, -> { OpenAI::Beta::FilePart }

        # Metadata for an image uploaded through ChatKit.
        variant :image, -> { OpenAI::Beta::ImagePart }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::FilePart, OpenAI::Models::Beta::ImagePart)]
      end
    end
  end
end
