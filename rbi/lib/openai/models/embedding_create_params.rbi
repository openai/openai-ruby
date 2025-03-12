# typed: strong

module OpenAI
  module Models
    class EmbeddingCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      sig { returns(T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]])) }
      def input
      end

      sig do
        params(_: T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]))
          .returns(T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]))
      end
      def input=(_)
      end

      sig { returns(T.any(String, Symbol)) }
      def model
      end

      sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
      def model=(_)
      end

      sig { returns(T.nilable(Integer)) }
      def dimensions
      end

      sig { params(_: Integer).returns(Integer) }
      def dimensions=(_)
      end

      sig { returns(T.nilable(Symbol)) }
      def encoding_format
      end

      sig { params(_: Symbol).returns(Symbol) }
      def encoding_format=(_)
      end

      sig { returns(T.nilable(String)) }
      def user
      end

      sig { params(_: String).returns(String) }
      def user=(_)
      end

      sig do
        params(
          input: T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]),
          model: T.any(String, Symbol),
          dimensions: Integer,
          encoding_format: Symbol,
          user: String,
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(input:, model:, dimensions: nil, encoding_format: nil, user: nil, request_options: {})
      end

      sig do
        override
          .returns(
            {
              input: T.any(String, T::Array[String], T::Array[Integer], T::Array[T::Array[Integer]]),
              model: T.any(String, Symbol),
              dimensions: Integer,
              encoding_format: Symbol,
              user: String,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      class Input < OpenAI::Union
        abstract!

        StringArray = T.type_alias { T::Array[String] }

        IntegerArray = T.type_alias { T::Array[Integer] }

        ArrayOfToken2DArray = T.type_alias { T::Array[T::Array[Integer]] }

        class << self
          sig do
            override
              .returns(
                [
                  [NilClass, String],
                  [NilClass, T::Array[String]],
                  [NilClass, T::Array[Integer]],
                  [NilClass, T::Array[T::Array[Integer]]]
                ]
              )
          end
          private def variants
          end
        end
      end

      class Model < OpenAI::Union
        abstract!

        class << self
          sig { override.returns([[NilClass, String], [NilClass, Symbol]]) }
          private def variants
          end
        end
      end

      class EncodingFormat < OpenAI::Enum
        abstract!

        FLOAT = :float
        BASE64 = :base64

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end
