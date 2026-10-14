# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class CertificateListResponse < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::Projects::CertificateListResponse,
                  OpenAI::Internal::AnyHash
                )
              end

            # The identifier, which can be referenced in API endpoints
            sig { returns(String) }
            attr_accessor :id

            # Whether the certificate is currently active at the project level.
            sig { returns(T::Boolean) }
            attr_accessor :active

            sig do
              returns(
                OpenAI::Models::Admin::Organization::Projects::CertificateListResponse::CertificateDetails
              )
            end
            attr_reader :certificate_details

            sig do
              params(
                certificate_details:
                  OpenAI::Models::Admin::Organization::Projects::CertificateListResponse::CertificateDetails::OrHash
              ).void
            end
            attr_writer :certificate_details

            # The Unix timestamp (in seconds) of when the certificate was uploaded.
            sig { returns(Integer) }
            attr_accessor :created_at

            # The name of the certificate.
            sig { returns(T.nilable(String)) }
            attr_accessor :name

            # The object type, which is always `organization.project.certificate`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Represents an individual certificate configured at the project level.
            sig do
              params(
                id: String,
                active: T::Boolean,
                certificate_details:
                  OpenAI::Models::Admin::Organization::Projects::CertificateListResponse::CertificateDetails::OrHash,
                created_at: Integer,
                name: T.nilable(String),
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The identifier, which can be referenced in API endpoints
              id:,
              # Whether the certificate is currently active at the project level.
              active:,
              certificate_details:,
              # The Unix timestamp (in seconds) of when the certificate was uploaded.
              created_at:,
              # The name of the certificate.
              name:,
              # The object type, which is always `organization.project.certificate`.
              object: :"organization.project.certificate"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  active: T::Boolean,
                  certificate_details:
                    OpenAI::Models::Admin::Organization::Projects::CertificateListResponse::CertificateDetails,
                  created_at: Integer,
                  name: T.nilable(String),
                  object: Symbol
                }
              )
            end
            def to_hash
            end

            class CertificateDetails < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::Projects::CertificateListResponse::CertificateDetails,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The Unix timestamp (in seconds) of when the certificate expires.
              sig { returns(T.nilable(Integer)) }
              attr_reader :expires_at

              sig { params(expires_at: Integer).void }
              attr_writer :expires_at

              # The Unix timestamp (in seconds) of when the certificate becomes valid.
              sig { returns(T.nilable(Integer)) }
              attr_reader :valid_at

              sig { params(valid_at: Integer).void }
              attr_writer :valid_at

              sig do
                params(expires_at: Integer, valid_at: Integer).returns(
                  T.attached_class
                )
              end
              def self.new(
                # The Unix timestamp (in seconds) of when the certificate expires.
                expires_at: nil,
                # The Unix timestamp (in seconds) of when the certificate becomes valid.
                valid_at: nil
              )
              end

              sig do
                override.returns({ expires_at: Integer, valid_at: Integer })
              end
              def to_hash
              end
            end
          end
        end
      end
    end
  end
end
