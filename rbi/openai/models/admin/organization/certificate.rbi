# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class Certificate < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::Certificate,
                OpenAI::Internal::AnyHash
              )
            end

          # The identifier, which can be referenced in API endpoints
          sig { returns(String) }
          attr_accessor :id

          sig do
            returns(
              OpenAI::Admin::Organization::Certificate::CertificateDetails
            )
          end
          attr_reader :certificate_details

          sig do
            params(
              certificate_details:
                OpenAI::Admin::Organization::Certificate::CertificateDetails::OrHash
            ).void
          end
          attr_writer :certificate_details

          # The Unix timestamp (in seconds) of when the certificate was uploaded.
          sig { returns(Integer) }
          attr_accessor :created_at

          # The name of the certificate.
          sig { returns(String) }
          attr_accessor :name

          # The object type.
          #
          # - If creating, updating, or getting a specific certificate, the object type is
          #   `certificate`.
          # - If listing, activating, or deactivating certificates for the organization, the
          #   object type is `organization.certificate`.
          # - If listing, activating, or deactivating certificates for a project, the object
          #   type is `organization.project.certificate`.
          sig do
            returns(
              OpenAI::Admin::Organization::Certificate::Object::TaggedSymbol
            )
          end
          attr_accessor :object

          # Whether the certificate is currently active at the specified scope. Not returned
          # when getting details for a specific certificate.
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :active

          sig { params(active: T::Boolean).void }
          attr_writer :active

          # Represents an individual `certificate` uploaded to the organization.
          sig do
            params(
              id: String,
              certificate_details:
                OpenAI::Admin::Organization::Certificate::CertificateDetails::OrHash,
              created_at: Integer,
              name: String,
              object:
                OpenAI::Admin::Organization::Certificate::Object::OrSymbol,
              active: T::Boolean
            ).returns(T.attached_class)
          end
          def self.new(
            # The identifier, which can be referenced in API endpoints
            id:,
            certificate_details:,
            # The Unix timestamp (in seconds) of when the certificate was uploaded.
            created_at:,
            # The name of the certificate.
            name:,
            # The object type.
            #
            # - If creating, updating, or getting a specific certificate, the object type is
            #   `certificate`.
            # - If listing, activating, or deactivating certificates for the organization, the
            #   object type is `organization.certificate`.
            # - If listing, activating, or deactivating certificates for a project, the object
            #   type is `organization.project.certificate`.
            object:,
            # Whether the certificate is currently active at the specified scope. Not returned
            # when getting details for a specific certificate.
            active: nil
          )
          end

          sig do
            override.returns(
              {
                id: String,
                certificate_details:
                  OpenAI::Admin::Organization::Certificate::CertificateDetails,
                created_at: Integer,
                name: String,
                object:
                  OpenAI::Admin::Organization::Certificate::Object::TaggedSymbol,
                active: T::Boolean
              }
            )
          end
          def to_hash
          end

          class CertificateDetails < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Certificate::CertificateDetails,
                  OpenAI::Internal::AnyHash
                )
              end

            # The content of the certificate in PEM format.
            sig { returns(T.nilable(String)) }
            attr_reader :content

            sig { params(content: String).void }
            attr_writer :content

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
              params(
                content: String,
                expires_at: Integer,
                valid_at: Integer
              ).returns(T.attached_class)
            end
            def self.new(
              # The content of the certificate in PEM format.
              content: nil,
              # The Unix timestamp (in seconds) of when the certificate expires.
              expires_at: nil,
              # The Unix timestamp (in seconds) of when the certificate becomes valid.
              valid_at: nil
            )
            end

            sig do
              override.returns(
                { content: String, expires_at: Integer, valid_at: Integer }
              )
            end
            def to_hash
            end
          end

          # The object type.
          #
          # - If creating, updating, or getting a specific certificate, the object type is
          #   `certificate`.
          # - If listing, activating, or deactivating certificates for the organization, the
          #   object type is `organization.certificate`.
          # - If listing, activating, or deactivating certificates for a project, the object
          #   type is `organization.project.certificate`.
          module Object
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Admin::Organization::Certificate::Object)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            CERTIFICATE =
              T.let(
                :certificate,
                OpenAI::Admin::Organization::Certificate::Object::TaggedSymbol
              )
            ORGANIZATION_CERTIFICATE =
              T.let(
                :"organization.certificate",
                OpenAI::Admin::Organization::Certificate::Object::TaggedSymbol
              )
            ORGANIZATION_PROJECT_CERTIFICATE =
              T.let(
                :"organization.project.certificate",
                OpenAI::Admin::Organization::Certificate::Object::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::Certificate::Object::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
