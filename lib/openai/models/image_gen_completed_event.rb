# frozen_string_literal: true

module OpenAI
  module Models
    class ImageGenCompletedEvent < OpenAI::Internal::Type::BaseModel
      # @!attribute b64_json
      #   Base64-encoded image data, suitable for rendering as an image.
      #
      #   @return [String]
      required :b64_json, String

      # @!attribute background
      #   The background setting for the generated image.
      #
      #   @return [Symbol, OpenAI::Models::ImageGenCompletedEvent::Background]
      required :background, enum: -> { OpenAI::ImageGenCompletedEvent::Background }

      # @!attribute created_at
      #   The Unix timestamp when the event was created.
      #
      #   @return [Integer]
      required :created_at, Integer

      # @!attribute output_format
      #   The output format for the generated image.
      #
      #   @return [Symbol, OpenAI::Models::ImageGenCompletedEvent::OutputFormat]
      required :output_format, enum: -> { OpenAI::ImageGenCompletedEvent::OutputFormat }

      # @!attribute quality
      #   The quality setting for the generated image.
      #
      #   @return [Symbol, OpenAI::Models::ImageGenCompletedEvent::Quality]
      required :quality, enum: -> { OpenAI::ImageGenCompletedEvent::Quality }

      # @!attribute size
      #   The size of the generated image.
      #
      #   @return [Symbol, OpenAI::Models::ImageGenCompletedEvent::Size]
      required :size, enum: -> { OpenAI::ImageGenCompletedEvent::Size }

      # @!attribute type
      #   The type of the event. Always `image_generation.completed`.
      #
      #   @return [Symbol, :"image_generation.completed"]
      required :type, const: :"image_generation.completed"

      # @!attribute usage
      #   For the GPT image models only, the token usage information for the image
      #   generation.
      #
      #   @return [OpenAI::Models::ImageGenCompletedEvent::Usage]
      required :usage, -> { OpenAI::ImageGenCompletedEvent::Usage }

      # @!method initialize(b64_json:, background:, created_at:, output_format:, quality:, size:, usage:, type: :"image_generation.completed")
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::ImageGenCompletedEvent} for more details.
      #
      #   Emitted when image generation has completed and the final image is available.
      #
      #   @param b64_json [String] Base64-encoded image data, suitable for rendering as an image.
      #
      #   @param background [Symbol, OpenAI::Models::ImageGenCompletedEvent::Background] The background setting for the generated image.
      #
      #   @param created_at [Integer] The Unix timestamp when the event was created.
      #
      #   @param output_format [Symbol, OpenAI::Models::ImageGenCompletedEvent::OutputFormat] The output format for the generated image.
      #
      #   @param quality [Symbol, OpenAI::Models::ImageGenCompletedEvent::Quality] The quality setting for the generated image.
      #
      #   @param size [Symbol, OpenAI::Models::ImageGenCompletedEvent::Size] The size of the generated image.
      #
      #   @param usage [OpenAI::Models::ImageGenCompletedEvent::Usage] For the GPT image models only, the token usage information for the image generat
      #
      #   @param type [Symbol, :"image_generation.completed"] The type of the event. Always `image_generation.completed`.

      # The background setting for the generated image.
      #
      # @see OpenAI::Models::ImageGenCompletedEvent#background
      module Background
        extend OpenAI::Internal::Type::Enum

        TRANSPARENT = :transparent
        OPAQUE = :opaque
        AUTO = :auto

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The output format for the generated image.
      #
      # @see OpenAI::Models::ImageGenCompletedEvent#output_format
      module OutputFormat
        extend OpenAI::Internal::Type::Enum

        PNG = :png
        WEBP = :webp
        JPEG = :jpeg

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The quality setting for the generated image.
      #
      # @see OpenAI::Models::ImageGenCompletedEvent#quality
      module Quality
        extend OpenAI::Internal::Type::Enum

        LOW = :low
        MEDIUM = :medium
        HIGH = :high
        AUTO = :auto

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The size of the generated image.
      #
      # @see OpenAI::Models::ImageGenCompletedEvent#size
      module Size
        extend OpenAI::Internal::Type::Enum

        SIZE_1024X1024 = :"1024x1024"
        SIZE_1024X1536 = :"1024x1536"
        SIZE_1536X1024 = :"1536x1024"
        AUTO = :auto

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # @see OpenAI::Models::ImageGenCompletedEvent#usage
      class Usage < OpenAI::Internal::Type::BaseModel
        # @!attribute input_tokens
        #   The number of tokens (images and text) in the input prompt.
        #
        #   @return [Integer]
        required :input_tokens, Integer

        # @!attribute input_tokens_details
        #   The input tokens detailed information for the image generation.
        #
        #   @return [OpenAI::Models::ImageGenCompletedEvent::Usage::InputTokensDetails]
        required :input_tokens_details, -> { OpenAI::ImageGenCompletedEvent::Usage::InputTokensDetails }

        # @!attribute output_tokens
        #   The number of image tokens in the output image.
        #
        #   @return [Integer]
        required :output_tokens, Integer

        # @!attribute total_tokens
        #   The total number of tokens (images and text) used for the image generation.
        #
        #   @return [Integer]
        required :total_tokens, Integer

        # @!method initialize(input_tokens:, input_tokens_details:, output_tokens:, total_tokens:)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::ImageGenCompletedEvent::Usage} for more details.
        #
        #   For the GPT image models only, the token usage information for the image
        #   generation.
        #
        #   @param input_tokens [Integer] The number of tokens (images and text) in the input prompt.
        #
        #   @param input_tokens_details [OpenAI::Models::ImageGenCompletedEvent::Usage::InputTokensDetails] The input tokens detailed information for the image generation.
        #
        #   @param output_tokens [Integer] The number of image tokens in the output image.
        #
        #   @param total_tokens [Integer] The total number of tokens (images and text) used for the image generation.

        # @see OpenAI::Models::ImageGenCompletedEvent::Usage#input_tokens_details
        class InputTokensDetails < OpenAI::Internal::Type::BaseModel
          # @!attribute image_tokens
          #   The number of image tokens in the input prompt.
          #
          #   @return [Integer]
          required :image_tokens, Integer

          # @!attribute text_tokens
          #   The number of text tokens in the input prompt.
          #
          #   @return [Integer]
          required :text_tokens, Integer

          # @!method initialize(image_tokens:, text_tokens:)
          #   The input tokens detailed information for the image generation.
          #
          #   @param image_tokens [Integer] The number of image tokens in the input prompt.
          #
          #   @param text_tokens [Integer] The number of text tokens in the input prompt.
        end
      end
    end
  end
end
