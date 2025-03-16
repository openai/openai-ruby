# typed: strong

module OpenAI
  module Models
    module VectorStores
      class FileUpdateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(String) }
        def vector_store_id
        end

        sig { params(_: String).returns(String) }
        def vector_store_id=(_)
        end

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

        sig do
          params(
            vector_store_id: String,
            attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(vector_store_id:, attributes:, request_options: {})
        end

        sig do
          override
            .returns(
              {
                vector_store_id: String,
                attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        class Attribute < OpenAI::Union
          abstract!

          Variants = type_template(:out) { {fixed: T.any(String, Float, T::Boolean)} }
        end
      end
    end
  end
end
