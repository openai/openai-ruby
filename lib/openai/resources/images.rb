# frozen_string_literal: true

module OpenAI
  module Resources
    class Images
      # Creates a variation of a given image. This endpoint only supports `dall-e-2`.
      #
      # @overload create_variation(image:, model: nil, n: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #
      # @param image [Pathname, StringIO]
      # @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      # @param n [Integer, nil]
      # @param response_format [Symbol, OpenAI::Models::ImageCreateVariationParams::ResponseFormat, nil]
      # @param size [Symbol, OpenAI::Models::ImageCreateVariationParams::Size, nil]
      # @param user [String]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ImagesResponse]
      #
      # @see OpenAI::Models::ImageCreateVariationParams
      def create_variation(params)
        parsed, options = OpenAI::Models::ImageCreateVariationParams.dump_request(params)
        @client.request(
          method: :post,
          path: "images/variations",
          headers: {"content-type" => "multipart/form-data"},
          body: parsed,
          model: OpenAI::Models::ImagesResponse,
          options: options
        )
      end

      # Creates an edited or extended image given one or more source images and a
      # prompt. This endpoint only supports `gpt-image-1` and `dall-e-2`.
      #
      # @overload edit(image:, prompt:, mask: nil, model: nil, n: nil, quality: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #
      # @param image [Pathname, StringIO, Array<Pathname, StringIO>]
      # @param prompt [String]
      # @param mask [Pathname, StringIO]
      # @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      # @param n [Integer, nil]
      # @param quality [Symbol, OpenAI::Models::ImageEditParams::Quality, nil]
      # @param response_format [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil]
      # @param size [Symbol, OpenAI::Models::ImageEditParams::Size, nil]
      # @param user [String]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ImagesResponse]
      #
      # @see OpenAI::Models::ImageEditParams
      def edit(params)
        parsed, options = OpenAI::Models::ImageEditParams.dump_request(params)
        @client.request(
          method: :post,
          path: "images/edits",
          headers: {"content-type" => "multipart/form-data"},
          body: parsed,
          model: OpenAI::Models::ImagesResponse,
          options: options
        )
      end

      # Creates an image given a prompt.
      # [Learn more](https://platform.openai.com/docs/guides/images).
      #
      # @overload generate(prompt:, background: nil, model: nil, moderation: nil, n: nil, output_compression: nil, output_format: nil, quality: nil, response_format: nil, size: nil, style: nil, user: nil, request_options: {})
      #
      # @param prompt [String]
      # @param background [Symbol, OpenAI::Models::ImageGenerateParams::Background, nil]
      # @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      # @param moderation [Symbol, OpenAI::Models::ImageGenerateParams::Moderation, nil]
      # @param n [Integer, nil]
      # @param output_compression [Integer, nil]
      # @param output_format [Symbol, OpenAI::Models::ImageGenerateParams::OutputFormat, nil]
      # @param quality [Symbol, OpenAI::Models::ImageGenerateParams::Quality, nil]
      # @param response_format [Symbol, OpenAI::Models::ImageGenerateParams::ResponseFormat, nil]
      # @param size [Symbol, OpenAI::Models::ImageGenerateParams::Size, nil]
      # @param style [Symbol, OpenAI::Models::ImageGenerateParams::Style, nil]
      # @param user [String]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ImagesResponse]
      #
      # @see OpenAI::Models::ImageGenerateParams
      def generate(params)
        parsed, options = OpenAI::Models::ImageGenerateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "images/generations",
          body: parsed,
          model: OpenAI::Models::ImagesResponse,
          options: options
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
      end
    end
  end
end
