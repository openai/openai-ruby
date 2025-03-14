# typed: strong

module OpenAI
  module Models
    class ImageCreateVariationParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # The image to use as the basis for the variation(s). Must be a valid PNG file,
      #   less than 4MB, and square.
      sig { returns(T.any(IO, StringIO)) }
      def image
      end

      sig { params(_: T.any(IO, StringIO)).returns(T.any(IO, StringIO)) }
      def image=(_)
      end

      # The model to use for image generation. Only `dall-e-2` is supported at this
      #   time.
      sig { returns(T.nilable(T.any(String, Symbol))) }
      def model
      end

      sig { params(_: T.nilable(T.any(String, Symbol))).returns(T.nilable(T.any(String, Symbol))) }
      def model=(_)
      end

      # The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
      #   `n=1` is supported.
      sig { returns(T.nilable(Integer)) }
      def n
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def n=(_)
      end

      # The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      sig { returns(T.nilable(Symbol)) }
      def response_format
      end

      sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
      def response_format=(_)
      end

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024`.
      sig { returns(T.nilable(Symbol)) }
      def size
      end

      sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
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
          model: T.nilable(T.any(String, Symbol)),
          n: T.nilable(Integer),
          response_format: T.nilable(Symbol),
          size: T.nilable(Symbol),
          user: String,
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(image:, model: nil, n: nil, response_format: nil, size: nil, user: nil, request_options: {})
      end

      sig do
        override
          .returns(
            {
              image: T.any(IO, StringIO),
              model: T.nilable(T.any(String, Symbol)),
              n: T.nilable(Integer),
              response_format: T.nilable(Symbol),
              size: T.nilable(Symbol),
              user: String,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      # The model to use for image generation. Only `dall-e-2` is supported at this
      #   time.
      class Model < OpenAI::Union
        abstract!

        class << self
          # @api private
          sig { override.returns([[NilClass, String], [NilClass, Symbol]]) }
          private def variants
          end
        end
      end

      # The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      class ResponseFormat < OpenAI::Enum
        abstract!

        URL = T.let(:url, T.nilable(Symbol))
        B64_JSON = T.let(:b64_json, T.nilable(Symbol))

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024`.
      class Size < OpenAI::Enum
        abstract!

        NUMBER_256X256 = T.let(:"256x256", T.nilable(Symbol))
        NUMBER_512X512 = T.let(:"512x512", T.nilable(Symbol))
        NUMBER_1024X1024 = T.let(:"1024x1024", T.nilable(Symbol))

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end
