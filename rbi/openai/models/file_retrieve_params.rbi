# typed: strong

module OpenAI
  module Models
    class FileRetrieveParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::FileRetrieveParams, OpenAI::Internal::AnyHash)
        end

      sig { returns(String) }
      attr_accessor :file_id

      sig do
        params(
          file_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(file_id:, request_options: {})
      end

      sig do
        override.returns(
          { file_id: String, request_options: OpenAI::RequestOptions }
        )
      end
      def to_hash
      end
    end
  end
end
