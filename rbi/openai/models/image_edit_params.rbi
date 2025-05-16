# typed: strong

module OpenAI
  module Models
    class ImageEditParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::ImageEditParams, OpenAI::Internal::AnyHash)
        end

      # The image(s) to edit. Must be a supported image file or an array of images.
      #
      # For `gpt-image-1`, each image should be a `png`, `webp`, or `jpg` file less than
      # 25MB. You can provide up to 16 images.
      #
      # For `dall-e-2`, you can only provide one image, and it should be a square `png`
      # file less than 4MB.
      sig do
        returns(
          T.any(
            Pathname,
            StringIO,
            IO,
            OpenAI::FilePart,
            T::Array[T.any(Pathname, StringIO, IO, OpenAI::FilePart)]
          )
        )
      end
      attr_accessor :image

      # A text description of the desired image(s). The maximum length is 1000
      # characters for `dall-e-2`, and 32000 characters for `gpt-image-1`.
      sig { returns(String) }
      attr_accessor :prompt

      # Allows to set transparency for the background of the generated image(s). This
      # parameter is only supported for `gpt-image-1`. Must be one of `transparent`,
      # `opaque` or `auto` (default value). When `auto` is used, the model will
      # automatically determine the best background for the image.
      #
      # If `transparent`, the output format needs to support transparency, so it should
      # be set to either `png` (default value) or `webp`.
      sig { returns(T.nilable(OpenAI::ImageEditParams::Background::OrSymbol)) }
      attr_accessor :background

      # An additional image whose fully transparent areas (e.g. where alpha is zero)
      # indicate where `image` should be edited. If there are multiple images provided,
      # the mask will be applied on the first image. Must be a valid PNG file, less than
      # 4MB, and have the same dimensions as `image`.
      sig do
        returns(T.nilable(T.any(Pathname, StringIO, IO, OpenAI::FilePart)))
      end
      attr_reader :mask

      sig { params(mask: T.any(Pathname, StringIO, IO, OpenAI::FilePart)).void }
      attr_writer :mask

      # The model to use for image generation. Only `dall-e-2` and `gpt-image-1` are
      # supported. Defaults to `dall-e-2` unless a parameter specific to `gpt-image-1`
      # is used.
      sig { returns(T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol))) }
      attr_accessor :model

      # The number of images to generate. Must be between 1 and 10.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :n

      # The quality of the image that will be generated. `high`, `medium` and `low` are
      # only supported for `gpt-image-1`. `dall-e-2` only supports `standard` quality.
      # Defaults to `auto`.
      sig { returns(T.nilable(OpenAI::ImageEditParams::Quality::OrSymbol)) }
      attr_accessor :quality

      # The format in which the generated images are returned. Must be one of `url` or
      # `b64_json`. URLs are only valid for 60 minutes after the image has been
      # generated. This parameter is only supported for `dall-e-2`, as `gpt-image-1`
      # will always return base64-encoded images.
      sig do
        returns(T.nilable(OpenAI::ImageEditParams::ResponseFormat::OrSymbol))
      end
      attr_accessor :response_format

      # The size of the generated images. Must be one of `1024x1024`, `1536x1024`
      # (landscape), `1024x1536` (portrait), or `auto` (default value) for
      # `gpt-image-1`, and one of `256x256`, `512x512`, or `1024x1024` for `dall-e-2`.
      sig { returns(T.nilable(OpenAI::ImageEditParams::Size::OrSymbol)) }
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
          image:
            T.any(
              Pathname,
              StringIO,
              IO,
              OpenAI::FilePart,
              T::Array[T.any(Pathname, StringIO, IO, OpenAI::FilePart)]
            ),
          prompt: String,
          background: T.nilable(OpenAI::ImageEditParams::Background::OrSymbol),
          mask: T.any(Pathname, StringIO, IO, OpenAI::FilePart),
          model: T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol)),
          n: T.nilable(Integer),
          quality: T.nilable(OpenAI::ImageEditParams::Quality::OrSymbol),
          response_format:
            T.nilable(OpenAI::ImageEditParams::ResponseFormat::OrSymbol),
          size: T.nilable(OpenAI::ImageEditParams::Size::OrSymbol),
          user: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # The image(s) to edit. Must be a supported image file or an array of images.
        #
        # For `gpt-image-1`, each image should be a `png`, `webp`, or `jpg` file less than
        # 25MB. You can provide up to 16 images.
        #
        # For `dall-e-2`, you can only provide one image, and it should be a square `png`
        # file less than 4MB.
        image:,
        # A text description of the desired image(s). The maximum length is 1000
        # characters for `dall-e-2`, and 32000 characters for `gpt-image-1`.
        prompt:,
        # Allows to set transparency for the background of the generated image(s). This
        # parameter is only supported for `gpt-image-1`. Must be one of `transparent`,
        # `opaque` or `auto` (default value). When `auto` is used, the model will
        # automatically determine the best background for the image.
        #
        # If `transparent`, the output format needs to support transparency, so it should
        # be set to either `png` (default value) or `webp`.
        background: nil,
        # An additional image whose fully transparent areas (e.g. where alpha is zero)
        # indicate where `image` should be edited. If there are multiple images provided,
        # the mask will be applied on the first image. Must be a valid PNG file, less than
        # 4MB, and have the same dimensions as `image`.
        mask: nil,
        # The model to use for image generation. Only `dall-e-2` and `gpt-image-1` are
        # supported. Defaults to `dall-e-2` unless a parameter specific to `gpt-image-1`
        # is used.
        model: nil,
        # The number of images to generate. Must be between 1 and 10.
        n: nil,
        # The quality of the image that will be generated. `high`, `medium` and `low` are
        # only supported for `gpt-image-1`. `dall-e-2` only supports `standard` quality.
        # Defaults to `auto`.
        quality: nil,
        # The format in which the generated images are returned. Must be one of `url` or
        # `b64_json`. URLs are only valid for 60 minutes after the image has been
        # generated. This parameter is only supported for `dall-e-2`, as `gpt-image-1`
        # will always return base64-encoded images.
        response_format: nil,
        # The size of the generated images. Must be one of `1024x1024`, `1536x1024`
        # (landscape), `1024x1536` (portrait), or `auto` (default value) for
        # `gpt-image-1`, and one of `256x256`, `512x512`, or `1024x1024` for `dall-e-2`.
        size: nil,
        # A unique identifier representing your end-user, which can help OpenAI to monitor
        # and detect abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        user: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            image:
              T.any(
                Pathname,
                StringIO,
                IO,
                OpenAI::FilePart,
                T::Array[T.any(Pathname, StringIO, IO, OpenAI::FilePart)]
              ),
            prompt: String,
            background:
              T.nilable(OpenAI::ImageEditParams::Background::OrSymbol),
            mask: T.any(Pathname, StringIO, IO, OpenAI::FilePart),
            model: T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol)),
            n: T.nilable(Integer),
            quality: T.nilable(OpenAI::ImageEditParams::Quality::OrSymbol),
            response_format:
              T.nilable(OpenAI::ImageEditParams::ResponseFormat::OrSymbol),
            size: T.nilable(OpenAI::ImageEditParams::Size::OrSymbol),
            user: String,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # The image(s) to edit. Must be a supported image file or an array of images.
      #
      # For `gpt-image-1`, each image should be a `png`, `webp`, or `jpg` file less than
      # 25MB. You can provide up to 16 images.
      #
      # For `dall-e-2`, you can only provide one image, and it should be a square `png`
      # file less than 4MB.
      module Image
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(StringIO, T::Array[StringIO]) }

        sig do
          override.returns(T::Array[OpenAI::ImageEditParams::Image::Variants])
        end
        def self.variants
        end

        StringArray =
          T.let(
            OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::FileInput],
            OpenAI::Internal::Type::Converter
          )
      end

      # Allows to set transparency for the background of the generated image(s). This
      # parameter is only supported for `gpt-image-1`. Must be one of `transparent`,
      # `opaque` or `auto` (default value). When `auto` is used, the model will
      # automatically determine the best background for the image.
      #
      # If `transparent`, the output format needs to support transparency, so it should
      # be set to either `png` (default value) or `webp`.
      module Background
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::ImageEditParams::Background) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        TRANSPARENT =
          T.let(:transparent, OpenAI::ImageEditParams::Background::TaggedSymbol)
        OPAQUE =
          T.let(:opaque, OpenAI::ImageEditParams::Background::TaggedSymbol)
        AUTO = T.let(:auto, OpenAI::ImageEditParams::Background::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImageEditParams::Background::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The model to use for image generation. Only `dall-e-2` and `gpt-image-1` are
      # supported. Defaults to `dall-e-2` unless a parameter specific to `gpt-image-1`
      # is used.
      module Model
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias { T.any(String, OpenAI::ImageModel::TaggedSymbol) }

        sig do
          override.returns(T::Array[OpenAI::ImageEditParams::Model::Variants])
        end
        def self.variants
        end
      end

      # The quality of the image that will be generated. `high`, `medium` and `low` are
      # only supported for `gpt-image-1`. `dall-e-2` only supports `standard` quality.
      # Defaults to `auto`.
      module Quality
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::ImageEditParams::Quality) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        STANDARD =
          T.let(:standard, OpenAI::ImageEditParams::Quality::TaggedSymbol)
        LOW = T.let(:low, OpenAI::ImageEditParams::Quality::TaggedSymbol)
        MEDIUM = T.let(:medium, OpenAI::ImageEditParams::Quality::TaggedSymbol)
        HIGH = T.let(:high, OpenAI::ImageEditParams::Quality::TaggedSymbol)
        AUTO = T.let(:auto, OpenAI::ImageEditParams::Quality::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImageEditParams::Quality::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The format in which the generated images are returned. Must be one of `url` or
      # `b64_json`. URLs are only valid for 60 minutes after the image has been
      # generated. This parameter is only supported for `dall-e-2`, as `gpt-image-1`
      # will always return base64-encoded images.
      module ResponseFormat
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageEditParams::ResponseFormat)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        URL = T.let(:url, OpenAI::ImageEditParams::ResponseFormat::TaggedSymbol)
        B64_JSON =
          T.let(
            :b64_json,
            OpenAI::ImageEditParams::ResponseFormat::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[OpenAI::ImageEditParams::ResponseFormat::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The size of the generated images. Must be one of `1024x1024`, `1536x1024`
      # (landscape), `1024x1536` (portrait), or `auto` (default value) for
      # `gpt-image-1`, and one of `256x256`, `512x512`, or `1024x1024` for `dall-e-2`.
      module Size
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::ImageEditParams::Size) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        SIZE_256X256 =
          T.let(:"256x256", OpenAI::ImageEditParams::Size::TaggedSymbol)
        SIZE_512X512 =
          T.let(:"512x512", OpenAI::ImageEditParams::Size::TaggedSymbol)
        SIZE_1024X1024 =
          T.let(:"1024x1024", OpenAI::ImageEditParams::Size::TaggedSymbol)
        SIZE_1536X1024 =
          T.let(:"1536x1024", OpenAI::ImageEditParams::Size::TaggedSymbol)
        SIZE_1024X1536 =
          T.let(:"1024x1536", OpenAI::ImageEditParams::Size::TaggedSymbol)
        AUTO = T.let(:auto, OpenAI::ImageEditParams::Size::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImageEditParams::Size::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
