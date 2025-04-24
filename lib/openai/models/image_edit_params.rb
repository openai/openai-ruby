# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Images#edit
    class ImageEditParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute image
      #   The image(s) to edit. Must be a supported image file or an array of images. For
      #   `gpt-image-1`, each image should be a `png`, `webp`, or `jpg` file less than
      #   25MB. For `dall-e-2`, you can only provide one image, and it should be a square
      #   `png` file less than 4MB.
      #
      #   @return [Pathname, StringIO, Array<Pathname, StringIO>]
      required :image, union: -> { OpenAI::Models::ImageEditParams::Image }

      # @!attribute prompt
      #   A text description of the desired image(s). The maximum length is 1000
      #   characters for `dall-e-2`, and 32000 characters for `gpt-image-1`.
      #
      #   @return [String]
      required :prompt, String

      # @!attribute mask
      #   An additional image whose fully transparent areas (e.g. where alpha is zero)
      #   indicate where `image` should be edited. If there are multiple images provided,
      #   the mask will be applied on the first image. Must be a valid PNG file, less than
      #   4MB, and have the same dimensions as `image`.
      #
      #   @return [Pathname, StringIO, nil]
      optional :mask, OpenAI::Internal::Type::IOLike

      # @!attribute model
      #   The model to use for image generation. Only `dall-e-2` and `gpt-image-1` are
      #   supported. Defaults to `dall-e-2` unless a parameter specific to `gpt-image-1`
      #   is used.
      #
      #   @return [String, Symbol, OpenAI::Models::ImageModel, nil]
      optional :model, union: -> { OpenAI::Models::ImageEditParams::Model }, nil?: true

      # @!attribute n
      #   The number of images to generate. Must be between 1 and 10.
      #
      #   @return [Integer, nil]
      optional :n, Integer, nil?: true

      # @!attribute quality
      #   The quality of the image that will be generated. `high`, `medium` and `low` are
      #   only supported for `gpt-image-1`. `dall-e-2` only supports `standard` quality.
      #   Defaults to `auto`.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditParams::Quality, nil]
      optional :quality, enum: -> { OpenAI::Models::ImageEditParams::Quality }, nil?: true

      # @!attribute response_format
      #   The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated. This parameter is only supported for `dall-e-2`, as `gpt-image-1`
      #   will always return base64-encoded images.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil]
      optional :response_format, enum: -> { OpenAI::Models::ImageEditParams::ResponseFormat }, nil?: true

      # @!attribute size
      #   The size of the generated images. Must be one of `1024x1024`, `1536x1024`
      #   (landscape), `1024x1536` (portrait), or `auto` (default value) for
      #   `gpt-image-1`, and one of `256x256`, `512x512`, or `1024x1024` for `dall-e-2`.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditParams::Size, nil]
      optional :size, enum: -> { OpenAI::Models::ImageEditParams::Size }, nil?: true

      # @!attribute user
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @return [String, nil]
      optional :user, String

      # @!method initialize(image:, prompt:, mask: nil, model: nil, n: nil, quality: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::ImageEditParams} for more details.
      #
      #   @param image [Pathname, StringIO, Array<Pathname, StringIO>] The image(s) to edit. Must be a supported image file or an array of images. For
      #   ...
      #
      #   @param prompt [String] A text description of the desired image(s). The maximum length is 1000 character
      #   ...
      #
      #   @param mask [Pathname, StringIO] An additional image whose fully transparent areas (e.g. where alpha is zero) ind
      #   ...
      #
      #   @param model [String, Symbol, OpenAI::Models::ImageModel, nil] The model to use for image generation. Only `dall-e-2` and `gpt-image-1` are sup
      #   ...
      #
      #   @param n [Integer, nil] The number of images to generate. Must be between 1 and 10.
      #
      #   @param quality [Symbol, OpenAI::Models::ImageEditParams::Quality, nil] The quality of the image that will be generated. `high`, `medium` and `low` are
      #   ...
      #
      #   @param response_format [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil] The format in which the generated images are returned. Must be one of `url` or `
      #   ...
      #
      #   @param size [Symbol, OpenAI::Models::ImageEditParams::Size, nil] The size of the generated images. Must be one of `1024x1024`, `1536x1024` (lands
      #   ...
      #
      #   @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      #   ...
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # The image(s) to edit. Must be a supported image file or an array of images. For
      # `gpt-image-1`, each image should be a `png`, `webp`, or `jpg` file less than
      # 25MB. For `dall-e-2`, you can only provide one image, and it should be a square
      # `png` file less than 4MB.
      module Image
        extend OpenAI::Internal::Type::Union

        variant OpenAI::Internal::Type::IOLike

        variant -> { OpenAI::Models::ImageEditParams::Image::StringArray }

        # @!method self.variants
        #   @return [Array(StringIO, Array<StringIO>)]

        StringArray = OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::IOLike]
      end

      # The model to use for image generation. Only `dall-e-2` and `gpt-image-1` are
      # supported. Defaults to `dall-e-2` unless a parameter specific to `gpt-image-1`
      # is used.
      module Model
        extend OpenAI::Internal::Type::Union

        variant String

        # The model to use for image generation. Only `dall-e-2` and `gpt-image-1` are supported. Defaults to `dall-e-2` unless a parameter specific to `gpt-image-1` is used.
        variant enum: -> { OpenAI::Models::ImageModel }

        # @!method self.variants
        #   @return [Array(String, Symbol, OpenAI::Models::ImageModel)]
      end

      # The quality of the image that will be generated. `high`, `medium` and `low` are
      # only supported for `gpt-image-1`. `dall-e-2` only supports `standard` quality.
      # Defaults to `auto`.
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
      # generated. This parameter is only supported for `dall-e-2`, as `gpt-image-1`
      # will always return base64-encoded images.
      module ResponseFormat
        extend OpenAI::Internal::Type::Enum

        URL = :url
        B64_JSON = :b64_json

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The size of the generated images. Must be one of `1024x1024`, `1536x1024`
      # (landscape), `1024x1536` (portrait), or `auto` (default value) for
      # `gpt-image-1`, and one of `256x256`, `512x512`, or `1024x1024` for `dall-e-2`.
      module Size
        extend OpenAI::Internal::Type::Enum

        SIZE_256X256 = :"256x256"
        SIZE_512X512 = :"512x512"
        SIZE_1024X1024 = :"1024x1024"

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
