# typed: strong

module OpenAI
  module Resources
    class Images
      # Creates a variation of a given image.
      sig do
        params(
          image: T.any(IO, StringIO),
          model: T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol)),
          n: T.nilable(Integer),
          response_format: T.nilable(OpenAI::Models::ImageCreateVariationParams::ResponseFormat::OrSymbol),
          size: T.nilable(OpenAI::Models::ImageCreateVariationParams::Size::OrSymbol),
          user: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
        )
          .returns(OpenAI::Models::ImagesResponse)
      end
      def create_variation(
        # The image to use as the basis for the variation(s). Must be a valid PNG file,
        # less than 4MB, and square.
        image:,
        # The model to use for image generation. Only `dall-e-2` is supported at this
        # time.
        model: nil,
        # The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
        # `n=1` is supported.
        n: nil,
        # The format in which the generated images are returned. Must be one of `url` or
        # `b64_json`. URLs are only valid for 60 minutes after the image has been
        # generated.
        response_format: nil,
        # The size of the generated images. Must be one of `256x256`, `512x512`, or
        # `1024x1024`.
        size: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        # and detect abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        request_options: {}
      ); end
      # Creates an edited or extended image given an original image and a prompt.
      sig do
        params(
          image: T.any(IO, StringIO),
          prompt: String,
          mask: T.any(IO, StringIO),
          model: T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol)),
          n: T.nilable(Integer),
          response_format: T.nilable(OpenAI::Models::ImageEditParams::ResponseFormat::OrSymbol),
          size: T.nilable(OpenAI::Models::ImageEditParams::Size::OrSymbol),
          user: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
        )
          .returns(OpenAI::Models::ImagesResponse)
      end
      def edit(
        # The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask
        # is not provided, image must have transparency, which will be used as the mask.
        image:,
        # A text description of the desired image(s). The maximum length is 1000
        # characters.
        prompt:,
        # An additional image whose fully transparent areas (e.g. where alpha is zero)
        # indicate where `image` should be edited. Must be a valid PNG file, less than
        # 4MB, and have the same dimensions as `image`.
        mask: nil,
        # The model to use for image generation. Only `dall-e-2` is supported at this
        # time.
        model: nil,
        # The number of images to generate. Must be between 1 and 10.
        n: nil,
        # The format in which the generated images are returned. Must be one of `url` or
        # `b64_json`. URLs are only valid for 60 minutes after the image has been
        # generated.
        response_format: nil,
        # The size of the generated images. Must be one of `256x256`, `512x512`, or
        # `1024x1024`.
        size: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        # and detect abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        request_options: {}
      ); end
      # Creates an image given a prompt.
      sig do
        params(
          prompt: String,
          model: T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol)),
          n: T.nilable(Integer),
          quality: OpenAI::Models::ImageGenerateParams::Quality::OrSymbol,
          response_format: T.nilable(OpenAI::Models::ImageGenerateParams::ResponseFormat::OrSymbol),
          size: T.nilable(OpenAI::Models::ImageGenerateParams::Size::OrSymbol),
          style: T.nilable(OpenAI::Models::ImageGenerateParams::Style::OrSymbol),
          user: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
        )
          .returns(OpenAI::Models::ImagesResponse)
      end
      def generate(
        # A text description of the desired image(s). The maximum length is 1000
        # characters for `dall-e-2` and 4000 characters for `dall-e-3`.
        prompt:,
        # The model to use for image generation.
        model: nil,
        # The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
        # `n=1` is supported.
        n: nil,
        # The quality of the image that will be generated. `hd` creates images with finer
        # details and greater consistency across the image. This param is only supported
        # for `dall-e-3`.
        quality: nil,
        # The format in which the generated images are returned. Must be one of `url` or
        # `b64_json`. URLs are only valid for 60 minutes after the image has been
        # generated.
        response_format: nil,
        # The size of the generated images. Must be one of `256x256`, `512x512`, or
        # `1024x1024` for `dall-e-2`. Must be one of `1024x1024`, `1792x1024`, or
        # `1024x1792` for `dall-e-3` models.
        size: nil,
        # The style of the generated images. Must be one of `vivid` or `natural`. Vivid
        # causes the model to lean towards generating hyper-real and dramatic images.
        # Natural causes the model to produce more natural, less hyper-real looking
        # images. This param is only supported for `dall-e-3`.
        style: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        # and detect abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        request_options: {}
      ); end
      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:); end
    end
  end
end
