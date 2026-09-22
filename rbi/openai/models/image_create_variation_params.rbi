# typed: strong

module OpenAI
  module Models

    class ImageCreateVariationParams < OpenAI::Internal::Type::BaseModel

      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash = T.type_alias do
        T.any(
          OpenAI::ImageCreateVariationParams,
          OpenAI::Internal::AnyHash
        )
      end

      # The input image for the legacy variations endpoint. The legacy format requires a
      # valid PNG file, less than 4MB, and square.
      #
      # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      # metadata. Use `OpenAI::FilePart` when you need to override the filename or
      # content type.
      sig { returns(OpenAI::Internal::FileInput) }
      attr_accessor :image

      # Legacy model selection for the variations endpoint, which was designed for
      # `dall-e-2`. DALL·E 2 was retired from the API on May 12, 2026; see
      # [deprecations](https://developers.openai.com/api/docs/deprecations). Use image
      # edits with a supported GPT Image model for new integrations.
      sig { returns(T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol))) }
      attr_accessor :model

      # The number of images requested from the legacy variations endpoint. Must be
      # between 1 and 10.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :n

      # The response format for the legacy variations endpoint: `url` or `b64_json`.
      # Returned URLs were valid for 60 minutes after image generation.
      sig { returns(T.nilable(OpenAI::ImageCreateVariationParams::ResponseFormat::OrSymbol)) }
      attr_accessor :response_format

      # The requested image size for the legacy variations endpoint. Must be one of
      # `256x256`, `512x512`, or `1024x1024`.
      sig { returns(T.nilable(OpenAI::ImageCreateVariationParams::Size::OrSymbol)) }
      attr_accessor :size

      # A unique identifier representing your end-user, which can help OpenAI to monitor
      # and detect abuse.
      # [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      sig { returns(T.nilable(String)) }
      attr_reader :user

      sig { params(user: String).void }
      attr_writer :user

      sig do
        params(

          image: OpenAI::Internal::FileInput,

          model: T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol)),

          n: T.nilable(Integer),

          response_format: T.nilable(OpenAI::ImageCreateVariationParams::ResponseFormat::OrSymbol),

          size: T.nilable(OpenAI::ImageCreateVariationParams::Size::OrSymbol),

          user: String,

          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(T.attached_class)
      end
      def self.new(

        # The input image for the legacy variations endpoint. The legacy format requires a
        # valid PNG file, less than 4MB, and square.
        #
        # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        # metadata. Use `OpenAI::FilePart` when you need to override the filename or
        # content type.
        image:,

        # Legacy model selection for the variations endpoint, which was designed for
        # `dall-e-2`. DALL·E 2 was retired from the API on May 12, 2026; see
        # [deprecations](https://developers.openai.com/api/docs/deprecations). Use image
        # edits with a supported GPT Image model for new integrations.
        model: nil,

        # The number of images requested from the legacy variations endpoint. Must be
        # between 1 and 10.
        n: nil,

        # The response format for the legacy variations endpoint: `url` or `b64_json`.
        # Returned URLs were valid for 60 minutes after image generation.
        response_format: nil,

        # The requested image size for the legacy variations endpoint. Must be one of
        # `256x256`, `512x512`, or `1024x1024`.
        size: nil,

        # A unique identifier representing your end-user, which can help OpenAI to monitor
        # and detect abuse.
        # [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
        user: nil,

        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            image: OpenAI::Internal::FileInput,
            model: T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol)),
            n: T.nilable(Integer),
            response_format: T.nilable(OpenAI::ImageCreateVariationParams::ResponseFormat::OrSymbol),
            size: T.nilable(OpenAI::ImageCreateVariationParams::Size::OrSymbol),
            user: String,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # Legacy model selection for the variations endpoint, which was designed for
      # `dall-e-2`. DALL·E 2 was retired from the API on May 12, 2026; see
      # [deprecations](https://developers.openai.com/api/docs/deprecations). Use image
      # edits with a supported GPT Image model for new integrations.
      module Model
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(String, OpenAI::ImageModel::TaggedSymbol) }

        sig { override.returns(T::Array[OpenAI::ImageCreateVariationParams::Model::Variants]) }
        def self.variants
        end

      end

      # The response format for the legacy variations endpoint: `url` or `b64_json`.
      # Returned URLs were valid for 60 minutes after image generation.
      module ResponseFormat
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ImageCreateVariationParams::ResponseFormat) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        URL = T.let(:url, OpenAI::ImageCreateVariationParams::ResponseFormat::TaggedSymbol)
        B64_JSON = T.let(:b64_json, OpenAI::ImageCreateVariationParams::ResponseFormat::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::ImageCreateVariationParams::ResponseFormat::TaggedSymbol]) }
        def self.values
        end
      end

      # The requested image size for the legacy variations endpoint. Must be one of
      # `256x256`, `512x512`, or `1024x1024`.
      module Size
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ImageCreateVariationParams::Size) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        SIZE_256X256 = T.let(:"256x256", OpenAI::ImageCreateVariationParams::Size::TaggedSymbol)
        SIZE_512X512 = T.let(:"512x512", OpenAI::ImageCreateVariationParams::Size::TaggedSymbol)
        SIZE_1024X1024 = T.let(:"1024x1024", OpenAI::ImageCreateVariationParams::Size::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::ImageCreateVariationParams::Size::TaggedSymbol]) }
        def self.values
        end
      end

    end

  end
end
