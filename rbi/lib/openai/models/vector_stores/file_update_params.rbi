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

          class << self
            sig { override.returns([[NilClass, String], [NilClass, Float], [NilClass, T::Boolean]]) }
            private def variants
            end
          end
        end
      end
    end
  end
end
