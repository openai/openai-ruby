# frozen_string_literal: true

module OpenAI
  module Models
    class ImageEditPartialImageEvent < OpenAI::Internal::Type::BaseModel
      # @!attribute b64_json
      #   Base64-encoded partial image data, suitable for rendering as an image.
      #
      #   @return [String]
      required :b64_json, String

      # @!attribute background
      #   The background setting for the requested edited image.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditPartialImageEvent::Background]
      required :background, enum: -> { OpenAI::ImageEditPartialImageEvent::Background }

      # @!attribute created_at
      #   The Unix timestamp when the event was created.
      #
      #   @return [Integer]
      required :created_at, Integer

      # @!attribute output_format
      #   The output format for the requested edited image.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditPartialImageEvent::OutputFormat]
      required :output_format, enum: -> { OpenAI::ImageEditPartialImageEvent::OutputFormat }

      # @!attribute partial_image_index
      #   0-based index for the partial image (streaming).
      #
      #   @return [Integer]
      required :partial_image_index, Integer

      # @!attribute quality
      #   The quality setting for the requested edited image.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditPartialImageEvent::Quality]
      required :quality, enum: -> { OpenAI::ImageEditPartialImageEvent::Quality }

      # @!attribute size
      #   The size of the requested edited image.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditPartialImageEvent::Size]
      required :size, enum: -> { OpenAI::ImageEditPartialImageEvent::Size }

      # @!attribute type
      #   The type of the event. Always `image_edit.partial_image`.
      #
      #   @return [Symbol, :"image_edit.partial_image"]
      required :type, const: :"image_edit.partial_image"

      # @!method initialize(b64_json:, background:, created_at:, output_format:, partial_image_index:, quality:, size:, type: :"image_edit.partial_image")
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::ImageEditPartialImageEvent} for more details.
      #
      #   Emitted when a partial image is available during image editing streaming.
      #
      #   @param b64_json [String] Base64-encoded partial image data, suitable for rendering as an image.
      #
      #   @param background [Symbol, OpenAI::Models::ImageEditPartialImageEvent::Background] The background setting for the requested edited image.
      #
      #   @param created_at [Integer] The Unix timestamp when the event was created.
      #
      #   @param output_format [Symbol, OpenAI::Models::ImageEditPartialImageEvent::OutputFormat] The output format for the requested edited image.
      #
      #   @param partial_image_index [Integer] 0-based index for the partial image (streaming).
      #
      #   @param quality [Symbol, OpenAI::Models::ImageEditPartialImageEvent::Quality] The quality setting for the requested edited image.
      #
      #   @param size [Symbol, OpenAI::Models::ImageEditPartialImageEvent::Size] The size of the requested edited image.
      #
      #   @param type [Symbol, :"image_edit.partial_image"] The type of the event. Always `image_edit.partial_image`.

      # The background setting for the requested edited image.
      #
      # @see OpenAI::Models::ImageEditPartialImageEvent#background
      module Background
        extend OpenAI::Internal::Type::Enum

        TRANSPARENT = :transparent
        OPAQUE = :opaque
        AUTO = :auto

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The output format for the requested edited image.
      #
      # @see OpenAI::Models::ImageEditPartialImageEvent#output_format
      module OutputFormat
        extend OpenAI::Internal::Type::Enum

        PNG = :png
        WEBP = :webp
        JPEG = :jpeg

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The quality setting for the requested edited image.
      #
      # @see OpenAI::Models::ImageEditPartialImageEvent#quality
      module Quality
        extend OpenAI::Internal::Type::Enum

        LOW = :low
        MEDIUM = :medium
        HIGH = :high
        AUTO = :auto

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The size of the requested edited image.
      #
      # @see OpenAI::Models::ImageEditPartialImageEvent#size
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
