# typed: strong

module OpenAI
  module Models
    class ImageCreateVariationParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      sig { returns(T.any(IO, StringIO)) }
      def image
      end

      sig { params(_: T.any(IO, StringIO)).returns(T.any(IO, StringIO)) }
      def image=(_)
      end

      sig { returns(T.nilable(T.any(String, Symbol))) }
      def model
      end

      sig { params(_: T.nilable(T.any(String, Symbol))).returns(T.nilable(T.any(String, Symbol))) }
      def model=(_)
      end

      sig { returns(T.nilable(Integer)) }
      def n
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def n=(_)
      end

      sig { returns(T.nilable(Symbol)) }
      def response_format
      end

      sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
      def response_format=(_)
      end

      sig { returns(T.nilable(Symbol)) }
      def size
      end

      sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
      def size=(_)
      end

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

      class Model < OpenAI::Union
        abstract!

        class << self
          sig { override.returns([[NilClass, String], [NilClass, Symbol]]) }
          private def variants
          end
        end
      end

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
