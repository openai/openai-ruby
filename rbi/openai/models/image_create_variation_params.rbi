# typed: strong

module OpenAI
  module Models
    class ImageCreateVariationParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

      # The image to use as the basis for the variation(s). Must be a valid PNG file,
      # less than 4MB, and square.
      sig { returns(T.any(Pathname, StringIO, IO, OpenAI::FilePart)) }
      attr_accessor :image

      # The model to use for image generation. Only `dall-e-2` is supported at this
      # time.
      sig { returns(T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol))) }
      attr_accessor :model

      # The number of images to generate. Must be between 1 and 10.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :n

      # The format in which the generated images are returned. Must be one of `url` or
      # `b64_json`. URLs are only valid for 60 minutes after the image has been
      # generated.
      sig do
        returns(
          T.nilable(
            OpenAI::ImageCreateVariationParams::ResponseFormat::OrSymbol
          )
        )
      end
      attr_accessor :response_format

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      # `1024x1024`.
      sig do
        returns(T.nilable(OpenAI::ImageCreateVariationParams::Size::OrSymbol))
      end
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
          image: T.any(Pathname, StringIO, IO, OpenAI::FilePart),
          model: T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol)),
          n: T.nilable(Integer),
          response_format:
            T.nilable(
              OpenAI::ImageCreateVariationParams::ResponseFormat::OrSymbol
            ),
          size: T.nilable(OpenAI::ImageCreateVariationParams::Size::OrSymbol),
          user: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # The image to use as the basis for the variation(s). Must be a valid PNG file,
        # less than 4MB, and square.
        image:,
        # The model to use for image generation. Only `dall-e-2` is supported at this
        # time.
        model: nil,
        # The number of images to generate. Must be between 1 and 10.
        n: nil,
        # The format in which the generated images are returned. Must be one of `url` or
        # `b64_json`. URLs are only valid for 60 minutes after the image has been
        # generated.
        response_format: nil,
        # The size of the generated images. Must be one of `256x256`, `512x512`, or
        # `1024x1024`.
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
            image: T.any(Pathname, StringIO, IO, OpenAI::FilePart),
            model: T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol)),
            n: T.nilable(Integer),
            response_format:
              T.nilable(
                OpenAI::ImageCreateVariationParams::ResponseFormat::OrSymbol
              ),
            size: T.nilable(OpenAI::ImageCreateVariationParams::Size::OrSymbol),
            user: String,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # The model to use for image generation. Only `dall-e-2` is supported at this
      # time.
      module Model
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias { T.any(String, OpenAI::ImageModel::TaggedSymbol) }

        sig do
          override.returns(
            T::Array[OpenAI::ImageCreateVariationParams::Model::Variants]
          )
        end
        def self.variants
        end
      end

      # The format in which the generated images are returned. Must be one of `url` or
      # `b64_json`. URLs are only valid for 60 minutes after the image has been
      # generated.
      module ResponseFormat
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageCreateVariationParams::ResponseFormat)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        URL =
          T.let(
            :url,
            OpenAI::ImageCreateVariationParams::ResponseFormat::TaggedSymbol
          )
        B64_JSON =
          T.let(
            :b64_json,
            OpenAI::ImageCreateVariationParams::ResponseFormat::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[
              OpenAI::ImageCreateVariationParams::ResponseFormat::TaggedSymbol
            ]
          )
        end
        def self.values
        end
      end

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      # `1024x1024`.
      module Size
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageCreateVariationParams::Size)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        SIZE_256X256 =
          T.let(
            :"256x256",
            OpenAI::ImageCreateVariationParams::Size::TaggedSymbol
          )
        SIZE_512X512 =
          T.let(
            :"512x512",
            OpenAI::ImageCreateVariationParams::Size::TaggedSymbol
          )
        SIZE_1024X1024 =
          T.let(
            :"1024x1024",
            OpenAI::ImageCreateVariationParams::Size::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[OpenAI::ImageCreateVariationParams::Size::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
