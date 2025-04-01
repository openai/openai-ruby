# typed: strong

module OpenAI
  module Models
    class ImageCreateVariationParams < OpenAI::BaseModel
      extend OpenAI::Type::RequestParameters::Converter
      include OpenAI::RequestParameters

      # The image to use as the basis for the variation(s). Must be a valid PNG file,
      #   less than 4MB, and square.
      sig { returns(T.any(IO, StringIO)) }
      attr_accessor :image

      # The model to use for image generation. Only `dall-e-2` is supported at this
      #   time.
      sig { returns(T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol))) }
      attr_accessor :model

      # The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
      #   `n=1` is supported.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :n

      # The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      sig { returns(T.nilable(OpenAI::Models::ImageCreateVariationParams::ResponseFormat::OrSymbol)) }
      attr_accessor :response_format

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024`.
      sig { returns(T.nilable(OpenAI::Models::ImageCreateVariationParams::Size::OrSymbol)) }
      attr_accessor :size

      # A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      sig { returns(T.nilable(String)) }
      attr_reader :user

      sig { params(user: String).void }
      attr_writer :user

      sig do
        params(
          image: T.any(IO, StringIO),
          model: T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol)),
          n: T.nilable(Integer),
          response_format: T.nilable(OpenAI::Models::ImageCreateVariationParams::ResponseFormat::OrSymbol),
          size: T.nilable(OpenAI::Models::ImageCreateVariationParams::Size::OrSymbol),
          user: String,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(
        image:,
        model: nil,
        n: nil,
        response_format: nil,
        size: nil,
        user: nil,
        request_options: {}
      )
      end

      sig do
        override
          .returns(
            {
              image: T.any(IO, StringIO),
              model: T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol)),
              n: T.nilable(Integer),
              response_format: T.nilable(OpenAI::Models::ImageCreateVariationParams::ResponseFormat::OrSymbol),
              size: T.nilable(OpenAI::Models::ImageCreateVariationParams::Size::OrSymbol),
              user: String,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      # The model to use for image generation. Only `dall-e-2` is supported at this
      #   time.
      module Model
        extend OpenAI::Union

        sig { override.returns([String, OpenAI::Models::ImageModel::OrSymbol]) }
        def self.variants
        end
      end

      # The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      module ResponseFormat
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ImageCreateVariationParams::ResponseFormat) }
        OrSymbol =
          T.type_alias { T.any(Symbol, OpenAI::Models::ImageCreateVariationParams::ResponseFormat::TaggedSymbol) }

        URL = T.let(:url, OpenAI::Models::ImageCreateVariationParams::ResponseFormat::TaggedSymbol)
        B64_JSON = T.let(:b64_json, OpenAI::Models::ImageCreateVariationParams::ResponseFormat::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::ImageCreateVariationParams::ResponseFormat::TaggedSymbol]) }
        def self.values
        end
      end

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024`.
      module Size
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ImageCreateVariationParams::Size) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::ImageCreateVariationParams::Size::TaggedSymbol) }

        NUMBER_256X256 = T.let(:"256x256", OpenAI::Models::ImageCreateVariationParams::Size::TaggedSymbol)
        NUMBER_512X512 = T.let(:"512x512", OpenAI::Models::ImageCreateVariationParams::Size::TaggedSymbol)
        NUMBER_1024X1024 = T.let(:"1024x1024", OpenAI::Models::ImageCreateVariationParams::Size::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::ImageCreateVariationParams::Size::TaggedSymbol]) }
        def self.values
        end
      end
    end
  end
end
