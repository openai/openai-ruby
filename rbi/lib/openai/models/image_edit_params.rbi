# typed: strong

module OpenAI
  module Models
    class ImageEditParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask
      # is not provided, image must have transparency, which will be used as the mask.
      sig { returns(T.any(Pathname, StringIO)) }
      attr_accessor :image

      # A text description of the desired image(s). The maximum length is 1000
      # characters.
      sig { returns(String) }
      attr_accessor :prompt

      # An additional image whose fully transparent areas (e.g. where alpha is zero)
      # indicate where `image` should be edited. Must be a valid PNG file, less than
      # 4MB, and have the same dimensions as `image`.
      sig { returns(T.nilable(T.any(Pathname, StringIO))) }
      attr_reader :mask

      sig { params(mask: T.any(Pathname, StringIO)).void }
      attr_writer :mask

      # The model to use for image generation. Only `dall-e-2` is supported at this
      # time.
      sig { returns(T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol))) }
      attr_accessor :model

      # The number of images to generate. Must be between 1 and 10.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :n

      # The format in which the generated images are returned. Must be one of `url` or
      # `b64_json`. URLs are only valid for 60 minutes after the image has been
      # generated.
      sig { returns(T.nilable(OpenAI::Models::ImageEditParams::ResponseFormat::OrSymbol)) }
      attr_accessor :response_format

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      # `1024x1024`.
      sig { returns(T.nilable(OpenAI::Models::ImageEditParams::Size::OrSymbol)) }
      attr_accessor :size

      # A unique identifier representing your end-user, which can help OpenAI to monitor
      # and detect abuse.
      # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      sig { returns(T.nilable(String)) }
      attr_reader :user

      sig { params(user: String).void }
      attr_writer :user

      sig do
        params(
          image: T.any(Pathname, StringIO),
          prompt: String,
          mask: T.any(Pathname, StringIO),
          model: T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol)),
          n: T.nilable(Integer),
          response_format: T.nilable(OpenAI::Models::ImageEditParams::ResponseFormat::OrSymbol),
          size: T.nilable(OpenAI::Models::ImageEditParams::Size::OrSymbol),
          user: String,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(
        image:,
        prompt:,
        mask: nil,
        model: nil,
        n: nil,
        response_format: nil,
        size: nil,
        user: nil,
        request_options: {}
      ); end
      sig do
        override
          .returns(
            {
              image: T.any(Pathname, StringIO),
              prompt: String,
              mask: T.any(Pathname, StringIO),
              model: T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol)),
              n: T.nilable(Integer),
              response_format: T.nilable(OpenAI::Models::ImageEditParams::ResponseFormat::OrSymbol),
              size: T.nilable(OpenAI::Models::ImageEditParams::Size::OrSymbol),
              user: String,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash; end

      # The model to use for image generation. Only `dall-e-2` is supported at this
      # time.
      module Model
        extend OpenAI::Internal::Type::Union

        sig { override.returns([String, OpenAI::Models::ImageModel::TaggedSymbol]) }
        def self.variants; end
      end

      # The format in which the generated images are returned. Must be one of `url` or
      # `b64_json`. URLs are only valid for 60 minutes after the image has been
      # generated.
      module ResponseFormat
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ImageEditParams::ResponseFormat) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        URL = T.let(:url, OpenAI::Models::ImageEditParams::ResponseFormat::TaggedSymbol)
        B64_JSON = T.let(:b64_json, OpenAI::Models::ImageEditParams::ResponseFormat::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::ImageEditParams::ResponseFormat::TaggedSymbol]) }
        def self.values; end
      end

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      # `1024x1024`.
      module Size
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ImageEditParams::Size) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        SIZE_256X256 = T.let(:"256x256", OpenAI::Models::ImageEditParams::Size::TaggedSymbol)
        SIZE_512X512 = T.let(:"512x512", OpenAI::Models::ImageEditParams::Size::TaggedSymbol)
        SIZE_1024X1024 = T.let(:"1024x1024", OpenAI::Models::ImageEditParams::Size::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::ImageEditParams::Size::TaggedSymbol]) }
        def self.values; end
      end
    end
  end
end
