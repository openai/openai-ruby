# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Images#create_variation
    class ImageCreateVariationParams < OpenAI::BaseModel
      # @!parse
      #   extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

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

      # The model to use for image generation. Only `dall-e-2` is supported at this
      #   time.
      module Model
        extend OpenAI::Union

        variant String

        # The model to use for image generation. Only `dall-e-2` is supported at this time.
        variant enum: -> { OpenAI::Models::ImageModel }

        # @!parse
        #   # @return [Array(String, Symbol, OpenAI::Models::ImageModel)]
        #   def self.variants; end
      end

      # The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      module ResponseFormat
        extend OpenAI::Enum

        URL = :url
        B64_JSON = :b64_json

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024`.
      module Size
        extend OpenAI::Enum

        SIZE_256X256 = :"256x256"
        SIZE_512X512 = :"512x512"
        SIZE_1024X1024 = :"1024x1024"

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end
    end
  end
end
