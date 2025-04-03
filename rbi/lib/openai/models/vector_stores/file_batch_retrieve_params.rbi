# typed: strong

module OpenAI
  module Models
    module VectorStores
      class FileBatchRetrieveParams < OpenAI::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        sig { returns(String) }
        attr_accessor :vector_store_id

        sig do
          params(
            vector_store_id: String,
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::Util::AnyHash)
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
