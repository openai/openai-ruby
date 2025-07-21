# typed: strong

module OpenAI
  module Resources
    class Images
      # Creates a variation of a given image. This endpoint only supports `dall-e-2`.
      sig do
        params(
          image: OpenAI::Internal::FileInput,
          model: T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol)),
          n: T.nilable(Integer),
          response_format:
            T.nilable(
              OpenAI::ImageCreateVariationParams::ResponseFormat::OrSymbol
            ),
          size: T.nilable(OpenAI::ImageCreateVariationParams::Size::OrSymbol),
          user: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::ImagesResponse)
      end
      def create_variation(
        # The image to use as the basis for the variation(s). Must be a valid PNG file,
        # less than 4MB, and square.
        image:,
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
      )
      end

      # See {OpenAI::Resources::Images#edit_stream_raw} for streaming counterpart.
      #
      # Creates an edited or extended image given one or more source images and a
      # prompt. This endpoint only supports `gpt-image-1` and `dall-e-2`.
      sig do
        params(
          image: OpenAI::ImageEditParams::Image::Variants,
          prompt: String,
          background: T.nilable(OpenAI::ImageEditParams::Background::OrSymbol),
          input_fidelity:
            T.nilable(OpenAI::ImageEditParams::InputFidelity::OrSymbol),
          mask: OpenAI::Internal::FileInput,
          model: T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol)),
          n: T.nilable(Integer),
          output_compression: T.nilable(Integer),
          output_format:
            T.nilable(OpenAI::ImageEditParams::OutputFormat::OrSymbol),
          partial_images: T.nilable(Integer),
          quality: T.nilable(OpenAI::ImageEditParams::Quality::OrSymbol),
          response_format:
            T.nilable(OpenAI::ImageEditParams::ResponseFormat::OrSymbol),
          size: T.nilable(OpenAI::ImageEditParams::Size::OrSymbol),
          user: String,
          stream: T.noreturn,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::ImagesResponse)
      end
      def edit(
        # The image(s) to edit. Must be a supported image file or an array of images.
        #
        # For `gpt-image-1`, each image should be a `png`, `webp`, or `jpg` file less than
        # 50MB. You can provide up to 16 images.
        #
        # For `dall-e-2`, you can only provide one image, and it should be a square `png`
        # file less than 4MB.
        image:,
        # A text description of the desired image(s). The maximum length is 1000
        # characters for `dall-e-2`, and 32000 characters for `gpt-image-1`.
        prompt:,
        # Allows to set transparency for the background of the generated image(s). This
        # parameter is only supported for `gpt-image-1`. Must be one of `transparent`,
        # `opaque` or `auto` (default value). When `auto` is used, the model will
        # automatically determine the best background for the image.
        #
        # If `transparent`, the output format needs to support transparency, so it should
        # be set to either `png` (default value) or `webp`.
        background: nil,
        # Control how much effort the model will exert to match the style and features,
        # especially facial features, of input images. This parameter is only supported
        # for `gpt-image-1`. Supports `high` and `low`. Defaults to `low`.
        input_fidelity: nil,
        # An additional image whose fully transparent areas (e.g. where alpha is zero)
        # indicate where `image` should be edited. If there are multiple images provided,
        # the mask will be applied on the first image. Must be a valid PNG file, less than
        # 4MB, and have the same dimensions as `image`.
        mask: nil,
        # The model to use for image generation. Only `dall-e-2` and `gpt-image-1` are
        # supported. Defaults to `dall-e-2` unless a parameter specific to `gpt-image-1`
        # is used.
        model: nil,
        # The number of images to generate. Must be between 1 and 10.
        n: nil,
        # The compression level (0-100%) for the generated images. This parameter is only
        # supported for `gpt-image-1` with the `webp` or `jpeg` output formats, and
        # defaults to 100.
        output_compression: nil,
        # The format in which the generated images are returned. This parameter is only
        # supported for `gpt-image-1`. Must be one of `png`, `jpeg`, or `webp`. The
        # default value is `png`.
        output_format: nil,
        # The number of partial images to generate. This parameter is used for streaming
        # responses that return partial images. Value must be between 0 and 3. When set to
        # 0, the response will be a single image sent in one streaming event.
        #
        # Note that the final image may be sent before the full number of partial images
        # are generated if the full image is generated more quickly.
        partial_images: nil,
        # The quality of the image that will be generated. `high`, `medium` and `low` are
        # only supported for `gpt-image-1`. `dall-e-2` only supports `standard` quality.
        # Defaults to `auto`.
        quality: nil,
        # The format in which the generated images are returned. Must be one of `url` or
        # `b64_json`. URLs are only valid for 60 minutes after the image has been
        # generated. This parameter is only supported for `dall-e-2`, as `gpt-image-1`
        # will always return base64-encoded images.
        response_format: nil,
        # The size of the generated images. Must be one of `1024x1024`, `1536x1024`
        # (landscape), `1024x1536` (portrait), or `auto` (default value) for
        # `gpt-image-1`, and one of `256x256`, `512x512`, or `1024x1024` for `dall-e-2`.
        size: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        # and detect abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        # There is no need to provide `stream:`. Instead, use `#edit_stream_raw` or
        # `#edit` for streaming and non-streaming use cases, respectively.
        stream: false,
        request_options: {}
      )
      end

      # See {OpenAI::Resources::Images#edit} for non-streaming counterpart.
      #
      # Creates an edited or extended image given one or more source images and a
      # prompt. This endpoint only supports `gpt-image-1` and `dall-e-2`.
      sig do
        params(
          image: OpenAI::ImageEditParams::Image::Variants,
          prompt: String,
          background: T.nilable(OpenAI::ImageEditParams::Background::OrSymbol),
          input_fidelity:
            T.nilable(OpenAI::ImageEditParams::InputFidelity::OrSymbol),
          mask: OpenAI::Internal::FileInput,
          model: T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol)),
          n: T.nilable(Integer),
          output_compression: T.nilable(Integer),
          output_format:
            T.nilable(OpenAI::ImageEditParams::OutputFormat::OrSymbol),
          partial_images: T.nilable(Integer),
          quality: T.nilable(OpenAI::ImageEditParams::Quality::OrSymbol),
          response_format:
            T.nilable(OpenAI::ImageEditParams::ResponseFormat::OrSymbol),
          size: T.nilable(OpenAI::ImageEditParams::Size::OrSymbol),
          user: String,
          stream: T.noreturn,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(
          OpenAI::Internal::Stream[OpenAI::ImageEditStreamEvent::Variants]
        )
      end
      def edit_stream_raw(
        # The image(s) to edit. Must be a supported image file or an array of images.
        #
        # For `gpt-image-1`, each image should be a `png`, `webp`, or `jpg` file less than
        # 50MB. You can provide up to 16 images.
        #
        # For `dall-e-2`, you can only provide one image, and it should be a square `png`
        # file less than 4MB.
        image:,
        # A text description of the desired image(s). The maximum length is 1000
        # characters for `dall-e-2`, and 32000 characters for `gpt-image-1`.
        prompt:,
        # Allows to set transparency for the background of the generated image(s). This
        # parameter is only supported for `gpt-image-1`. Must be one of `transparent`,
        # `opaque` or `auto` (default value). When `auto` is used, the model will
        # automatically determine the best background for the image.
        #
        # If `transparent`, the output format needs to support transparency, so it should
        # be set to either `png` (default value) or `webp`.
        background: nil,
        # Control how much effort the model will exert to match the style and features,
        # especially facial features, of input images. This parameter is only supported
        # for `gpt-image-1`. Supports `high` and `low`. Defaults to `low`.
        input_fidelity: nil,
        # An additional image whose fully transparent areas (e.g. where alpha is zero)
        # indicate where `image` should be edited. If there are multiple images provided,
        # the mask will be applied on the first image. Must be a valid PNG file, less than
        # 4MB, and have the same dimensions as `image`.
        mask: nil,
        # The model to use for image generation. Only `dall-e-2` and `gpt-image-1` are
        # supported. Defaults to `dall-e-2` unless a parameter specific to `gpt-image-1`
        # is used.
        model: nil,
        # The number of images to generate. Must be between 1 and 10.
        n: nil,
        # The compression level (0-100%) for the generated images. This parameter is only
        # supported for `gpt-image-1` with the `webp` or `jpeg` output formats, and
        # defaults to 100.
        output_compression: nil,
        # The format in which the generated images are returned. This parameter is only
        # supported for `gpt-image-1`. Must be one of `png`, `jpeg`, or `webp`. The
        # default value is `png`.
        output_format: nil,
        # The number of partial images to generate. This parameter is used for streaming
        # responses that return partial images. Value must be between 0 and 3. When set to
        # 0, the response will be a single image sent in one streaming event.
        #
        # Note that the final image may be sent before the full number of partial images
        # are generated if the full image is generated more quickly.
        partial_images: nil,
        # The quality of the image that will be generated. `high`, `medium` and `low` are
        # only supported for `gpt-image-1`. `dall-e-2` only supports `standard` quality.
        # Defaults to `auto`.
        quality: nil,
        # The format in which the generated images are returned. Must be one of `url` or
        # `b64_json`. URLs are only valid for 60 minutes after the image has been
        # generated. This parameter is only supported for `dall-e-2`, as `gpt-image-1`
        # will always return base64-encoded images.
        response_format: nil,
        # The size of the generated images. Must be one of `1024x1024`, `1536x1024`
        # (landscape), `1024x1536` (portrait), or `auto` (default value) for
        # `gpt-image-1`, and one of `256x256`, `512x512`, or `1024x1024` for `dall-e-2`.
        size: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        # and detect abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        # There is no need to provide `stream:`. Instead, use `#edit_stream_raw` or
        # `#edit` for streaming and non-streaming use cases, respectively.
        stream: true,
        request_options: {}
      )
      end

      # See {OpenAI::Resources::Images#generate_stream_raw} for streaming counterpart.
      #
      # Creates an image given a prompt.
      # [Learn more](https://platform.openai.com/docs/guides/images).
      sig do
        params(
          prompt: String,
          background:
            T.nilable(OpenAI::ImageGenerateParams::Background::OrSymbol),
          model: T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol)),
          moderation:
            T.nilable(OpenAI::ImageGenerateParams::Moderation::OrSymbol),
          n: T.nilable(Integer),
          output_compression: T.nilable(Integer),
          output_format:
            T.nilable(OpenAI::ImageGenerateParams::OutputFormat::OrSymbol),
          partial_images: T.nilable(Integer),
          quality: T.nilable(OpenAI::ImageGenerateParams::Quality::OrSymbol),
          response_format:
            T.nilable(OpenAI::ImageGenerateParams::ResponseFormat::OrSymbol),
          size: T.nilable(OpenAI::ImageGenerateParams::Size::OrSymbol),
          style: T.nilable(OpenAI::ImageGenerateParams::Style::OrSymbol),
          user: String,
          stream: T.noreturn,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::ImagesResponse)
      end
      def generate(
        # A text description of the desired image(s). The maximum length is 32000
        # characters for `gpt-image-1`, 1000 characters for `dall-e-2` and 4000 characters
        # for `dall-e-3`.
        prompt:,
        # Allows to set transparency for the background of the generated image(s). This
        # parameter is only supported for `gpt-image-1`. Must be one of `transparent`,
        # `opaque` or `auto` (default value). When `auto` is used, the model will
        # automatically determine the best background for the image.
        #
        # If `transparent`, the output format needs to support transparency, so it should
        # be set to either `png` (default value) or `webp`.
        background: nil,
        # The model to use for image generation. One of `dall-e-2`, `dall-e-3`, or
        # `gpt-image-1`. Defaults to `dall-e-2` unless a parameter specific to
        # `gpt-image-1` is used.
        model: nil,
        # Control the content-moderation level for images generated by `gpt-image-1`. Must
        # be either `low` for less restrictive filtering or `auto` (default value).
        moderation: nil,
        # The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
        # `n=1` is supported.
        n: nil,
        # The compression level (0-100%) for the generated images. This parameter is only
        # supported for `gpt-image-1` with the `webp` or `jpeg` output formats, and
        # defaults to 100.
        output_compression: nil,
        # The format in which the generated images are returned. This parameter is only
        # supported for `gpt-image-1`. Must be one of `png`, `jpeg`, or `webp`.
        output_format: nil,
        # The number of partial images to generate. This parameter is used for streaming
        # responses that return partial images. Value must be between 0 and 3. When set to
        # 0, the response will be a single image sent in one streaming event.
        #
        # Note that the final image may be sent before the full number of partial images
        # are generated if the full image is generated more quickly.
        partial_images: nil,
        # The quality of the image that will be generated.
        #
        # - `auto` (default value) will automatically select the best quality for the
        #   given model.
        # - `high`, `medium` and `low` are supported for `gpt-image-1`.
        # - `hd` and `standard` are supported for `dall-e-3`.
        # - `standard` is the only option for `dall-e-2`.
        quality: nil,
        # The format in which generated images with `dall-e-2` and `dall-e-3` are
        # returned. Must be one of `url` or `b64_json`. URLs are only valid for 60 minutes
        # after the image has been generated. This parameter isn't supported for
        # `gpt-image-1` which will always return base64-encoded images.
        response_format: nil,
        # The size of the generated images. Must be one of `1024x1024`, `1536x1024`
        # (landscape), `1024x1536` (portrait), or `auto` (default value) for
        # `gpt-image-1`, one of `256x256`, `512x512`, or `1024x1024` for `dall-e-2`, and
        # one of `1024x1024`, `1792x1024`, or `1024x1792` for `dall-e-3`.
        size: nil,
        # The style of the generated images. This parameter is only supported for
        # `dall-e-3`. Must be one of `vivid` or `natural`. Vivid causes the model to lean
        # towards generating hyper-real and dramatic images. Natural causes the model to
        # produce more natural, less hyper-real looking images.
        style: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        # and detect abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        # There is no need to provide `stream:`. Instead, use `#generate_stream_raw` or
        # `#generate` for streaming and non-streaming use cases, respectively.
        stream: false,
        request_options: {}
      )
      end

      # See {OpenAI::Resources::Images#generate} for non-streaming counterpart.
      #
      # Creates an image given a prompt.
      # [Learn more](https://platform.openai.com/docs/guides/images).
      sig do
        params(
          prompt: String,
          background:
            T.nilable(OpenAI::ImageGenerateParams::Background::OrSymbol),
          model: T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol)),
          moderation:
            T.nilable(OpenAI::ImageGenerateParams::Moderation::OrSymbol),
          n: T.nilable(Integer),
          output_compression: T.nilable(Integer),
          output_format:
            T.nilable(OpenAI::ImageGenerateParams::OutputFormat::OrSymbol),
          partial_images: T.nilable(Integer),
          quality: T.nilable(OpenAI::ImageGenerateParams::Quality::OrSymbol),
          response_format:
            T.nilable(OpenAI::ImageGenerateParams::ResponseFormat::OrSymbol),
          size: T.nilable(OpenAI::ImageGenerateParams::Size::OrSymbol),
          style: T.nilable(OpenAI::ImageGenerateParams::Style::OrSymbol),
          user: String,
          stream: T.noreturn,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(
          OpenAI::Internal::Stream[OpenAI::ImageGenStreamEvent::Variants]
        )
      end
      def generate_stream_raw(
        # A text description of the desired image(s). The maximum length is 32000
        # characters for `gpt-image-1`, 1000 characters for `dall-e-2` and 4000 characters
        # for `dall-e-3`.
        prompt:,
        # Allows to set transparency for the background of the generated image(s). This
        # parameter is only supported for `gpt-image-1`. Must be one of `transparent`,
        # `opaque` or `auto` (default value). When `auto` is used, the model will
        # automatically determine the best background for the image.
        #
        # If `transparent`, the output format needs to support transparency, so it should
        # be set to either `png` (default value) or `webp`.
        background: nil,
        # The model to use for image generation. One of `dall-e-2`, `dall-e-3`, or
        # `gpt-image-1`. Defaults to `dall-e-2` unless a parameter specific to
        # `gpt-image-1` is used.
        model: nil,
        # Control the content-moderation level for images generated by `gpt-image-1`. Must
        # be either `low` for less restrictive filtering or `auto` (default value).
        moderation: nil,
        # The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
        # `n=1` is supported.
        n: nil,
        # The compression level (0-100%) for the generated images. This parameter is only
        # supported for `gpt-image-1` with the `webp` or `jpeg` output formats, and
        # defaults to 100.
        output_compression: nil,
        # The format in which the generated images are returned. This parameter is only
        # supported for `gpt-image-1`. Must be one of `png`, `jpeg`, or `webp`.
        output_format: nil,
        # The number of partial images to generate. This parameter is used for streaming
        # responses that return partial images. Value must be between 0 and 3. When set to
        # 0, the response will be a single image sent in one streaming event.
        #
        # Note that the final image may be sent before the full number of partial images
        # are generated if the full image is generated more quickly.
        partial_images: nil,
        # The quality of the image that will be generated.
        #
        # - `auto` (default value) will automatically select the best quality for the
        #   given model.
        # - `high`, `medium` and `low` are supported for `gpt-image-1`.
        # - `hd` and `standard` are supported for `dall-e-3`.
        # - `standard` is the only option for `dall-e-2`.
        quality: nil,
        # The format in which generated images with `dall-e-2` and `dall-e-3` are
        # returned. Must be one of `url` or `b64_json`. URLs are only valid for 60 minutes
        # after the image has been generated. This parameter isn't supported for
        # `gpt-image-1` which will always return base64-encoded images.
        response_format: nil,
        # The size of the generated images. Must be one of `1024x1024`, `1536x1024`
        # (landscape), `1024x1536` (portrait), or `auto` (default value) for
        # `gpt-image-1`, one of `256x256`, `512x512`, or `1024x1024` for `dall-e-2`, and
        # one of `1024x1024`, `1792x1024`, or `1024x1792` for `dall-e-3`.
        size: nil,
        # The style of the generated images. This parameter is only supported for
        # `dall-e-3`. Must be one of `vivid` or `natural`. Vivid causes the model to lean
        # towards generating hyper-real and dramatic images. Natural causes the model to
        # produce more natural, less hyper-real looking images.
        style: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        # and detect abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        # There is no need to provide `stream:`. Instead, use `#generate_stream_raw` or
        # `#generate` for streaming and non-streaming use cases, respectively.
        stream: true,
        request_options: {}
      )
      end

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
