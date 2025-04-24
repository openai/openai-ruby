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

      # @!attribute data
      #   The list of generated images.
      #
      #   @return [Array<OpenAI::Models::Image>, nil]
      optional :data, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Image] }

      # @!attribute usage
      #   For `gpt-image-1` only, the token usage information for the image generation.
      #
      #   @return [OpenAI::Models::ImagesResponse::Usage, nil]
      optional :usage, -> { OpenAI::Models::ImagesResponse::Usage }

      # @!method initialize(created:, data: nil, usage: nil)
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::ImagesResponse} for more details.
      #
      #   The response from the image generation endpoint.
      #
      #   @param created [Integer] The Unix timestamp (in seconds) of when the image was created.
      #
      #   @param data [Array<OpenAI::Models::Image>] The list of generated images.
      #
      #   @param usage [OpenAI::Models::ImagesResponse::Usage] For `gpt-image-1` only, the token usage information for the image generation.
      #   ...

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
        required :input_tokens_details, -> { OpenAI::Models::ImagesResponse::Usage::InputTokensDetails }

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
        #   For `gpt-image-1` only, the token usage information for the image generation.
        #
        #   @param input_tokens [Integer] The number of tokens (images and text) in the input prompt.
        #
        #   @param input_tokens_details [OpenAI::Models::ImagesResponse::Usage::InputTokensDetails] The input tokens detailed information for the image generation.
        #
        #   @param output_tokens [Integer] The number of image tokens in the output image.
        #
        #   @param total_tokens [Integer] The total number of tokens (images and text) used for the image generation.

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
      end
    end
  end
end
