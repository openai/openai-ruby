# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    # Emitted when a partial image is available during image editing streaming.
    module ImageEditStreamEvent
      extend OpenAI::Internal::Type::Union

      discriminator :type

      # Emitted when a partial image is available during image editing streaming.
      variant :"image_edit.partial_image", -> { OpenAI::ImageEditPartialImageEvent }

      # Emitted when image editing has completed and the final image is available.
      variant :"image_edit.completed", -> { OpenAI::ImageEditCompletedEvent }

      # @!method self.variants
      #   @return [Array(OpenAI::Models::ImageEditPartialImageEvent, OpenAI::Models::ImageEditCompletedEvent)]
    end
  end
end
