# typed: strong

module OpenAI
  module Models
    class ImageEditParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask
      #   is not provided, image must have transparency, which will be used as the mask.
      sig { returns(T.any(IO, StringIO)) }
      def image
      end

      sig { params(_: T.any(IO, StringIO)).returns(T.any(IO, StringIO)) }
      def image=(_)
      end

      # A text description of the desired image(s). The maximum length is 1000
      #   characters.
      sig { returns(String) }
      def prompt
      end

      sig { params(_: String).returns(String) }
      def prompt=(_)
      end

      # An additional image whose fully transparent areas (e.g. where alpha is zero)
      #   indicate where `image` should be edited. Must be a valid PNG file, less than
      #   4MB, and have the same dimensions as `image`.
      sig { returns(T.nilable(T.any(IO, StringIO))) }
      def mask
      end

      sig { params(_: T.any(IO, StringIO)).returns(T.any(IO, StringIO)) }
      def mask=(_)
      end

      # The model to use for image generation. Only `dall-e-2` is supported at this
      #   time.
      sig { returns(T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol))) }
      def model
      end

      sig do
        params(_: T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol)))
          .returns(T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol)))
      end
      def model=(_)
      end

      # The number of images to generate. Must be between 1 and 10.
      sig { returns(T.nilable(Integer)) }
      def n
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def n=(_)
      end

      # The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      sig { returns(T.nilable(OpenAI::Models::ImageEditParams::ResponseFormat::OrSymbol)) }
      def response_format
      end

      sig do
        params(_: T.nilable(OpenAI::Models::ImageEditParams::ResponseFormat::OrSymbol))
          .returns(T.nilable(OpenAI::Models::ImageEditParams::ResponseFormat::OrSymbol))
      end
      def response_format=(_)
      end

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024`.
      sig { returns(T.nilable(OpenAI::Models::ImageEditParams::Size::OrSymbol)) }
      def size
      end

      sig do
        params(_: T.nilable(OpenAI::Models::ImageEditParams::Size::OrSymbol))
          .returns(T.nilable(OpenAI::Models::ImageEditParams::Size::OrSymbol))
      end
      def size=(_)
      end

      # A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      sig { returns(T.nilable(String)) }
      def user
      end

      sig { params(_: String).returns(String) }
      def user=(_)
      end

      sig do
        params(
          image: T.any(IO, StringIO),
          prompt: String,
          mask: T.any(IO, StringIO),
          model: T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol)),
          n: T.nilable(Integer),
          response_format: T.nilable(OpenAI::Models::ImageEditParams::ResponseFormat::OrSymbol),
          size: T.nilable(OpenAI::Models::ImageEditParams::Size::OrSymbol),
          user: String,
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
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
      )
      end

      sig do
        override
          .returns(
            {
              image: T.any(IO, StringIO),
              prompt: String,
              mask: T.any(IO, StringIO),
              model: T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol)),
              n: T.nilable(Integer),
              response_format: T.nilable(OpenAI::Models::ImageEditParams::ResponseFormat::OrSymbol),
              size: T.nilable(OpenAI::Models::ImageEditParams::Size::OrSymbol),
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

        Variants = type_template(:out) { {fixed: T.any(String, OpenAI::Models::ImageModel::OrSymbol)} }
      end

      # The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      module ResponseFormat
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ImageEditParams::ResponseFormat) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::ImageEditParams::ResponseFormat::TaggedSymbol) }

        URL = T.let(:url, OpenAI::Models::ImageEditParams::ResponseFormat::OrSymbol)
        B64_JSON = T.let(:b64_json, OpenAI::Models::ImageEditParams::ResponseFormat::OrSymbol)
      end

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024`.
      module Size
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ImageEditParams::Size) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::ImageEditParams::Size::TaggedSymbol) }

        NUMBER_256X256 = T.let(:"256x256", OpenAI::Models::ImageEditParams::Size::OrSymbol)
        NUMBER_512X512 = T.let(:"512x512", OpenAI::Models::ImageEditParams::Size::OrSymbol)
        NUMBER_1024X1024 = T.let(:"1024x1024", OpenAI::Models::ImageEditParams::Size::OrSymbol)
      end
    end
  end
end
