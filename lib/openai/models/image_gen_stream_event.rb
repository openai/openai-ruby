# frozen_string_literal: true

module OpenAI
  module Models
    # Emitted when a partial image is available during image generation streaming.
    module ImageGenStreamEvent
      extend OpenAI::Internal::Type::Union

      discriminator :type

      # Emitted when a partial image is available during image generation streaming.
      variant :"image_generation.partial_image", -> { OpenAI::ImageGenPartialImageEvent }

      # Emitted when image generation has completed and the final image is available.
      variant :"image_generation.completed", -> { OpenAI::ImageGenCompletedEvent }

      # @!method self.variants
      #   @return [Array(OpenAI::Models::ImageGenPartialImageEvent, OpenAI::Models::ImageGenCompletedEvent)]
    end
  end
end
