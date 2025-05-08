# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Images#create_variation
    class ImageCreateVariationParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute image
      #   The image to use as the basis for the variation(s). Must be a valid PNG file,
      #   less than 4MB, and square.
      #
      #   @return [Pathname, StringIO, IO, OpenAI::FilePart]
      required :image, OpenAI::Internal::Type::FileInput

      # @!attribute model
      #   The model to use for image generation. Only `dall-e-2` is supported at this
      #   time.
      #
      #   @return [String, Symbol, OpenAI::ImageModel, nil]
      optional :model, union: -> { OpenAI::ImageCreateVariationParams::Model }, nil?: true

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
      #   @return [Symbol, OpenAI::ImageCreateVariationParams::ResponseFormat, nil]
      optional :response_format, enum: -> { OpenAI::ImageCreateVariationParams::ResponseFormat }, nil?: true

      # @!attribute size
      #   The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024`.
      #
      #   @return [Symbol, OpenAI::ImageCreateVariationParams::Size, nil]
      optional :size, enum: -> { OpenAI::ImageCreateVariationParams::Size }, nil?: true

      # @!attribute user
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @return [String, nil]
      optional :user, String

      # @!method initialize(image:, model: nil, n: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::ImageCreateVariationParams} for more details.
      #
      #   @param image [Pathname, StringIO, IO, OpenAI::FilePart] The image to use as the basis for the variation(s). Must be a valid PNG file, le
      #
      #   @param model [String, Symbol, OpenAI::ImageModel, nil] The model to use for image generation. Only `dall-e-2` is supported at this time
      #
      #   @param n [Integer, nil] The number of images to generate. Must be between 1 and 10.
      #
      #   @param response_format [Symbol, OpenAI::ImageCreateVariationParams::ResponseFormat, nil] The format in which the generated images are returned. Must be one of `url` or `
      #
      #   @param size [Symbol, OpenAI::ImageCreateVariationParams::Size, nil] The size of the generated images. Must be one of `256x256`, `512x512`, or `1024x
      #
      #   @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # The model to use for image generation. Only `dall-e-2` is supported at this
      # time.
      module Model
        extend OpenAI::Internal::Type::Union

        variant String

        # The model to use for image generation. Only `dall-e-2` is supported at this time.
        variant enum: -> { OpenAI::ImageModel }

        # @!method self.variants
        #   @return [Array(String, Symbol, OpenAI::ImageModel)]
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
