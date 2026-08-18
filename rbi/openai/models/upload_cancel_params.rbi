# typed: strong

module OpenAI
  module Models
    class UploadCancelParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::UploadCancelParams, OpenAI::Internal::AnyHash)
        end

      sig { returns(String) }
      attr_accessor :upload_id

      sig do
        params(
          upload_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(upload_id:, request_options: {})
      end

      sig do
        override.returns(
          { upload_id: String, request_options: OpenAI::RequestOptions }
        )
      end
      def to_hash
      end
    end
  end
end
