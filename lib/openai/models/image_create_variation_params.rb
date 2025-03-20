# frozen_string_literal: true

module OpenAI
  module Models
    class ImageCreateVariationParams < OpenAI::BaseModel
      # @!parse
      #   extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # @!attribute image
      #   The image to use as the basis for the variation(s). Must be a valid PNG file,
      #     less than 4MB, and square.
      #
      #   @return [IO, StringIO]
      required :image, IO

      # @!attribute model
      #   The model to use for image generation. Only `dall-e-2` is supported at this
      #     time.
      #
      #   @return [String, Symbol, OpenAI::Models::ImageModel, nil]
      optional :model, union: -> { OpenAI::Models::ImageCreateVariationParams::Model }, nil?: true

      # @!attribute n
      #   The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
      #     `n=1` is supported.
      #
      #   @return [Integer, nil]
      optional :n, Integer, nil?: true

      # @!attribute response_format
      #   The format in which the generated images are returned. Must be one of `url` or
      #     `b64_json`. URLs are only valid for 60 minutes after the image has been
      #     generated.
      #
      #   @return [Symbol, OpenAI::Models::ImageCreateVariationParams::ResponseFormat, nil]
      optional :response_format,
               enum: -> { OpenAI::Models::ImageCreateVariationParams::ResponseFormat },
               nil?: true

      # @!attribute size
      #   The size of the generated images. Must be one of `256x256`, `512x512`, or
      #     `1024x1024`.
      #
      #   @return [Symbol, OpenAI::Models::ImageCreateVariationParams::Size, nil]
      optional :size, enum: -> { OpenAI::Models::ImageCreateVariationParams::Size }, nil?: true

      # @!attribute [r] user
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #     and detect abuse.
      #     [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      #
      #   @return [String, nil]
      optional :user, String

      # @!parse
      #   # @return [String]
      #   attr_writer :user

      # @!parse
      #   # @param image [IO, StringIO]
      #   # @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      #   # @param n [Integer, nil]
      #   # @param response_format [Symbol, OpenAI::Models::ImageCreateVariationParams::ResponseFormat, nil]
      #   # @param size [Symbol, OpenAI::Models::ImageCreateVariationParams::Size, nil]
      #   # @param user [String]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(image:, model: nil, n: nil, response_format: nil, size: nil, user: nil, request_options: {}, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void

      # @abstract
      #
      # The model to use for image generation. Only `dall-e-2` is supported at this
      #   time.
      class Model < OpenAI::Union
        variant String

        # The model to use for image generation. Only `dall-e-2` is supported at this time.
        variant enum: -> { OpenAI::Models::ImageModel }

        # @!parse
        #   class << self
        #     # @return [Array(String, Symbol, OpenAI::Models::ImageModel)]
        #     def variants; end
        #   end
      end

      # @abstract
      #
      # The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      class ResponseFormat < OpenAI::Enum
        URL = :url
        B64_JSON = :b64_json

        finalize!
      end

      # @abstract
      #
      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024`.
      class Size < OpenAI::Enum
        NUMBER_256X256 = :"256x256"
        NUMBER_512X512 = :"512x512"
        NUMBER_1024X1024 = :"1024x1024"

        finalize!
      end
    end
  end
end
