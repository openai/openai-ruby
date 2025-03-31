# typed: strong

module OpenAI
  module Models
    class ImageGenerateParams < OpenAI::BaseModel
      extend OpenAI::Type::RequestParameters::Converter
      include OpenAI::RequestParameters

      # A text description of the desired image(s). The maximum length is 1000
      #   characters for `dall-e-2` and 4000 characters for `dall-e-3`.
      sig { returns(String) }
      attr_accessor :prompt

      # The model to use for image generation.
      sig { returns(T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol))) }
      attr_accessor :model

      # The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
      #   `n=1` is supported.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :n

      # The quality of the image that will be generated. `hd` creates images with finer
      #   details and greater consistency across the image. This param is only supported
      #   for `dall-e-3`.
      sig { returns(T.nilable(OpenAI::Models::ImageGenerateParams::Quality::OrSymbol)) }
      attr_reader :quality

      sig { params(quality: OpenAI::Models::ImageGenerateParams::Quality::OrSymbol).void }
      attr_writer :quality

      # The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      sig { returns(T.nilable(OpenAI::Models::ImageGenerateParams::ResponseFormat::OrSymbol)) }
      attr_accessor :response_format

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024` for `dall-e-2`. Must be one of `1024x1024`, `1792x1024`, or
      #   `1024x1792` for `dall-e-3` models.
      sig { returns(T.nilable(OpenAI::Models::ImageGenerateParams::Size::OrSymbol)) }
      attr_accessor :size

      # The style of the generated images. Must be one of `vivid` or `natural`. Vivid
      #   causes the model to lean towards generating hyper-real and dramatic images.
      #   Natural causes the model to produce more natural, less hyper-real looking
      #   images. This param is only supported for `dall-e-3`.
      sig { returns(T.nilable(OpenAI::Models::ImageGenerateParams::Style::OrSymbol)) }
      attr_accessor :style

      # A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      sig { returns(T.nilable(String)) }
      attr_reader :user

      sig { params(user: String).void }
      attr_writer :user

      sig do
        params(
          prompt: String,
          model: T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol)),
          n: T.nilable(Integer),
          quality: OpenAI::Models::ImageGenerateParams::Quality::OrSymbol,
          response_format: T.nilable(OpenAI::Models::ImageGenerateParams::ResponseFormat::OrSymbol),
          size: T.nilable(OpenAI::Models::ImageGenerateParams::Size::OrSymbol),
          style: T.nilable(OpenAI::Models::ImageGenerateParams::Style::OrSymbol),
          user: String,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(
        prompt:,
        model: nil,
        n: nil,
        quality: nil,
        response_format: nil,
        size: nil,
        style: nil,
        user: nil,
        request_options: {}
      )
      end

      sig do
        override
          .returns(
            {
              prompt: String,
              model: T.nilable(T.any(String, OpenAI::Models::ImageModel::OrSymbol)),
              n: T.nilable(Integer),
              quality: OpenAI::Models::ImageGenerateParams::Quality::OrSymbol,
              response_format: T.nilable(OpenAI::Models::ImageGenerateParams::ResponseFormat::OrSymbol),
              size: T.nilable(OpenAI::Models::ImageGenerateParams::Size::OrSymbol),
              style: T.nilable(OpenAI::Models::ImageGenerateParams::Style::OrSymbol),
              user: String,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      # The model to use for image generation.
      module Model
        extend OpenAI::Union

        sig { override.returns([String, OpenAI::Models::ImageModel::OrSymbol]) }
        def self.variants
        end
      end

      # The quality of the image that will be generated. `hd` creates images with finer
      #   details and greater consistency across the image. This param is only supported
      #   for `dall-e-3`.
      module Quality
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ImageGenerateParams::Quality) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::ImageGenerateParams::Quality::TaggedSymbol) }

        STANDARD = T.let(:standard, OpenAI::Models::ImageGenerateParams::Quality::TaggedSymbol)
        HD = T.let(:hd, OpenAI::Models::ImageGenerateParams::Quality::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::ImageGenerateParams::Quality::TaggedSymbol]) }
        def self.values
        end
      end

      # The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      module ResponseFormat
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ImageGenerateParams::ResponseFormat) }
        OrSymbol =
          T.type_alias { T.any(Symbol, OpenAI::Models::ImageGenerateParams::ResponseFormat::TaggedSymbol) }

        URL = T.let(:url, OpenAI::Models::ImageGenerateParams::ResponseFormat::TaggedSymbol)
        B64_JSON = T.let(:b64_json, OpenAI::Models::ImageGenerateParams::ResponseFormat::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::ImageGenerateParams::ResponseFormat::TaggedSymbol]) }
        def self.values
        end
      end

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024` for `dall-e-2`. Must be one of `1024x1024`, `1792x1024`, or
      #   `1024x1792` for `dall-e-3` models.
      module Size
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ImageGenerateParams::Size) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::ImageGenerateParams::Size::TaggedSymbol) }

        NUMBER_256X256 = T.let(:"256x256", OpenAI::Models::ImageGenerateParams::Size::TaggedSymbol)
        NUMBER_512X512 = T.let(:"512x512", OpenAI::Models::ImageGenerateParams::Size::TaggedSymbol)
        NUMBER_1024X1024 = T.let(:"1024x1024", OpenAI::Models::ImageGenerateParams::Size::TaggedSymbol)
        NUMBER_1792X1024 = T.let(:"1792x1024", OpenAI::Models::ImageGenerateParams::Size::TaggedSymbol)
        NUMBER_1024X1792 = T.let(:"1024x1792", OpenAI::Models::ImageGenerateParams::Size::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::ImageGenerateParams::Size::TaggedSymbol]) }
        def self.values
        end
      end

      # The style of the generated images. Must be one of `vivid` or `natural`. Vivid
      #   causes the model to lean towards generating hyper-real and dramatic images.
      #   Natural causes the model to produce more natural, less hyper-real looking
      #   images. This param is only supported for `dall-e-3`.
      module Style
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ImageGenerateParams::Style) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::ImageGenerateParams::Style::TaggedSymbol) }

        VIVID = T.let(:vivid, OpenAI::Models::ImageGenerateParams::Style::TaggedSymbol)
        NATURAL = T.let(:natural, OpenAI::Models::ImageGenerateParams::Style::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::ImageGenerateParams::Style::TaggedSymbol]) }
        def self.values
        end
      end
    end
  end
end
