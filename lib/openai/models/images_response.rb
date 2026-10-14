# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Images#create_variation
    class ImagesResponse < OpenAI::Internal::Type::BaseModel
      # @!attribute created
      #   The Unix timestamp (in seconds) of when the image was created.
      #
      #   @return [Integer]
      required :created, Integer

      # @!attribute background
      #   The background parameter used for the image generation. Either `transparent` or
      #   `opaque`.
      #
      #   @return [Symbol, OpenAI::Models::ImagesResponse::Background, nil]
      optional :background, enum: -> { OpenAI::ImagesResponse::Background }

      # @!attribute data
      #   The list of generated images.
      #
      #   @return [Array<OpenAI::Models::Image>, nil]
      optional :data, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Image] }

      # @!attribute output_format
      #   The output format of the image generation. Either `png`, `webp`, or `jpeg`.
      #
      #   @return [Symbol, OpenAI::Models::ImagesResponse::OutputFormat, nil]
      optional :output_format, enum: -> { OpenAI::ImagesResponse::OutputFormat }

      # @!attribute quality
      #   The quality of the image generated. Either `low`, `medium`, or `high`.
      #
      #   @return [Symbol, OpenAI::Models::ImagesResponse::Quality, nil]
      optional :quality, enum: -> { OpenAI::ImagesResponse::Quality }

      # @!attribute size
      #   The size of the image generated. Either `1024x1024`, `1024x1536`, or
      #   `1536x1024`.
      #
      #   @return [Symbol, OpenAI::Models::ImagesResponse::Size, nil]
      optional :size, enum: -> { OpenAI::ImagesResponse::Size }

      # @!attribute usage
      #   For `gpt-image-1` only, the token usage information for the image generation.
      #
      #   @return [OpenAI::Models::ImagesResponse::Usage, nil]
      optional :usage, -> { OpenAI::ImagesResponse::Usage }

      # @!method initialize(created:, background: nil, data: nil, output_format: nil, quality: nil, size: nil, usage: nil)
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::ImagesResponse} for more details.
      #
      #   The response from the image generation endpoint.
      #
      #   @param created [Integer] The Unix timestamp (in seconds) of when the image was created.
      #
      #   @param background [Symbol, OpenAI::Models::ImagesResponse::Background] The background parameter used for the image generation. Either `transparent` or
      #
      #   @param data [Array<OpenAI::Models::Image>] The list of generated images.
      #
      #   @param output_format [Symbol, OpenAI::Models::ImagesResponse::OutputFormat] The output format of the image generation. Either `png`, `webp`, or `jpeg`.
      #
      #   @param quality [Symbol, OpenAI::Models::ImagesResponse::Quality] The quality of the image generated. Either `low`, `medium`, or `high`.
      #
      #   @param size [Symbol, OpenAI::Models::ImagesResponse::Size] The size of the image generated. Either `1024x1024`, `1024x1536`, or `1536x1024`
      #
      #   @param usage [OpenAI::Models::ImagesResponse::Usage] For `gpt-image-1` only, the token usage information for the image generation.

      # The background parameter used for the image generation. Either `transparent` or
      # `opaque`.
      #
      # @see OpenAI::Models::ImagesResponse#background
      module Background
        extend OpenAI::Internal::Type::Enum

        TRANSPARENT = :transparent
        OPAQUE = :opaque

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The output format of the image generation. Either `png`, `webp`, or `jpeg`.
      #
      # @see OpenAI::Models::ImagesResponse#output_format
      module OutputFormat
        extend OpenAI::Internal::Type::Enum

        PNG = :png
        WEBP = :webp
        JPEG = :jpeg

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The quality of the image generated. Either `low`, `medium`, or `high`.
      #
      # @see OpenAI::Models::ImagesResponse#quality
      module Quality
        extend OpenAI::Internal::Type::Enum

        LOW = :low
        MEDIUM = :medium
        HIGH = :high

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The size of the image generated. Either `1024x1024`, `1024x1536`, or
      # `1536x1024`.
      #
      # @see OpenAI::Models::ImagesResponse#size
      module Size
        extend OpenAI::Internal::Type::Enum

        SIZE_1024X1024 = :"1024x1024"
        SIZE_1024X1536 = :"1024x1536"
        SIZE_1536X1024 = :"1536x1024"

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # @see OpenAI::Models::ImagesResponse#usage
      class Usage < OpenAI::Internal::Type::BaseModel
        # @!attribute input_tokens
        #   The number of tokens (images and text) in the input prompt.
        #
        #   @return [Integer]
        required :input_tokens, Integer

        # @!attribute input_tokens_details
        #   The input tokens detailed information for the image generation.
        #
        #   @return [OpenAI::Models::ImagesResponse::Usage::InputTokensDetails]
        required :input_tokens_details, -> { OpenAI::ImagesResponse::Usage::InputTokensDetails }

        # @!attribute output_tokens
        #   The number of output tokens generated by the model.
        #
        #   @return [Integer]
        required :output_tokens, Integer

        # @!attribute total_tokens
        #   The total number of tokens (images and text) used for the image generation.
        #
        #   @return [Integer]
        required :total_tokens, Integer

        # @!attribute output_tokens_details
        #   The output token details for the image generation.
        #
        #   @return [OpenAI::Models::ImagesResponse::Usage::OutputTokensDetails, nil]
        optional :output_tokens_details, -> { OpenAI::ImagesResponse::Usage::OutputTokensDetails }

        # @!method initialize(input_tokens:, input_tokens_details:, output_tokens:, total_tokens:, output_tokens_details: nil)
        #   For `gpt-image-1` only, the token usage information for the image generation.
        #
        #   @param input_tokens [Integer] The number of tokens (images and text) in the input prompt.
        #
        #   @param input_tokens_details [OpenAI::Models::ImagesResponse::Usage::InputTokensDetails] The input tokens detailed information for the image generation.
        #
        #   @param output_tokens [Integer] The number of output tokens generated by the model.
        #
        #   @param total_tokens [Integer] The total number of tokens (images and text) used for the image generation.
        #
        #   @param output_tokens_details [OpenAI::Models::ImagesResponse::Usage::OutputTokensDetails] The output token details for the image generation.

        # @see OpenAI::Models::ImagesResponse::Usage#input_tokens_details
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

        # @see OpenAI::Models::ImagesResponse::Usage#output_tokens_details
        class OutputTokensDetails < OpenAI::Internal::Type::BaseModel
          # @!attribute image_tokens
          #   The number of image output tokens generated by the model.
          #
          #   @return [Integer]
          required :image_tokens, Integer

          # @!attribute text_tokens
          #   The number of text output tokens generated by the model.
          #
          #   @return [Integer]
          required :text_tokens, Integer

          # @!method initialize(image_tokens:, text_tokens:)
          #   The output token details for the image generation.
          #
          #   @param image_tokens [Integer] The number of image output tokens generated by the model.
          #
          #   @param text_tokens [Integer] The number of text output tokens generated by the model.
        end
      end
    end
  end
end
