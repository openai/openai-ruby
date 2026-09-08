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
      #   The image dimensions as a `WIDTHxHEIGHT` string, for example `1536x864`.
      #
      #   @return [String, Symbol, OpenAI::Models::ImageGenPartialImageEvent::Size]
      required :size, union: -> { OpenAI::ImageGenPartialImageEvent::Size }

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
      #   @param size [String, Symbol, OpenAI::Models::ImageGenPartialImageEvent::Size] The image dimensions as a `WIDTHxHEIGHT` string, for example `1536x864`.
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
        XHIGH = :xhigh
        MAX = :max
        AUTO = :auto

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The image dimensions as a `WIDTHxHEIGHT` string, for example `1536x864`.
      #
      # @see OpenAI::Models::ImageGenPartialImageEvent#size
      module Size
        extend OpenAI::Internal::Type::Union

        variant String

        variant const: -> { OpenAI::Models::ImageGenPartialImageEvent::Size::SIZE_1024X1024 }

        variant const: -> { OpenAI::Models::ImageGenPartialImageEvent::Size::SIZE_1024X1536 }

        variant const: -> { OpenAI::Models::ImageGenPartialImageEvent::Size::SIZE_1536X1024 }

        variant const: -> { OpenAI::Models::ImageGenPartialImageEvent::Size::AUTO }

        # @!method self.variants
        #   @return [Array(String, Symbol)]

        define_sorbet_constant!(:Variants) do
          T.type_alias { T.any(String, OpenAI::ImageGenPartialImageEvent::Size::TaggedSymbol) }
        end

        # @!group

        SIZE_1024X1024 = :"1024x1024"
        SIZE_1024X1536 = :"1024x1536"
        SIZE_1536X1024 = :"1536x1024"
        AUTO = :auto

        # @!endgroup
      end
    end
  end
end
