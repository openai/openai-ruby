# typed: strong

module OpenAI
  module Models
    class VectorStoreSearchResponse < OpenAI::Internal::Type::BaseModel
      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      # for storing additional information about the object in a structured format, and
      # querying for objects via API or the dashboard. Keys are strings with a maximum
      # length of 64 characters. Values are strings with a maximum length of 512
      # characters, booleans, or numbers.
      sig { returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)])) }
      attr_accessor :attributes

      # Content chunks from the file.
      sig { returns(T::Array[OpenAI::Models::VectorStoreSearchResponse::Content]) }
      attr_accessor :content

      # The ID of the vector store file.
      sig { returns(String) }
      attr_accessor :file_id

      # The name of the vector store file.
      sig { returns(String) }
      attr_accessor :filename

      # The similarity score for the result.
      sig { returns(Float) }
      attr_accessor :score

      sig do
        params(
          attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
          content: T::Array[T.any(OpenAI::Models::VectorStoreSearchResponse::Content, OpenAI::Internal::AnyHash)],
          file_id: String,
          filename: String,
          score: Float
        )
          .returns(T.attached_class)
      end
      def self.new(attributes:, content:, file_id:, filename:, score:); end

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
      def to_hash; end

      module Attribute
        extend OpenAI::Internal::Type::Union

        sig { override.returns([String, Float, T::Boolean]) }
        def self.variants; end
      end

      class Content < OpenAI::Internal::Type::BaseModel
        # The text content returned from search.
        sig { returns(String) }
        attr_accessor :text

        # The type of content.
        sig { returns(OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol) }
        attr_accessor :type

        sig do
          params(text: String, type: OpenAI::Models::VectorStoreSearchResponse::Content::Type::OrSymbol)
            .returns(T.attached_class)
        end
        def self.new(text:, type:); end

        sig do
          override
            .returns({text: String, type: OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol})
        end
        def to_hash; end

        # The type of content.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::VectorStoreSearchResponse::Content::Type) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol) }

          TEXT = T.let(:text, OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol]) }
          def self.values; end
        end
      end
    end
  end
end
