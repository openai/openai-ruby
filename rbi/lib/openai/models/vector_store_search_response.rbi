# typed: strong

module OpenAI
  module Models
    class VectorStoreSearchResponse < OpenAI::BaseModel
      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard. Keys are strings with a maximum
      #   length of 64 characters. Values are strings with a maximum length of 512
      #   characters, booleans, or numbers.
      sig { returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)])) }
      def attributes
      end

      sig do
        params(_: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
          .returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
      end
      def attributes=(_)
      end

      # Content chunks from the file.
      sig { returns(T::Array[OpenAI::Models::VectorStoreSearchResponse::Content]) }
      def content
      end

      sig do
        params(_: T::Array[OpenAI::Models::VectorStoreSearchResponse::Content])
          .returns(T::Array[OpenAI::Models::VectorStoreSearchResponse::Content])
      end
      def content=(_)
      end

      # The ID of the vector store file.
      sig { returns(String) }
      def file_id
      end

      sig { params(_: String).returns(String) }
      def file_id=(_)
      end

      # The name of the vector store file.
      sig { returns(String) }
      def filename
      end

      sig { params(_: String).returns(String) }
      def filename=(_)
      end

      # The similarity score for the result.
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

      module Attribute
        extend OpenAI::Union

        Variants = type_template(:out) { {fixed: T.any(String, Float, T::Boolean)} }

        class << self
          sig { override.returns([String, Float, T::Boolean]) }
          def variants
          end
        end
      end

      class Content < OpenAI::BaseModel
        # The text content returned from search.
        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        # The type of content.
        sig { returns(OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol) }
        def type
        end

        sig do
          params(_: OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol)
            .returns(OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol)
        end
        def type=(_)
        end

        sig do
          params(text: String, type: OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol)
            .returns(T.attached_class)
        end
        def self.new(text:, type:)
        end

        sig do
          override
            .returns({text: String, type: OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol})
        end
        def to_hash
        end

        # The type of content.
        module Type
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::VectorStoreSearchResponse::Content::Type) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol) }

          TEXT = T.let(:text, OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
