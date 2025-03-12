# typed: strong

module OpenAI
  module Models
    class VectorStoreSearchResponse < OpenAI::BaseModel
      sig { returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)])) }
      def attributes
      end

      sig do
        params(_: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
          .returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
      end
      def attributes=(_)
      end

      sig { returns(T::Array[OpenAI::Models::VectorStoreSearchResponse::Content]) }
      def content
      end

      sig do
        params(_: T::Array[OpenAI::Models::VectorStoreSearchResponse::Content])
          .returns(T::Array[OpenAI::Models::VectorStoreSearchResponse::Content])
      end
      def content=(_)
      end

      sig { returns(String) }
      def file_id
      end

      sig { params(_: String).returns(String) }
      def file_id=(_)
      end

      sig { returns(String) }
      def filename
      end

      sig { params(_: String).returns(String) }
      def filename=(_)
      end

      sig { returns(Float) }
      def score
      end

      sig { params(_: Float).returns(Float) }
      def score=(_)
      end

      sig do
        params(
          attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
          content: T::Array[OpenAI::Models::VectorStoreSearchResponse::Content],
          file_id: String,
          filename: String,
          score: Float
        )
          .returns(T.attached_class)
      end
      def self.new(attributes:, content:, file_id:, filename:, score:)
      end

      sig do
        override
          .returns(
            {
              attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
              content: T::Array[OpenAI::Models::VectorStoreSearchResponse::Content],
              file_id: String,
              filename: String,
              score: Float
            }
          )
      end
      def to_hash
      end

      class Attribute < OpenAI::Union
        abstract!

        class << self
          sig { override.returns([[NilClass, String], [NilClass, Float], [NilClass, T::Boolean]]) }
          private def variants
          end
        end
      end

      class Content < OpenAI::BaseModel
        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { params(text: String, type: Symbol).returns(T.attached_class) }
        def self.new(text:, type:)
        end

        sig { override.returns({text: String, type: Symbol}) }
        def to_hash
        end

        class Type < OpenAI::Enum
          abstract!

          TEXT = :text

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
