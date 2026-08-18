# typed: strong

module OpenAI
  module Models
    class ModelRetrieveParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::ModelRetrieveParams, OpenAI::Internal::AnyHash)
        end

      sig { returns(String) }
      attr_accessor :model

      sig do
        params(
          model: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(model:, request_options: {})
      end

      sig do
        override.returns(
          { model: String, request_options: OpenAI::RequestOptions }
        )
      end
      def to_hash
      end
    end
  end
end
