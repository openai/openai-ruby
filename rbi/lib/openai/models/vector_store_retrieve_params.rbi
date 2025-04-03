# typed: strong

module OpenAI
  module Models
    class VectorStoreRetrieveParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      sig do
        params(
          request_options: T.any(
            OpenAI::RequestOptions,
            OpenAI::Internal::AnyHash
          )
        ).returns(T.attached_class)
      end
      def self.new(request_options: {})
      end

      sig { override.returns({request_options: OpenAI::RequestOptions}) }
      def to_hash
      end
    end
  end
end
