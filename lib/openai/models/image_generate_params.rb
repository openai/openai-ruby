# frozen_string_literal: true

module OpenAI
  module Models
    class ImageGenerateParams < OpenAI::BaseModel
      # @!parse
      #   extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # @!attribute prompt
      #   A text description of the desired image(s). The maximum length is 1000
      #     characters for `dall-e-2` and 4000 characters for `dall-e-3`.
      #
      #   @return [String]
      required :prompt, String

      # @!attribute model
      #   The model to use for image generation.
      #
      #   @return [String, Symbol, OpenAI::Models::ImageModel, nil]
      optional :model, union: -> { OpenAI::Models::ImageGenerateParams::Model }, nil?: true

      # @!attribute n
      #   The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
      #     `n=1` is supported.
      #
      #   @return [Integer, nil]
      optional :n, Integer, nil?: true

      # @!attribute [r] quality
      #   The quality of the image that will be generated. `hd` creates images with finer
      #     details and greater consistency across the image. This param is only supported
      #     for `dall-e-3`.
      #
      #   @return [Symbol, OpenAI::Models::ImageGenerateParams::Quality, nil]
      optional :quality, enum: -> { OpenAI::Models::ImageGenerateParams::Quality }

      # @!parse
      #   # @return [Symbol, OpenAI::Models::ImageGenerateParams::Quality]
      #   attr_writer :quality

      # @!attribute response_format
      #   The format in which the generated images are returned. Must be one of `url` or
      #     `b64_json`. URLs are only valid for 60 minutes after the image has been
      #     generated.
      #
      #   @return [Symbol, OpenAI::Models::ImageGenerateParams::ResponseFormat, nil]
      optional :response_format, enum: -> { OpenAI::Models::ImageGenerateParams::ResponseFormat }, nil?: true

      # @!attribute size
      #   The size of the generated images. Must be one of `256x256`, `512x512`, or
      #     `1024x1024` for `dall-e-2`. Must be one of `1024x1024`, `1792x1024`, or
      #     `1024x1792` for `dall-e-3` models.
      #
      #   @return [Symbol, OpenAI::Models::ImageGenerateParams::Size, nil]
      optional :size, enum: -> { OpenAI::Models::ImageGenerateParams::Size }, nil?: true

      # @!attribute style
      #   The style of the generated images. Must be one of `vivid` or `natural`. Vivid
      #     causes the model to lean towards generating hyper-real and dramatic images.
      #     Natural causes the model to produce more natural, less hyper-real looking
      #     images. This param is only supported for `dall-e-3`.
      #
      #   @return [Symbol, OpenAI::Models::ImageGenerateParams::Style, nil]
      optional :style, enum: -> { OpenAI::Models::ImageGenerateParams::Style }, nil?: true

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
      #   # @param prompt [String]
      #   # @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      #   # @param n [Integer, nil]
      #   # @param quality [Symbol, OpenAI::Models::ImageGenerateParams::Quality]
      #   # @param response_format [Symbol, OpenAI::Models::ImageGenerateParams::ResponseFormat, nil]
      #   # @param size [Symbol, OpenAI::Models::ImageGenerateParams::Size, nil]
      #   # @param style [Symbol, OpenAI::Models::ImageGenerateParams::Style, nil]
      #   # @param user [String]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(
      #     prompt:,
      #     model: nil,
      #     n: nil,
      #     quality: nil,
      #     response_format: nil,
      #     size: nil,
      #     style: nil,
      #     user: nil,
      #     request_options: {},
      #     **
      #   )
      #     super
      #   end

      # def initialize: (Hash | OpenAI::BaseModel) -> void

      # @abstract
      #
      # The model to use for image generation.
      class Model < OpenAI::Union
        variant String

        # The model to use for image generation.
        variant enum: -> { OpenAI::Models::ImageModel }
      end

      # @abstract
      #
      # The quality of the image that will be generated. `hd` creates images with finer
      #   details and greater consistency across the image. This param is only supported
      #   for `dall-e-3`.
      class Quality < OpenAI::Enum
        STANDARD = :standard
        HD = :hd

        finalize!
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
      #   `1024x1024` for `dall-e-2`. Must be one of `1024x1024`, `1792x1024`, or
      #   `1024x1792` for `dall-e-3` models.
      class Size < OpenAI::Enum
        NUMBER_256X256 = :"256x256"
        NUMBER_512X512 = :"512x512"
        NUMBER_1024X1024 = :"1024x1024"
        NUMBER_1792X1024 = :"1792x1024"
        NUMBER_1024X1792 = :"1024x1792"

        finalize!
      end

      # @abstract
      #
      # The style of the generated images. Must be one of `vivid` or `natural`. Vivid
      #   causes the model to lean towards generating hyper-real and dramatic images.
      #   Natural causes the model to produce more natural, less hyper-real looking
      #   images. This param is only supported for `dall-e-3`.
      class Style < OpenAI::Enum
        VIVID = :vivid
        NATURAL = :natural

        finalize!
      end
    end
  end
end
