# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Images#edit
    #
    # @see OpenAI::Resources::Images#edit_stream_raw
    class ImageEditParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute image
      #   The image(s) to edit. Must be a supported image file or an array of images.
      #
      #   For the GPT image models (`gpt-image-1`, `gpt-image-1-mini`, `gpt-image-1.5`,
      #   `gpt-image-2`, `gpt-image-2-2026-04-21`, and `chatgpt-image-latest`), each image
      #   should be a `png`, `webp`, or `jpg` file less than 50MB. You can provide up to
      #   16 images.
      #
      #   For `dall-e-2`, you can only provide one image, and it should be a square `png`
      #   file less than 4MB.
      #
      #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart, Array<Pathname, StringIO, IO, String, OpenAI::FilePart>]
      required :image, union: -> { OpenAI::ImageEditParams::Image }

      # @!attribute prompt
      #   A text description of the desired image(s). The maximum length is 1000
      #   characters for `dall-e-2`, and 32000 characters for the GPT image models.
      #
      #   @return [String]
      required :prompt, String

      # @!attribute background
      #   Allows to set transparency for the background of the generated image(s). This
      #   parameter is only supported for GPT image models that support transparent
      #   backgrounds. Must be one of `transparent`, `opaque`, or `auto` (default value).
      #   When `auto` is used, the model will automatically determine the best background
      #   for the image.
      #
      #   `gpt-image-2` and `gpt-image-2-2026-04-21` do not support transparent
      #   backgrounds. Requests with `background` set to `transparent` will return an
      #   error for these models; use `opaque` or `auto` instead.
      #
      #   If `transparent`, the output format needs to support transparency, so it should
      #   be set to either `png` (default value) or `webp`.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditParams::Background, nil]
      optional :background, enum: -> { OpenAI::ImageEditParams::Background }, nil?: true

      # @!attribute input_fidelity
      #   Control how much effort the model will exert to match the style and features,
      #   especially facial features, of input images. This parameter is only supported
      #   for `gpt-image-1` and `gpt-image-1.5` and later models, unsupported for
      #   `gpt-image-1-mini`. Supports `high` and `low`. Defaults to `low`.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditParams::InputFidelity, nil]
      optional :input_fidelity, enum: -> { OpenAI::ImageEditParams::InputFidelity }, nil?: true

      # @!attribute mask
      #   An additional image whose fully transparent areas (e.g. where alpha is zero)
      #   indicate where `image` should be edited. If there are multiple images provided,
      #   the mask will be applied on the first image. Must be a valid PNG file, less than
      #   4MB, and have the same dimensions as `image`.
      #
      #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart, nil]
      optional :mask, OpenAI::Internal::Type::FileInput

      # @!attribute model
      #   The model to use for image generation. One of `dall-e-2` or a GPT image model
      #   (`gpt-image-1`, `gpt-image-1-mini`, `gpt-image-1.5`, `gpt-image-2`,
      #   `gpt-image-2-2026-04-21`, or `chatgpt-image-latest`). Defaults to
      #   `gpt-image-1.5`.
      #
      #   @return [String, Symbol, OpenAI::Models::ImageModel, nil]
      optional :model, union: -> { OpenAI::ImageEditParams::Model }, nil?: true

      # @!attribute n
      #   The number of images to generate. Must be between 1 and 10.
      #
      #   @return [Integer, nil]
      optional :n, Integer, nil?: true

      # @!attribute output_compression
      #   The compression level (0-100%) for the generated images. This parameter is only
      #   supported for the GPT image models with the `webp` or `jpeg` output formats, and
      #   defaults to 100.
      #
      #   @return [Integer, nil]
      optional :output_compression, Integer, nil?: true

      # @!attribute output_format
      #   The format in which the generated images are returned. This parameter is only
      #   supported for the GPT image models. Must be one of `png`, `jpeg`, or `webp`. The
      #   default value is `png`.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditParams::OutputFormat, nil]
      optional :output_format, enum: -> { OpenAI::ImageEditParams::OutputFormat }, nil?: true

      # @!attribute partial_images
      #   The number of partial images to generate. This parameter is used for streaming
      #   responses that return partial images. Value must be between 0 and 3. When set to
      #   0, the response will be a single image sent in one streaming event.
      #
      #   Note that the final image may be sent before the full number of partial images
      #   are generated if the full image is generated more quickly.
      #
      #   @return [Integer, nil]
      optional :partial_images, Integer, nil?: true

      # @!attribute quality
      #   The quality of the image that will be generated for GPT image models. Defaults
      #   to `auto`.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditParams::Quality, nil]
      optional :quality, enum: -> { OpenAI::ImageEditParams::Quality }, nil?: true

      # @!attribute response_format
      #   The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated. This parameter is only supported for `dall-e-2` (default is `url` for
      #   `dall-e-2`), as GPT image models always return base64-encoded images.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil]
      optional :response_format, enum: -> { OpenAI::ImageEditParams::ResponseFormat }, nil?: true

      # @!attribute size
      #   The size of the generated images. For `gpt-image-2` and
      #   `gpt-image-2-2026-04-21`, arbitrary resolutions are supported as `WIDTHxHEIGHT`
      #   strings, for example `1536x864`. Width and height must both be divisible by 16
      #   and the requested aspect ratio must be between 1:3 and 3:1. Resolutions above
      #   `2560x1440` are experimental, and the maximum supported resolution is
      #   `3840x2160`. The requested size must also satisfy the model's current pixel and
      #   edge limits. The standard sizes `1024x1024`, `1536x1024`, and `1024x1536` are
      #   supported by the GPT image models; `auto` is supported for models that allow
      #   automatic sizing. For `dall-e-2`, use one of `256x256`, `512x512`, or
      #   `1024x1024`. For `dall-e-3`, use one of `1024x1024`, `1792x1024`, or
      #   `1024x1792`.
      #
      #   @return [String, nil]
      optional :size, String, nil?: true

      # @!attribute user
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @return [String, nil]
      optional :user, String

      # @!method initialize(image:, prompt:, background: nil, input_fidelity: nil, mask: nil, model: nil, n: nil, output_compression: nil, output_format: nil, partial_images: nil, quality: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::ImageEditParams} for more details.
      #
      #   @param image [Pathname, StringIO, IO, String, OpenAI::FilePart, Array<Pathname, StringIO, IO, String, OpenAI::FilePart>] The image(s) to edit. Must be a supported image file or an array of images.
      #
      #   @param prompt [String] A text description of the desired image(s). The maximum length is 1000 character
      #
      #   @param background [Symbol, OpenAI::Models::ImageEditParams::Background, nil] Allows to set transparency for the background of the generated image(s).
      #
      #   @param input_fidelity [Symbol, OpenAI::Models::ImageEditParams::InputFidelity, nil] Control how much effort the model will exert to match the style and features, es
      #
      #   @param mask [Pathname, StringIO, IO, String, OpenAI::FilePart] An additional image whose fully transparent areas (e.g. where alpha is zero) ind
      #
      #   @param model [String, Symbol, OpenAI::Models::ImageModel, nil] The model to use for image generation. One of `dall-e-2` or a GPT image model (`
      #
      #   @param n [Integer, nil] The number of images to generate. Must be between 1 and 10.
      #
      #   @param output_compression [Integer, nil] The compression level (0-100%) for the generated images. This parameter
      #
      #   @param output_format [Symbol, OpenAI::Models::ImageEditParams::OutputFormat, nil] The format in which the generated images are returned. This parameter is
      #
      #   @param partial_images [Integer, nil] The number of partial images to generate. This parameter is used for
      #
      #   @param quality [Symbol, OpenAI::Models::ImageEditParams::Quality, nil] The quality of the image that will be generated for GPT image models. Defaults t
      #
      #   @param response_format [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil] The format in which the generated images are returned. Must be one of `url` or `
      #
      #   @param size [String, nil] The size of the generated images. For `gpt-image-2` and `gpt-image-2-2026-04-21`
      #
      #   @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # The image(s) to edit. Must be a supported image file or an array of images.
      #
      # For the GPT image models (`gpt-image-1`, `gpt-image-1-mini`, `gpt-image-1.5`,
      # `gpt-image-2`, `gpt-image-2-2026-04-21`, and `chatgpt-image-latest`), each image
      # should be a `png`, `webp`, or `jpg` file less than 50MB. You can provide up to
      # 16 images.
      #
      # For `dall-e-2`, you can only provide one image, and it should be a square `png`
      # file less than 4MB.
      module Image
        extend OpenAI::Internal::Type::Union

        variant OpenAI::Internal::Type::FileInput

        variant -> { OpenAI::Models::ImageEditParams::Image::StringArray }

        # @!method self.variants
        #   @return [Array(StringIO, Array<StringIO>)]

        # @type [OpenAI::Internal::Type::Converter]
        StringArray = OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::FileInput]
      end

      # Allows to set transparency for the background of the generated image(s). This
      # parameter is only supported for GPT image models that support transparent
      # backgrounds. Must be one of `transparent`, `opaque`, or `auto` (default value).
      # When `auto` is used, the model will automatically determine the best background
      # for the image.
      #
      # `gpt-image-2` and `gpt-image-2-2026-04-21` do not support transparent
      # backgrounds. Requests with `background` set to `transparent` will return an
      # error for these models; use `opaque` or `auto` instead.
      #
      # If `transparent`, the output format needs to support transparency, so it should
      # be set to either `png` (default value) or `webp`.
      module Background
        extend OpenAI::Internal::Type::Enum

        TRANSPARENT = :transparent
        OPAQUE = :opaque
        AUTO = :auto

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # Control how much effort the model will exert to match the style and features,
      # especially facial features, of input images. This parameter is only supported
      # for `gpt-image-1` and `gpt-image-1.5` and later models, unsupported for
      # `gpt-image-1-mini`. Supports `high` and `low`. Defaults to `low`.
      module InputFidelity
        extend OpenAI::Internal::Type::Enum

        HIGH = :high
        LOW = :low

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The model to use for image generation. One of `dall-e-2` or a GPT image model
      # (`gpt-image-1`, `gpt-image-1-mini`, `gpt-image-1.5`, `gpt-image-2`,
      # `gpt-image-2-2026-04-21`, or `chatgpt-image-latest`). Defaults to
      # `gpt-image-1.5`.
      module Model
        extend OpenAI::Internal::Type::Union

        variant String

        # The model to use for image generation. One of `dall-e-2` or a GPT image model (`gpt-image-1`, `gpt-image-1-mini`, `gpt-image-1.5`, `gpt-image-2`, `gpt-image-2-2026-04-21`, or `chatgpt-image-latest`). Defaults to `gpt-image-1.5`.
        variant enum: -> { OpenAI::ImageModel }

        # @!method self.variants
        #   @return [Array(String, Symbol, OpenAI::Models::ImageModel)]
      end

      # The format in which the generated images are returned. This parameter is only
      # supported for the GPT image models. Must be one of `png`, `jpeg`, or `webp`. The
      # default value is `png`.
      module OutputFormat
        extend OpenAI::Internal::Type::Enum

        PNG = :png
        JPEG = :jpeg
        WEBP = :webp

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The quality of the image that will be generated for GPT image models. Defaults
      # to `auto`.
      module Quality
        extend OpenAI::Internal::Type::Enum

        STANDARD = :standard
        LOW = :low
        MEDIUM = :medium
        HIGH = :high
        AUTO = :auto

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The format in which the generated images are returned. Must be one of `url` or
      # `b64_json`. URLs are only valid for 60 minutes after the image has been
      # generated. This parameter is only supported for `dall-e-2` (default is `url` for
      # `dall-e-2`), as GPT image models always return base64-encoded images.
      module ResponseFormat
        extend OpenAI::Internal::Type::Enum

        URL = :url
        B64_JSON = :b64_json

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
