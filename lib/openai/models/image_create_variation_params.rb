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
      #   @return [Pathname, StringIO]
      required :image, OpenAI::Internal::Type::IOLike

      # @!attribute model
      #   The model to use for image generation. Only `dall-e-2` is supported at this
      #   time.
      #
      #   @return [String, Symbol, OpenAI::Models::ImageModel, nil]
      optional :model, union: -> { OpenAI::Models::ImageCreateVariationParams::Model }, nil?: true

      # @!attribute n
      #   The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
      #   `n=1` is supported.
      #
      #   @return [Integer, nil]
      optional :n, Integer, nil?: true

      # @!attribute response_format
      #   The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      #
      #   @return [Symbol, OpenAI::Models::ImageCreateVariationParams::ResponseFormat, nil]
      optional :response_format,
               enum: -> { OpenAI::Models::ImageCreateVariationParams::ResponseFormat },
               nil?: true

      # @!attribute size
      #   The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024`.
      #
      #   @return [Symbol, OpenAI::Models::ImageCreateVariationParams::Size, nil]
      optional :size, enum: -> { OpenAI::Models::ImageCreateVariationParams::Size }, nil?: true

      # @!attribute user
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @return [String, nil]
      optional :user, String

      # @!method initialize(image:, model: nil, n: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #   @param image [Pathname, StringIO]
      #   @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      #   @param n [Integer, nil]
      #   @param response_format [Symbol, OpenAI::Models::ImageCreateVariationParams::ResponseFormat, nil]
      #   @param size [Symbol, OpenAI::Models::ImageCreateVariationParams::Size, nil]
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
