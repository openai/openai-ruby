# typed: strong

module OpenAI
  module Models
    class VectorStoreSearchResponse < OpenAI::Internal::Type::BaseModel
      OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      # for storing additional information about the object in a structured format, and
      # querying for objects via API or the dashboard. Keys are strings with a maximum
      # length of 64 characters. Values are strings with a maximum length of 512
      # characters, booleans, or numbers.
      sig do
        returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
      end
      attr_accessor :attributes

      # Content chunks from the file.
      sig do
        returns(T::Array[OpenAI::Models::VectorStoreSearchResponse::Content])
      end
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
          attributes:
            T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
          content:
            T::Array[
              OpenAI::Models::VectorStoreSearchResponse::Content::OrHash
            ],
          file_id: String,
          filename: String,
          score: Float
        ).returns(T.attached_class)
      end
      def self.new(
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard. Keys are strings with a maximum
        # length of 64 characters. Values are strings with a maximum length of 512
        # characters, booleans, or numbers.
        attributes:,
        # Content chunks from the file.
        content:,
        # The ID of the vector store file.
        file_id:,
        # The name of the vector store file.
        filename:,
        # The similarity score for the result.
        score:
      )
      end

      sig do
        override.returns(
          {
            attributes:
              T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
            content:
              T::Array[OpenAI::Models::VectorStoreSearchResponse::Content],
            file_id: String,
            filename: String,
            score: Float
          }
        )
      end
      def to_hash
      end

      module Attribute
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(String, Float, T::Boolean) }

        sig do
          override.returns(
            T::Array[
              OpenAI::Models::VectorStoreSearchResponse::Attribute::Variants
            ]
          )
        end
        def self.variants
        end
      end

      class Content < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The text content returned from search.
        sig { returns(String) }
        attr_accessor :text

        # The type of content.
        sig do
          returns(
            OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol
          )
        end
        attr_accessor :type

        sig do
          params(
            text: String,
            type:
              OpenAI::Models::VectorStoreSearchResponse::Content::Type::OrSymbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The text content returned from search.
          text:,
          # The type of content.
          type:
        )
        end

        sig do
          override.returns(
            {
              text: String,
              type:
                OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        # The type of content.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Models::VectorStoreSearchResponse::Content::Type
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TEXT =
            T.let(
              :text,
              OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Models::VectorStoreSearchResponse::Content::Type::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
