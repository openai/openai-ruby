# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class CertificateCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::CertificateCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

          # The certificate content in PEM format
          sig { returns(String) }
          attr_accessor :content

          # An optional name for the certificate
          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          sig do
            params(
              content: String,
              name: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The certificate content in PEM format
            content:,
            # An optional name for the certificate
            name: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                content: String,
                name: String,
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
