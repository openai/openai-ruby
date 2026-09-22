# frozen_string_literal: true

module OpenAI
  module Resources
    # Given a prompt and/or an input image, the model will generate a new image.
    class Images
      # Legacy endpoint for creating variations with DALL·E 2, which was retired from
      # the API on May 12, 2026. See
      # [deprecations](https://developers.openai.com/api/docs/deprecations). For new
      # integrations, use image edits with a supported GPT Image model; see the
      # [image generation guide](https://developers.openai.com/api/docs/guides/image-generation).
      #
      # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      # metadata. Use `OpenAI::FilePart` when you need to override the filename or
      # content type.
      #
      # @overload create_variation(image:, model: nil, n: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #
      # @param image [Pathname, StringIO, IO, String, OpenAI::FilePart]
      #   The input image for the legacy variations endpoint. The legacy format requires a
      #   valid PNG file, less than 4MB, and square.
      #
      #   `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      #   metadata. Use `OpenAI::FilePart` when you need to override the filename or
      #   content type.
      #
      # @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      #   Legacy model selection for the variations endpoint, which was designed for
      #   `dall-e-2`. DALL·E 2 was retired from the API on May 12, 2026; see
      #   [deprecations](https://developers.openai.com/api/docs/deprecations). Use image
      #   edits with a supported GPT Image model for new integrations.
      #
      # @param n [Integer, nil]
      #   The number of images requested from the legacy variations endpoint. Must be
      #   between 1 and 10.
      #
      # @param response_format [Symbol, OpenAI::Models::ImageCreateVariationParams::ResponseFormat, nil]
      #   The response format for the legacy variations endpoint: `url` or `b64_json`.
      #   Returned URLs were valid for 60 minutes after image generation.
      #
      # @param size [Symbol, OpenAI::Models::ImageCreateVariationParams::Size, nil]
      #   The requested image size for the legacy variations endpoint. Must be one of
      #   `256x256`, `512x512`, or `1024x1024`.
      #
      # @param user [String]
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ImagesResponse]
      #
      # @see OpenAI::Models::ImageCreateVariationParams
      def create_variation(params)
        parsed, options = OpenAI::ImageCreateVariationParams.dump_request(params)
        @client.request(
          method: :post,
          path: "images/variations",
          headers: {"content-type" => "multipart/form-data"},
          body: parsed,
          model: OpenAI::ImagesResponse,
          security: {bearer_auth: true},
          options: options
        )
      end

      # See {OpenAI::Resources::Images#edit_stream_raw} for streaming counterpart.
      #
      # Creates an edited or extended image given one or more source images and a
      # prompt. This endpoint supports GPT Image models. DALL·E 2 was retired from the
      # API on May 12, 2026; see
      # [deprecations](https://developers.openai.com/api/docs/deprecations).
      #
      # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      # metadata. Use `OpenAI::FilePart` when you need to override the filename or
      # content type.
      #
      # @overload edit(image:, prompt:, background: nil, input_fidelity: nil, mask: nil, model: nil, n: nil, output_compression: nil, output_format: nil, partial_images: nil, quality: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #
      # @param image [Pathname, StringIO, IO, String, OpenAI::FilePart, Array<Pathname, StringIO, IO, String, OpenAI::FilePart>]
      #   The image(s) to edit. Must be a supported image file or an array of images.
      #
      #   For the GPT image models (`gpt-image-1`, `gpt-image-1-mini`, `gpt-image-1.5`,
      #   `gpt-image-2`, `gpt-image-2-2026-04-21`, `gpt-image-2.5-sunburst`,
      #   `gpt-image-2.5-sunburst-2026-09-08`, `gpt-image-2.5-flare`,
      #   `gpt-image-2.5-flare-2026-09-08`, and `chatgpt-image-latest`), each image should
      #   be a `png`, `webp`, or `jpg` file less than 50MB. You can provide up to 16
      #   images.
      #
      #   `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      #   metadata. Use `OpenAI::FilePart` when you need to override the filename or
      #   content type.
      #
      # @param prompt [String]
      #   A text description of the desired image(s). The maximum length is 32000
      #   characters for the GPT image models.
      #
      # @param background [Symbol, OpenAI::Models::ImageEditParams::Background, nil]
      #   Allows to set transparency for the background of the generated image(s). Must be
      #   one of `transparent`, `opaque`, or `auto` (default value). When `auto` is used,
      #   the model will automatically determine the best background for the image.
      #
      #   `gpt-image-2.5-sunburst` and `gpt-image-2.5-flare`, including their `2026-09-08`
      #   snapshots, support `opaque` and `transparent` backgrounds. Transparent
      #   backgrounds are available for supported GPT Image models. For `gpt-image-2` and
      #   `gpt-image-2-2026-04-21`, this support is in preview. When using `transparent`,
      #   set the output format to `png` or `webp`.
      #
      # @param input_fidelity [Symbol, OpenAI::Models::ImageEditParams::InputFidelity, nil]
      #   Control how much effort the model will exert to match the style and features,
      #   especially facial features, of input images. Models that accept both `high` and
      #   `low` include `gpt-image-1`, `gpt-image-1.5`, and `chatgpt-image-latest`.
      #   `gpt-image-1-mini` accepts only `low`. Defaults to `low` on models that support
      #   this parameter. Omit this parameter for `gpt-image-2`, `gpt-image-2-2026-04-21`,
      #   and other models that do not support it. See the
      #   [image input fidelity guide](https://developers.openai.com/api/docs/guides/image-generation#image-input-fidelity)
      #   for model-specific guidance.
      #
      # @param mask [Pathname, StringIO, IO, String, OpenAI::FilePart]
      #   An additional image whose fully transparent areas (e.g. where alpha is zero)
      #   indicate where `image` should be edited. If there are multiple images provided,
      #   the mask will be applied on the first image. Must be a valid PNG file, less than
      #   4MB, and have the same dimensions as `image`.
      #
      #   `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      #   metadata. Use `OpenAI::FilePart` when you need to override the filename or
      #   content type.
      #
      # @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      #   The GPT Image model to use for image editing (`gpt-image-1`, `gpt-image-1-mini`,
      #   `gpt-image-1.5`, `gpt-image-2`, `gpt-image-2-2026-04-21`,
      #   `gpt-image-2.5-sunburst`, `gpt-image-2.5-sunburst-2026-09-08`,
      #   `gpt-image-2.5-flare`, `gpt-image-2.5-flare-2026-09-08`, or
      #   `chatgpt-image-latest`). Defaults to `gpt-image-1.5`. DALL·E 2 was retired from
      #   the API on May 12, 2026; see
      #   [deprecations](https://developers.openai.com/api/docs/deprecations).
      #
      # @param n [Integer, nil]
      #   The number of images to generate. Must be between 1 and 10.
      #
      # @param output_compression [Integer, nil]
      #   The compression level (0-100%) for the generated images. This parameter is only
      #   supported for the GPT image models with the `webp` or `jpeg` output formats, and
      #   defaults to 100.
      #
      # @param output_format [Symbol, OpenAI::Models::ImageEditParams::OutputFormat, nil]
      #   The format in which the generated images are returned. This parameter is only
      #   supported for the GPT image models. Must be one of `png`, `jpeg`, or `webp`. The
      #   default value is `png`.
      #
      # @param partial_images [Integer, nil]
      #   The number of partial images to generate. This parameter is used for streaming
      #   responses that return partial images. Value must be between 0 and 3. When set to
      #   0, the response will be a single image sent in one streaming event.
      #
      #   Note that the final image may be sent before the full number of partial images
      #   are generated if the full image is generated more quickly.
      #
      # @param quality [Symbol, OpenAI::Models::ImageEditParams::Quality, nil]
      #   The quality of the image that will be generated for GPT image models. The GPT
      #   image models support `low`, `medium`, and `high`. `gpt-image-2.5-sunburst` and
      #   `gpt-image-2.5-flare`, including their `2026-09-08` snapshots, also support
      #   `xhigh` and `max`. Defaults to `auto`.
      #
      # @param response_format [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil]
      #   Legacy response-format parameter (`url` or `b64_json`) for the retired
      #   `dall-e-2` model. GPT Image models always return base64-encoded images.
      #
      # @param size [String, Symbol, OpenAI::Models::ImageEditParams::Size, nil]
      #   The size of the generated images. For `gpt-image-2`, `gpt-image-2-2026-04-21`,
      #   `gpt-image-2.5-sunburst`, `gpt-image-2.5-sunburst-2026-09-08`,
      #   `gpt-image-2.5-flare`, and `gpt-image-2.5-flare-2026-09-08`, arbitrary
      #   resolutions are supported as `WIDTHxHEIGHT` strings, for example `1536x864`.
      #   Width and height must both be divisible by 16 and the requested aspect ratio
      #   must be between 1:3 and 3:1. Resolutions above `2560x1440` are experimental, and
      #   the maximum supported resolution is `3840x2160`. The requested size must also
      #   satisfy the model's current pixel and edge limits. The standard sizes
      #   `1024x1024`, `1536x1024`, and `1024x1536` are supported by the GPT image models;
      #   `auto` is supported for models that allow automatic sizing. Legacy sizes for the
      #   retired `dall-e-2` model were `256x256`, `512x512`, and `1024x1024`.
      #
      # @param user [String]
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ImagesResponse]
      #
      # @see OpenAI::Models::ImageEditParams
      def edit(params)
        parsed, options = OpenAI::ImageEditParams.dump_request(params)
        if parsed[:stream]
          message = "Please use `#edit_stream_raw` for the streaming use case."
          raise ArgumentError.new(message)
        end

        @client.request(
          method: :post,
          path: "images/edits",
          headers: {"content-type" => "multipart/form-data"},
          body: parsed,
          model: OpenAI::ImagesResponse,
          security: {bearer_auth: true},
          options: options
        )
      end

      # See {OpenAI::Resources::Images#edit} for non-streaming counterpart.
      #
      # Creates an edited or extended image given one or more source images and a
      # prompt. This endpoint supports GPT Image models. DALL·E 2 was retired from the
      # API on May 12, 2026; see
      # [deprecations](https://developers.openai.com/api/docs/deprecations).
      #
      # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      # metadata. Use `OpenAI::FilePart` when you need to override the filename or
      # content type.
      #
      # @overload edit_stream_raw(image:, prompt:, background: nil, input_fidelity: nil, mask: nil, model: nil, n: nil, output_compression: nil, output_format: nil, partial_images: nil, quality: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #
      # @param image [Pathname, StringIO, IO, String, OpenAI::FilePart, Array<Pathname, StringIO, IO, String, OpenAI::FilePart>]
      #   The image(s) to edit. Must be a supported image file or an array of images.
      #
      #   For the GPT image models (`gpt-image-1`, `gpt-image-1-mini`, `gpt-image-1.5`,
      #   `gpt-image-2`, `gpt-image-2-2026-04-21`, `gpt-image-2.5-sunburst`,
      #   `gpt-image-2.5-sunburst-2026-09-08`, `gpt-image-2.5-flare`,
      #   `gpt-image-2.5-flare-2026-09-08`, and `chatgpt-image-latest`), each image should
      #   be a `png`, `webp`, or `jpg` file less than 50MB. You can provide up to 16
      #   images.
      #
      #   `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      #   metadata. Use `OpenAI::FilePart` when you need to override the filename or
      #   content type.
      #
      # @param prompt [String]
      #   A text description of the desired image(s). The maximum length is 32000
      #   characters for the GPT image models.
      #
      # @param background [Symbol, OpenAI::Models::ImageEditParams::Background, nil]
      #   Allows to set transparency for the background of the generated image(s). Must be
      #   one of `transparent`, `opaque`, or `auto` (default value). When `auto` is used,
      #   the model will automatically determine the best background for the image.
      #
      #   `gpt-image-2.5-sunburst` and `gpt-image-2.5-flare`, including their `2026-09-08`
      #   snapshots, support `opaque` and `transparent` backgrounds. Transparent
      #   backgrounds are available for supported GPT Image models. For `gpt-image-2` and
      #   `gpt-image-2-2026-04-21`, this support is in preview. When using `transparent`,
      #   set the output format to `png` or `webp`.
      #
      # @param input_fidelity [Symbol, OpenAI::Models::ImageEditParams::InputFidelity, nil]
      #   Control how much effort the model will exert to match the style and features,
      #   especially facial features, of input images. Models that accept both `high` and
      #   `low` include `gpt-image-1`, `gpt-image-1.5`, and `chatgpt-image-latest`.
      #   `gpt-image-1-mini` accepts only `low`. Defaults to `low` on models that support
      #   this parameter. Omit this parameter for `gpt-image-2`, `gpt-image-2-2026-04-21`,
      #   and other models that do not support it. See the
      #   [image input fidelity guide](https://developers.openai.com/api/docs/guides/image-generation#image-input-fidelity)
      #   for model-specific guidance.
      #
      # @param mask [Pathname, StringIO, IO, String, OpenAI::FilePart]
      #   An additional image whose fully transparent areas (e.g. where alpha is zero)
      #   indicate where `image` should be edited. If there are multiple images provided,
      #   the mask will be applied on the first image. Must be a valid PNG file, less than
      #   4MB, and have the same dimensions as `image`.
      #
      #   `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      #   metadata. Use `OpenAI::FilePart` when you need to override the filename or
      #   content type.
      #
      # @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      #   The GPT Image model to use for image editing (`gpt-image-1`, `gpt-image-1-mini`,
      #   `gpt-image-1.5`, `gpt-image-2`, `gpt-image-2-2026-04-21`,
      #   `gpt-image-2.5-sunburst`, `gpt-image-2.5-sunburst-2026-09-08`,
      #   `gpt-image-2.5-flare`, `gpt-image-2.5-flare-2026-09-08`, or
      #   `chatgpt-image-latest`). Defaults to `gpt-image-1.5`. DALL·E 2 was retired from
      #   the API on May 12, 2026; see
      #   [deprecations](https://developers.openai.com/api/docs/deprecations).
      #
      # @param n [Integer, nil]
      #   The number of images to generate. Must be between 1 and 10.
      #
      # @param output_compression [Integer, nil]
      #   The compression level (0-100%) for the generated images. This parameter is only
      #   supported for the GPT image models with the `webp` or `jpeg` output formats, and
      #   defaults to 100.
      #
      # @param output_format [Symbol, OpenAI::Models::ImageEditParams::OutputFormat, nil]
      #   The format in which the generated images are returned. This parameter is only
      #   supported for the GPT image models. Must be one of `png`, `jpeg`, or `webp`. The
      #   default value is `png`.
      #
      # @param partial_images [Integer, nil]
      #   The number of partial images to generate. This parameter is used for streaming
      #   responses that return partial images. Value must be between 0 and 3. When set to
      #   0, the response will be a single image sent in one streaming event.
      #
      #   Note that the final image may be sent before the full number of partial images
      #   are generated if the full image is generated more quickly.
      #
      # @param quality [Symbol, OpenAI::Models::ImageEditParams::Quality, nil]
      #   The quality of the image that will be generated for GPT image models. The GPT
      #   image models support `low`, `medium`, and `high`. `gpt-image-2.5-sunburst` and
      #   `gpt-image-2.5-flare`, including their `2026-09-08` snapshots, also support
      #   `xhigh` and `max`. Defaults to `auto`.
      #
      # @param response_format [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil]
      #   Legacy response-format parameter (`url` or `b64_json`) for the retired
      #   `dall-e-2` model. GPT Image models always return base64-encoded images.
      #
      # @param size [String, Symbol, OpenAI::Models::ImageEditParams::Size, nil]
      #   The size of the generated images. For `gpt-image-2`, `gpt-image-2-2026-04-21`,
      #   `gpt-image-2.5-sunburst`, `gpt-image-2.5-sunburst-2026-09-08`,
      #   `gpt-image-2.5-flare`, and `gpt-image-2.5-flare-2026-09-08`, arbitrary
      #   resolutions are supported as `WIDTHxHEIGHT` strings, for example `1536x864`.
      #   Width and height must both be divisible by 16 and the requested aspect ratio
      #   must be between 1:3 and 3:1. Resolutions above `2560x1440` are experimental, and
      #   the maximum supported resolution is `3840x2160`. The requested size must also
      #   satisfy the model's current pixel and edge limits. The standard sizes
      #   `1024x1024`, `1536x1024`, and `1024x1536` are supported by the GPT image models;
      #   `auto` is supported for models that allow automatic sizing. Legacy sizes for the
      #   retired `dall-e-2` model were `256x256`, `512x512`, and `1024x1024`.
      #
      # @param user [String]
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Stream<OpenAI::Models::ImageEditPartialImageEvent, OpenAI::Models::ImageEditCompletedEvent>]
      #
      # @see OpenAI::Models::ImageEditParams
      def edit_stream_raw(params)
        parsed, options = OpenAI::ImageEditParams.dump_request(params)
        unless parsed.fetch(:stream, true)
          message = "Please use `#edit` for the non-streaming use case."
          raise ArgumentError.new(message)
        end

        parsed.store(:stream, true)
        @client.request(
          method: :post,
          path: "images/edits",
          headers: {
            "content-type" => "multipart/form-data",
            "accept" => "text/event-stream",
            "accept-encoding" => "identity"
          },
          body: parsed,
          stream: OpenAI::Internal::Stream,
          model: OpenAI::ImageEditStreamEvent,
          security: {bearer_auth: true},
          options: options
        )
      end

      # See {OpenAI::Resources::Images#generate_stream_raw} for streaming counterpart.
      #
      # Creates an image given a prompt.
      # [Learn more](https://developers.openai.com/api/docs/guides/images-vision).
      #
      # @overload generate(prompt:, background: nil, model: nil, moderation: nil, n: nil, output_compression: nil, output_format: nil, partial_images: nil, quality: nil, response_format: nil, size: nil, style: nil, user: nil, request_options: {})
      #
      # @param prompt [String]
      #   A text description of the desired image(s). The maximum length is 32000
      #   characters for the GPT image models. Legacy limits for the retired models were
      #   1000 characters for `dall-e-2` and 4000 characters for `dall-e-3`.
      #
      # @param background [Symbol, OpenAI::Models::ImageGenerateParams::Background, nil]
      #   Allows to set transparency for the background of the generated image(s). Must be
      #   one of `transparent`, `opaque`, or `auto` (default value). When `auto` is used,
      #   the model will automatically determine the best background for the image.
      #
      #   `gpt-image-2.5-sunburst` and `gpt-image-2.5-flare`, including their `2026-09-08`
      #   snapshots, support `opaque` and `transparent` backgrounds. Transparent
      #   backgrounds are available for supported GPT Image models. For `gpt-image-2` and
      #   `gpt-image-2-2026-04-21`, this support is in preview. When using `transparent`,
      #   set the output format to `png` or `webp`.
      #
      # @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      #   The GPT Image model to use for image generation. Specify a supported model
      #   explicitly, such as `gpt-image-1`, `gpt-image-1-mini`, `gpt-image-1.5`,
      #   `gpt-image-2`, `gpt-image-2-2026-04-21`, `gpt-image-2.5-sunburst`,
      #   `gpt-image-2.5-sunburst-2026-09-08`, `gpt-image-2.5-flare`, or
      #   `gpt-image-2.5-flare-2026-09-08`. DALL·E 2 (`dall-e-2`) and DALL·E 3
      #   (`dall-e-3`) were retired from the API on May 12, 2026; see
      #   [deprecations](https://developers.openai.com/api/docs/deprecations).
      #
      # @param moderation [Symbol, OpenAI::Models::ImageGenerateParams::Moderation, nil]
      #   Control the content-moderation level for images generated by the GPT image
      #   models. Must be either `low` for less restrictive filtering or `auto` (default
      #   value).
      #
      # @param n [Integer, nil]
      #   The number of images to generate. Must be between 1 and 10. The retired
      #   `dall-e-3` model only supported `n=1`.
      #
      # @param output_compression [Integer, nil]
      #   The compression level (0-100%) for the generated images. This parameter is only
      #   supported for the GPT image models with the `webp` or `jpeg` output formats, and
      #   defaults to 100.
      #
      # @param output_format [Symbol, OpenAI::Models::ImageGenerateParams::OutputFormat, nil]
      #   The format in which the generated images are returned. This parameter is only
      #   supported for the GPT image models. Must be one of `png`, `jpeg`, or `webp`.
      #
      # @param partial_images [Integer, nil]
      #   The number of partial images to generate. This parameter is used for streaming
      #   responses that return partial images. Value must be between 0 and 3. When set to
      #   0, the response will be a single image sent in one streaming event.
      #
      #   Note that the final image may be sent before the full number of partial images
      #   are generated if the full image is generated more quickly.
      #
      # @param quality [Symbol, OpenAI::Models::ImageGenerateParams::Quality, nil]
      #   The quality of the image that will be generated.
      #
      #   - `auto` (default value) will automatically select the best quality for the
      #     given model.
      #   - `high`, `medium` and `low` are supported for the GPT image models.
      #   - `gpt-image-2.5-sunburst` and `gpt-image-2.5-flare`, including their
      #     `2026-09-08` snapshots, also support `xhigh` and `max`.
      #   - The retired `dall-e-3` model supported the legacy values `hd` and `standard`.
      #   - The retired `dall-e-2` model only supported the legacy value `standard`.
      #
      # @param response_format [Symbol, OpenAI::Models::ImageGenerateParams::ResponseFormat, nil]
      #   Legacy response format: `url` or `b64_json`, for the retired `dall-e-2` and
      #   `dall-e-3` models. Returned URLs were valid for 60 minutes after image
      #   generation. This parameter is not supported for the GPT image models, which
      #   always return base64-encoded images.
      #
      # @param size [String, Symbol, OpenAI::Models::ImageGenerateParams::Size, nil]
      #   The size of the generated images. For `gpt-image-2`, `gpt-image-2-2026-04-21`,
      #   `gpt-image-2.5-sunburst`, `gpt-image-2.5-sunburst-2026-09-08`,
      #   `gpt-image-2.5-flare`, and `gpt-image-2.5-flare-2026-09-08`, arbitrary
      #   resolutions are supported as `WIDTHxHEIGHT` strings, for example `1536x864`.
      #   Width and height must both be divisible by 16 and the requested aspect ratio
      #   must be between 1:3 and 3:1. Resolutions above `2560x1440` are experimental, and
      #   the maximum supported resolution is `3840x2160`. The requested size must also
      #   satisfy the model's current pixel and edge limits. The standard sizes
      #   `1024x1024`, `1536x1024`, and `1024x1536` are supported by the GPT image models;
      #   `auto` is supported for models that allow automatic sizing. Legacy sizes for the
      #   retired `dall-e-2` model were `256x256`, `512x512`, and `1024x1024`. Legacy
      #   sizes for the retired `dall-e-3` model were `1024x1024`, `1792x1024`, and
      #   `1024x1792`.
      #
      # @param style [Symbol, OpenAI::Models::ImageGenerateParams::Style, nil]
      #   Legacy style options `vivid` and `natural` for the retired `dall-e-3` model.
      #   Vivid produced hyper-real and dramatic images; natural produced more natural,
      #   less hyper-real looking images. This parameter is not supported for the GPT
      #   image models.
      #
      # @param user [String]
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ImagesResponse]
      #
      # @see OpenAI::Models::ImageGenerateParams
      def generate(params)
        parsed, options = OpenAI::ImageGenerateParams.dump_request(params)
        if parsed[:stream]
          message = "Please use `#generate_stream_raw` for the streaming use case."
          raise ArgumentError.new(message)
        end

        @client.request(
          method: :post,
          path: "images/generations",
          body: parsed,
          model: OpenAI::ImagesResponse,
          security: {bearer_auth: true},
          options: options
        )
      end

      # See {OpenAI::Resources::Images#generate} for non-streaming counterpart.
      #
      # Creates an image given a prompt.
      # [Learn more](https://developers.openai.com/api/docs/guides/images-vision).
      #
      # @overload generate_stream_raw(prompt:, background: nil, model: nil, moderation: nil, n: nil, output_compression: nil, output_format: nil, partial_images: nil, quality: nil, response_format: nil, size: nil, style: nil, user: nil, request_options: {})
      #
      # @param prompt [String]
      #   A text description of the desired image(s). The maximum length is 32000
      #   characters for the GPT image models. Legacy limits for the retired models were
      #   1000 characters for `dall-e-2` and 4000 characters for `dall-e-3`.
      #
      # @param background [Symbol, OpenAI::Models::ImageGenerateParams::Background, nil]
      #   Allows to set transparency for the background of the generated image(s). Must be
      #   one of `transparent`, `opaque`, or `auto` (default value). When `auto` is used,
      #   the model will automatically determine the best background for the image.
      #
      #   `gpt-image-2.5-sunburst` and `gpt-image-2.5-flare`, including their `2026-09-08`
      #   snapshots, support `opaque` and `transparent` backgrounds. Transparent
      #   backgrounds are available for supported GPT Image models. For `gpt-image-2` and
      #   `gpt-image-2-2026-04-21`, this support is in preview. When using `transparent`,
      #   set the output format to `png` or `webp`.
      #
      # @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      #   The GPT Image model to use for image generation. Specify a supported model
      #   explicitly, such as `gpt-image-1`, `gpt-image-1-mini`, `gpt-image-1.5`,
      #   `gpt-image-2`, `gpt-image-2-2026-04-21`, `gpt-image-2.5-sunburst`,
      #   `gpt-image-2.5-sunburst-2026-09-08`, `gpt-image-2.5-flare`, or
      #   `gpt-image-2.5-flare-2026-09-08`. DALL·E 2 (`dall-e-2`) and DALL·E 3
      #   (`dall-e-3`) were retired from the API on May 12, 2026; see
      #   [deprecations](https://developers.openai.com/api/docs/deprecations).
      #
      # @param moderation [Symbol, OpenAI::Models::ImageGenerateParams::Moderation, nil]
      #   Control the content-moderation level for images generated by the GPT image
      #   models. Must be either `low` for less restrictive filtering or `auto` (default
      #   value).
      #
      # @param n [Integer, nil]
      #   The number of images to generate. Must be between 1 and 10. The retired
      #   `dall-e-3` model only supported `n=1`.
      #
      # @param output_compression [Integer, nil]
      #   The compression level (0-100%) for the generated images. This parameter is only
      #   supported for the GPT image models with the `webp` or `jpeg` output formats, and
      #   defaults to 100.
      #
      # @param output_format [Symbol, OpenAI::Models::ImageGenerateParams::OutputFormat, nil]
      #   The format in which the generated images are returned. This parameter is only
      #   supported for the GPT image models. Must be one of `png`, `jpeg`, or `webp`.
      #
      # @param partial_images [Integer, nil]
      #   The number of partial images to generate. This parameter is used for streaming
      #   responses that return partial images. Value must be between 0 and 3. When set to
      #   0, the response will be a single image sent in one streaming event.
      #
      #   Note that the final image may be sent before the full number of partial images
      #   are generated if the full image is generated more quickly.
      #
      # @param quality [Symbol, OpenAI::Models::ImageGenerateParams::Quality, nil]
      #   The quality of the image that will be generated.
      #
      #   - `auto` (default value) will automatically select the best quality for the
      #     given model.
      #   - `high`, `medium` and `low` are supported for the GPT image models.
      #   - `gpt-image-2.5-sunburst` and `gpt-image-2.5-flare`, including their
      #     `2026-09-08` snapshots, also support `xhigh` and `max`.
      #   - The retired `dall-e-3` model supported the legacy values `hd` and `standard`.
      #   - The retired `dall-e-2` model only supported the legacy value `standard`.
      #
      # @param response_format [Symbol, OpenAI::Models::ImageGenerateParams::ResponseFormat, nil]
      #   Legacy response format: `url` or `b64_json`, for the retired `dall-e-2` and
      #   `dall-e-3` models. Returned URLs were valid for 60 minutes after image
      #   generation. This parameter is not supported for the GPT image models, which
      #   always return base64-encoded images.
      #
      # @param size [String, Symbol, OpenAI::Models::ImageGenerateParams::Size, nil]
      #   The size of the generated images. For `gpt-image-2`, `gpt-image-2-2026-04-21`,
      #   `gpt-image-2.5-sunburst`, `gpt-image-2.5-sunburst-2026-09-08`,
      #   `gpt-image-2.5-flare`, and `gpt-image-2.5-flare-2026-09-08`, arbitrary
      #   resolutions are supported as `WIDTHxHEIGHT` strings, for example `1536x864`.
      #   Width and height must both be divisible by 16 and the requested aspect ratio
      #   must be between 1:3 and 3:1. Resolutions above `2560x1440` are experimental, and
      #   the maximum supported resolution is `3840x2160`. The requested size must also
      #   satisfy the model's current pixel and edge limits. The standard sizes
      #   `1024x1024`, `1536x1024`, and `1024x1536` are supported by the GPT image models;
      #   `auto` is supported for models that allow automatic sizing. Legacy sizes for the
      #   retired `dall-e-2` model were `256x256`, `512x512`, and `1024x1024`. Legacy
      #   sizes for the retired `dall-e-3` model were `1024x1024`, `1792x1024`, and
      #   `1024x1792`.
      #
      # @param style [Symbol, OpenAI::Models::ImageGenerateParams::Style, nil]
      #   Legacy style options `vivid` and `natural` for the retired `dall-e-3` model.
      #   Vivid produced hyper-real and dramatic images; natural produced more natural,
      #   less hyper-real looking images. This parameter is not supported for the GPT
      #   image models.
      #
      # @param user [String]
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Stream<OpenAI::Models::ImageGenPartialImageEvent, OpenAI::Models::ImageGenCompletedEvent>]
      #
      # @see OpenAI::Models::ImageGenerateParams
      def generate_stream_raw(params)
        parsed, options = OpenAI::ImageGenerateParams.dump_request(params)
        unless parsed.fetch(:stream, true)
          message = "Please use `#generate` for the non-streaming use case."
          raise ArgumentError.new(message)
        end

        parsed.store(:stream, true)
        @client.request(
          method: :post,
          path: "images/generations",
          headers: {"accept" => "text/event-stream", "accept-encoding" => "identity"},
          body: parsed,
          stream: OpenAI::Internal::Stream,
          model: OpenAI::ImageGenStreamEvent,
          security: {bearer_auth: true},
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
