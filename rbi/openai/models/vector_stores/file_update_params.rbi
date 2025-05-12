# typed: strong

module OpenAI
  module Models
    module VectorStores
      class FileUpdateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::VectorStores::FileUpdateParams,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(String) }
        attr_accessor :vector_store_id

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard. Keys are strings with a maximum
        # length of 64 characters. Values are strings with a maximum length of 512
        # characters, booleans, or numbers.
        sig do
          returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
        end
        attr_accessor :attributes

        sig do
          params(
            vector_store_id: String,
            attributes:
              T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          vector_store_id:,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard. Keys are strings with a maximum
          # length of 64 characters. Values are strings with a maximum length of 512
          # characters, booleans, or numbers.
          attributes:,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              vector_store_id: String,
              attributes:
                T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
              request_options: OpenAI::RequestOptions
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
                OpenAI::VectorStores::FileUpdateParams::Attribute::Variants
              ]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
