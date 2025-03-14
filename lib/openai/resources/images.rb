# frozen_string_literal: true

module OpenAI
  module Resources
    class Images
      # Creates a variation of a given image.
      #
      # @param params [OpenAI::Models::ImageCreateVariationParams, Hash{Symbol=>Object}] .
      #
      #   @option params [IO, StringIO] :image The image to use as the basis for the variation(s). Must be a valid PNG file,
      #     less than 4MB, and square.
      #
      #   @option params [String, Symbol, OpenAI::Models::ImageModel, nil] :model The model to use for image generation. Only `dall-e-2` is supported at this
      #     time.
      #
      #   @option params [Integer, nil] :n The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
      #     `n=1` is supported.
      #
      #   @option params [Symbol, OpenAI::Models::ImageCreateVariationParams::ResponseFormat, nil] :response_format The format in which the generated images are returned. Must be one of `url` or
      #     `b64_json`. URLs are only valid for 60 minutes after the image has been
      #     generated.
      #
      #   @option params [Symbol, OpenAI::Models::ImageCreateVariationParams::Size, nil] :size The size of the generated images. Must be one of `256x256`, `512x512`, or
      #     `1024x1024`.
      #
      #   @option params [String] :user A unique identifier representing your end-user, which can help OpenAI to monitor
      #     and detect abuse.
      #     [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::ImagesResponse]
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

      # Creates an edited or extended image given an original image and a prompt.
      #
      # @param params [OpenAI::Models::ImageEditParams, Hash{Symbol=>Object}] .
      #
      #   @option params [IO, StringIO] :image The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask
      #     is not provided, image must have transparency, which will be used as the mask.
      #
      #   @option params [String] :prompt A text description of the desired image(s). The maximum length is 1000
      #     characters.
      #
      #   @option params [IO, StringIO] :mask An additional image whose fully transparent areas (e.g. where alpha is zero)
      #     indicate where `image` should be edited. Must be a valid PNG file, less than
      #     4MB, and have the same dimensions as `image`.
      #
      #   @option params [String, Symbol, OpenAI::Models::ImageModel, nil] :model The model to use for image generation. Only `dall-e-2` is supported at this
      #     time.
      #
      #   @option params [Integer, nil] :n The number of images to generate. Must be between 1 and 10.
      #
      #   @option params [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil] :response_format The format in which the generated images are returned. Must be one of `url` or
      #     `b64_json`. URLs are only valid for 60 minutes after the image has been
      #     generated.
      #
      #   @option params [Symbol, OpenAI::Models::ImageEditParams::Size, nil] :size The size of the generated images. Must be one of `256x256`, `512x512`, or
      #     `1024x1024`.
      #
      #   @option params [String] :user A unique identifier representing your end-user, which can help OpenAI to monitor
      #     and detect abuse.
      #     [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::ImagesResponse]
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
      #
      # @param params [OpenAI::Models::ImageGenerateParams, Hash{Symbol=>Object}] .
      #
      #   @option params [String] :prompt A text description of the desired image(s). The maximum length is 1000
      #     characters for `dall-e-2` and 4000 characters for `dall-e-3`.
      #
      #   @option params [String, Symbol, OpenAI::Models::ImageModel, nil] :model The model to use for image generation.
      #
      #   @option params [Integer, nil] :n The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
      #     `n=1` is supported.
      #
      #   @option params [Symbol, OpenAI::Models::ImageGenerateParams::Quality] :quality The quality of the image that will be generated. `hd` creates images with finer
      #     details and greater consistency across the image. This param is only supported
      #     for `dall-e-3`.
      #
      #   @option params [Symbol, OpenAI::Models::ImageGenerateParams::ResponseFormat, nil] :response_format The format in which the generated images are returned. Must be one of `url` or
      #     `b64_json`. URLs are only valid for 60 minutes after the image has been
      #     generated.
      #
      #   @option params [Symbol, OpenAI::Models::ImageGenerateParams::Size, nil] :size The size of the generated images. Must be one of `256x256`, `512x512`, or
      #     `1024x1024` for `dall-e-2`. Must be one of `1024x1024`, `1792x1024`, or
      #     `1024x1792` for `dall-e-3` models.
      #
      #   @option params [Symbol, OpenAI::Models::ImageGenerateParams::Style, nil] :style The style of the generated images. Must be one of `vivid` or `natural`. Vivid
      #     causes the model to lean towards generating hyper-real and dramatic images.
      #     Natural causes the model to produce more natural, less hyper-real looking
      #     images. This param is only supported for `dall-e-3`.
      #
      #   @option params [String] :user A unique identifier representing your end-user, which can help OpenAI to monitor
      #     and detect abuse.
      #     [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
      #
      # @return [OpenAI::Models::ImagesResponse]
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

      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
      end
    end
  end
end
