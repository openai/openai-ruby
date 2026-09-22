# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Images#create_variation
    class ImageCreateVariationParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute image
      #   The input image for the legacy variations endpoint. The legacy format requires a
      #   valid PNG file, less than 4MB, and square.
      #
      #   `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      #   metadata. Use `OpenAI::FilePart` when you need to override the filename or
      #   content type.
      #
      #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart]
      required :image, OpenAI::Internal::Type::FileInput

      # @!attribute model
      #   Legacy model selection for the variations endpoint, which was designed for
      #   `dall-e-2`. DALL·E 2 was retired from the API on May 12, 2026; see
      #   [deprecations](https://developers.openai.com/api/docs/deprecations). Use image
      #   edits with a supported GPT Image model for new integrations.
      #
      #   @return [String, Symbol, OpenAI::Models::ImageModel, nil]
      optional :model, union: -> { OpenAI::ImageCreateVariationParams::Model }, nil?: true

      # @!attribute n
      #   The number of images requested from the legacy variations endpoint. Must be
      #   between 1 and 10.
      #
      #   @return [Integer, nil]
      optional :n, Integer, nil?: true

      # @!attribute response_format
      #   The response format for the legacy variations endpoint: `url` or `b64_json`.
      #   Returned URLs were valid for 60 minutes after image generation.
      #
      #   @return [Symbol, OpenAI::Models::ImageCreateVariationParams::ResponseFormat, nil]
      optional :response_format, enum: -> { OpenAI::ImageCreateVariationParams::ResponseFormat }, nil?: true

      # @!attribute size
      #   The requested image size for the legacy variations endpoint. Must be one of
      #   `256x256`, `512x512`, or `1024x1024`.
      #
      #   @return [Symbol, OpenAI::Models::ImageCreateVariationParams::Size, nil]
      optional :size, enum: -> { OpenAI::ImageCreateVariationParams::Size }, nil?: true

      # @!attribute user
      #   A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      #
      #   @return [String, nil]
      optional :user, String

      # @!method initialize(image:, model: nil, n: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #   @param image [Pathname, StringIO, IO, String, OpenAI::FilePart]
      #     The input image for the legacy variations endpoint. The legacy format requires a
      #     valid PNG file, less than 4MB, and square.
      #
      #     `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      #     metadata. Use `OpenAI::FilePart` when you need to override the filename or
      #     content type.
      #
      #   @param model [String, Symbol, OpenAI::Models::ImageModel, nil]
      #     Legacy model selection for the variations endpoint, which was designed for
      #     `dall-e-2`. DALL·E 2 was retired from the API on May 12, 2026; see
      #     [deprecations](https://developers.openai.com/api/docs/deprecations). Use image
      #     edits with a supported GPT Image model for new integrations.
      #
      #   @param n [Integer, nil]
      #     The number of images requested from the legacy variations endpoint. Must be
      #     between 1 and 10.
      #
      #   @param response_format [Symbol, OpenAI::Models::ImageCreateVariationParams::ResponseFormat, nil]
      #     The response format for the legacy variations endpoint: `url` or `b64_json`.
      #     Returned URLs were valid for 60 minutes after image generation.
      #
      #   @param size [Symbol, OpenAI::Models::ImageCreateVariationParams::Size, nil]
      #     The requested image size for the legacy variations endpoint. Must be one of
      #     `256x256`, `512x512`, or `1024x1024`.
      #
      #   @param user [String]
      #     A unique identifier representing your end-user, which can help OpenAI to monitor
      #     and detect abuse.
      #     [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # Legacy model selection for the variations endpoint, which was designed for
      # `dall-e-2`. DALL·E 2 was retired from the API on May 12, 2026; see
      # [deprecations](https://developers.openai.com/api/docs/deprecations). Use image
      # edits with a supported GPT Image model for new integrations.
      module Model
        extend OpenAI::Internal::Type::Union

        variant String

        # Legacy model selection for the variations endpoint, which was designed for `dall-e-2`. DALL·E 2 was retired from the API on May 12, 2026; see [deprecations](https://developers.openai.com/api/docs/deprecations). Use image edits with a supported GPT Image model for new integrations.
        variant enum: -> { OpenAI::ImageModel }

        # @!method self.variants
        #   @return [Array(String, Symbol, OpenAI::Models::ImageModel)]
      end

      # The response format for the legacy variations endpoint: `url` or `b64_json`.
      # Returned URLs were valid for 60 minutes after image generation.
      module ResponseFormat
        extend OpenAI::Internal::Type::Enum

        URL = :url
        B64_JSON = :b64_json

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # The requested image size for the legacy variations endpoint. Must be one of
      # `256x256`, `512x512`, or `1024x1024`.
      module Size
        extend OpenAI::Internal::Type::Enum

        SIZE_256X256 = :"256x256"
        SIZE_512X512 = :"512x512"
        SIZE_1024X1024 = :"1024x1024"

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
