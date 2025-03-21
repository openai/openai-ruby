# frozen_string_literal: true

module OpenAI
  module Models
    class ImageEditParams < OpenAI::BaseModel
      # @!parse
      #   extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # @!attribute image
      #   The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask
      #     is not provided, image must have transparency, which will be used as the mask.
      #
      #   @return [IO, StringIO]
      required :image, IO

      # @!attribute prompt
      #   A text description of the desired image(s). The maximum length is 1000
      #     characters.
      #
      #   @return [String]
      required :prompt, String

      # @!attribute [r] mask
      #   An additional image whose fully transparent areas (e.g. where alpha is zero)
      #     indicate where `image` should be edited. Must be a valid PNG file, less than
      #     4MB, and have the same dimensions as `image`.
      #
      #   @return [IO, StringIO, nil]
      optional :mask, IO

      # @!parse
      #   # @return [IO, StringIO]
      #   attr_writer :mask

      # @!attribute model
      #   The model to use for image generation. Only `dall-e-2` is supported at this
      #     time.
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
      #     `b64_json`. URLs are only valid for 60 minutes after the image has been
      #     generated.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil]
      optional :response_format, enum: -> { OpenAI::Models::ImageEditParams::ResponseFormat }, nil?: true

      # @!attribute size
      #   The size of the generated images. Must be one of `256x256`, `512x512`, or
      #     `1024x1024`.
      #
      #   @return [Symbol, OpenAI::Models::ImageEditParams::Size, nil]
      optional :size, enum: -> { OpenAI::Models::ImageEditParams::Size }, nil?: true

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
      #   # @param prompt [String]
      #   # @param mask [IO, StringIO]
      #   # @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      #   # @param n [Integer, nil]
      #   # @param response_format [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil]
      #   # @param size [Symbol, OpenAI::Models::ImageEditParams::Size, nil]
      #   # @param user [String]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(
      #     image:,
      #     prompt:,
      #     mask: nil,
      #     model: nil,
      #     n: nil,
      #     response_format: nil,
      #     size: nil,
      #     user: nil,
      #     request_options: {},
      #     **
      #   )
      #     super
      #   end

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

        NUMBER_256X256 = :"256x256"
        NUMBER_512X512 = :"512x512"
        NUMBER_1024X1024 = :"1024x1024"

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end
    end
  end
end
