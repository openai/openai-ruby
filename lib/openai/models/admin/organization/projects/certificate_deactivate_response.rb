# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::Certificates#deactivate
          class CertificateDeactivateResponse < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier, which can be referenced in API endpoints
            #
            #   @return [String]
            required :id, String

            # @!attribute active
            #   Whether the certificate is currently active at the project level.
            #
            #   @return [Boolean]
            required :active, OpenAI::Internal::Type::Boolean

            # @!attribute certificate_details
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::CertificateDeactivateResponse::CertificateDetails]
            required :certificate_details,
                     -> { OpenAI::Models::Admin::Organization::Projects::CertificateDeactivateResponse::CertificateDetails }

            # @!attribute created_at
            #   The Unix timestamp (in seconds) of when the certificate was uploaded.
            #
            #   @return [Integer]
            required :created_at, Integer

            # @!attribute name
            #   The name of the certificate.
            #
            #   @return [String, nil]
            required :name, String, nil?: true

            # @!attribute object
            #   The object type, which is always `organization.project.certificate`.
            #
            #   @return [Symbol, :"organization.project.certificate"]
            required :object, const: :"organization.project.certificate"

            # @!method initialize(id:, active:, certificate_details:, created_at:, name:, object: :"organization.project.certificate")
            #   Represents an individual certificate configured at the project level.
            #
            #   @param id [String] The identifier, which can be referenced in API endpoints
            #
            #   @param active [Boolean] Whether the certificate is currently active at the project level.
            #
            #   @param certificate_details [OpenAI::Models::Admin::Organization::Projects::CertificateDeactivateResponse::CertificateDetails]
            #
            #   @param created_at [Integer] The Unix timestamp (in seconds) of when the certificate was uploaded.
            #
            #   @param name [String, nil] The name of the certificate.
            #
            #   @param object [Symbol, :"organization.project.certificate"] The object type, which is always `organization.project.certificate`.

            # @see OpenAI::Models::Admin::Organization::Projects::CertificateDeactivateResponse#certificate_details
            class CertificateDetails < OpenAI::Internal::Type::BaseModel
              # @!attribute expires_at
              #   The Unix timestamp (in seconds) of when the certificate expires.
              #
              #   @return [Integer, nil]
              optional :expires_at, Integer

              # @!attribute valid_at
              #   The Unix timestamp (in seconds) of when the certificate becomes valid.
              #
              #   @return [Integer, nil]
              optional :valid_at, Integer

              # @!method initialize(expires_at: nil, valid_at: nil)
              #   @param expires_at [Integer] The Unix timestamp (in seconds) of when the certificate expires.
              #
              #   @param valid_at [Integer] The Unix timestamp (in seconds) of when the certificate becomes valid.
            end
          end
        end
      end
    end
  end
end
