# frozen_string_literal: true

module OpenAI
  module Models
    class ImageGenPartialImageEvent < OpenAI::Internal::Type::BaseModel
      # @!attribute b64_json
      #   Base64-encoded partial image data, suitable for rendering as an image.
      #
      #   @return [String]
      required :b64_json, String

      # @!attribute background
      #   The background setting for the requested image.
      #
      #   @return [Symbol, OpenAI::Models::ImageGenPartialImageEvent::Background]
      required :background, enum: -> { OpenAI::ImageGenPartialImageEvent::Background }

      # @!attribute created_at
      #   The Unix timestamp when the event was created.
      #
      #   @return [Integer]
      required :created_at, Integer

      # @!attribute output_format
      #   The output format for the requested image.
      #
      #   @return [Symbol, OpenAI::Models::ImageGenPartialImageEvent::OutputFormat]
      required :output_format, enum: -> { OpenAI::ImageGenPartialImageEvent::OutputFormat }

      # @!attribute partial_image_index
      #   0-based index for the partial image (streaming).
      #
      #   @return [Integer]
      required :partial_image_index, Integer

      # @!attribute quality
      #   The quality setting for the requested image.
      #
      #   @return [Symbol, OpenAI::Models::ImageGenPartialImageEvent::Quality]
      required :quality, enum: -> { OpenAI::ImageGenPartialImageEvent::Quality }

      # @!attribute size
      #   The size of the requested image.
      #
      #   @return [Symbol, OpenAI::Models::ImageGenPartialImageEvent::Size]
      required :size, enum: -> { OpenAI::ImageGenPartialImageEvent::Size }

      # @!attribute type
      #   The type of the event. Always `image_generation.partial_image`.
      #
      #   @return [Symbol, :"image_generation.partial_image"]
      required :type, const: :"image_generation.partial_image"

      # @!method initialize(b64_json:, background:, created_at:, output_format:, partial_image_index:, quality:, size:, type: :"image_generation.partial_image")
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::ImageGenPartialImageEvent} for more details.
      #
      #   Emitted when a partial image is available during image generation streaming.
      #
      #   @param b64_json [String] Base64-encoded partial image data, suitable for rendering as an image.
      #
      #   @param background [Symbol, OpenAI::Models::ImageGenPartialImageEvent::Background] The background setting for the requested image.
      #
      #   @param created_at [Integer] The Unix timestamp when the event was created.
      #
      #   @param output_format [Symbol, OpenAI::Models::ImageGenPartialImageEvent::OutputFormat] The output format for the requested image.
      #
      #   @param partial_image_index [Integer] 0-based index for the partial image (streaming).
      #
      #   @param quality [Symbol, OpenAI::Models::ImageGenPartialImageEvent::Quality] The quality setting for the requested image.
      #
      #   @param size [Symbol, OpenAI::Models::ImageGenPartialImageEvent::Size] The size of the requested image.
      #
      #   @param type [Symbol, :"image_generation.partial_image"] The type of the event. Always `image_generation.partial_image`.

      # The background setting for the requested image.
      #
      # @see OpenAI::Models::ImageGenPartialImageEvent#background
      module Background
        extend OpenAI::Internal::Type::Enum

        TRANSPARENT = :transparent
        OPAQUE = :opaque
        AUTO = :auto

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The output format for the requested image.
      #
      # @see OpenAI::Models::ImageGenPartialImageEvent#output_format
      module OutputFormat
        extend OpenAI::Internal::Type::Enum

        PNG = :png
        WEBP = :webp
        JPEG = :jpeg

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The quality setting for the requested image.
      #
      # @see OpenAI::Models::ImageGenPartialImageEvent#quality
      module Quality
        extend OpenAI::Internal::Type::Enum

        LOW = :low
        MEDIUM = :medium
        HIGH = :high
        AUTO = :auto

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The size of the requested image.
      #
      # @see OpenAI::Models::ImageGenPartialImageEvent#size
      module Size
        extend OpenAI::Internal::Type::Enum

        SIZE_1024X1024 = :"1024x1024"
        SIZE_1024X1536 = :"1024x1536"
        SIZE_1536X1024 = :"1536x1024"
        AUTO = :auto

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
