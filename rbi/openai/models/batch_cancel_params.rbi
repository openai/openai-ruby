# typed: strong

module OpenAI
  module Models
    class BatchCancelParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::BatchCancelParams, OpenAI::Internal::AnyHash)
        end

      sig { returns(String) }
      attr_accessor :batch_id

      sig do
        params(
          batch_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(batch_id:, request_options: {})
      end

      sig do
        override.returns(
          { batch_id: String, request_options: OpenAI::RequestOptions }
        )
      end
      def to_hash
      end
    end
  end
end
