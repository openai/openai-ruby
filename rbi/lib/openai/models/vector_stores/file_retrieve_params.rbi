# typed: strong

module OpenAI
  module Models
    module VectorStores
      class FileRetrieveParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(String) }
        def vector_store_id
        end

        sig { params(_: String).returns(String) }
        def vector_store_id=(_)
        end

        sig do
          params(
            vector_store_id: String,
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(vector_store_id:, request_options: {})
        end

        sig { override.returns({vector_store_id: String, request_options: OpenAI::RequestOptions}) }
        def to_hash
        end
      end
    end
  end
end
