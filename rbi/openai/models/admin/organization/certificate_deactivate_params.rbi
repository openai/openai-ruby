# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class CertificateDeactivateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::CertificateDeactivateParams,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(T::Array[String]) }
          attr_accessor :certificate_ids

          sig do
            params(
              certificate_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(certificate_ids:, request_options: {})
          end

          sig do
            override.returns(
              {
                certificate_ids: T::Array[String],
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
