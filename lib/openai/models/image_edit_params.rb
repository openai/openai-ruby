# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Images#edit
    class ImageEditParams < OpenAI::Internal::Type::BaseModel
      # @!parse
      #   extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute image
      #   The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask
      #   is not provided, image must have transparency, which will be used as the mask.
      #
      #   @return [Pathname, StringIO]
      required :image, OpenAI::Internal::Type::IOLike

      # @!attribute prompt
      #   A text description of the desired image(s). The maximum length is 1000
      #   characters.
      #
      #   @return [String]
      required :prompt, String

      # @!attribute [r] mask
      #   An additional image whose fully transparent areas (e.g. where alpha is zero)
      #   indicate where `image` should be edited. Must be a valid PNG file, less than
      #   4MB, and have the same dimensions as `image`.
      #
      #   @return [Pathname, StringIO, nil]
      optional :mask, OpenAI::Internal::Type::IOLike

      # @!parse
      #   # @return [Pathname, StringIO]
      #   attr_writer :mask

      # @!attribute model
      #   The model to use for image generation. Only `dall-e-2` is supported at this
      #   time.
      #
      #   @return [String, Symbol, OpenAI::Models::ImageModel, nil]
      optional :model, union: -> { OpenAI::Models::ImageEditParams::Model }, nil?: true

      # @!attribute n
      #   The number of images to generate. Must be between 1 and 10.
      #
      #   @return [Integer, nil]
      optional :n, Integer, nil?: true

      # @!attribute response_format
      #   The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil]
      optional :response_format, enum: -> { OpenAI::Models::ImageEditParams::ResponseFormat }, nil?: true

      # @!attribute size
      #   The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024`.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditParams::Size, nil]
      optional :size, enum: -> { OpenAI::Models::ImageEditParams::Size }, nil?: true

      # @!attribute [r] user
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @return [String, nil]
      optional :user, String

      # @!parse
      #   # @return [String]
      #   attr_writer :user

      # @!method initialize(image:, prompt:, mask: nil, model: nil, n: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #   @param image [Pathname, StringIO]
      #   @param prompt [String]
      #   @param mask [Pathname, StringIO]
      #   @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      #   @param n [Integer, nil]
      #   @param response_format [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil]
      #   @param size [Symbol, OpenAI::Models::ImageEditParams::Size, nil]
      #   @param user [String]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # The model to use for image generation. Only `dall-e-2` is supported at this
      # time.
      module Model
        extend OpenAI::Internal::Type::Union

        variant String

        # The model to use for image generation. Only `dall-e-2` is supported at this time.
        variant enum: -> { OpenAI::Models::ImageModel }

        # @!method self.variants
        #   @return [Array(String, Symbol, OpenAI::Models::ImageModel)]
      end

      # The format in which the generated images are returned. Must be one of `url` or
      # `b64_json`. URLs are only valid for 60 minutes after the image has been
      # generated.
      module ResponseFormat
        extend OpenAI::Internal::Type::Enum

        URL = :url
        B64_JSON = :b64_json

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      # `1024x1024`.
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
