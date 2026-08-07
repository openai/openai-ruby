# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Certificates#list
        class CertificateListResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The identifier, which can be referenced in API endpoints
          #
          #   @return [String]
          required :id, String

          # @!attribute active
          #   Whether the certificate is currently active at the organization level.
          #
          #   @return [Boolean]
          required :active, OpenAI::Internal::Type::Boolean

          # @!attribute certificate_details
          #
          #   @return [OpenAI::Models::Admin::Organization::CertificateListResponse::CertificateDetails]
          required :certificate_details,
                   -> { OpenAI::Models::Admin::Organization::CertificateListResponse::CertificateDetails }

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
          #   The object type, which is always `organization.certificate`.
          #
          #   @return [Symbol, :"organization.certificate"]
          required :object, const: :"organization.certificate"

          # @!method initialize(id:, active:, certificate_details:, created_at:, name:, object: :"organization.certificate")
          #   Represents an individual certificate configured at the organization level.
          #
          #   @param id [String] The identifier, which can be referenced in API endpoints
          #
          #   @param active [Boolean] Whether the certificate is currently active at the organization level.
          #
          #   @param certificate_details [OpenAI::Models::Admin::Organization::CertificateListResponse::CertificateDetails]
          #
          #   @param created_at [Integer] The Unix timestamp (in seconds) of when the certificate was uploaded.
          #
          #   @param name [String, nil] The name of the certificate.
          #
          #   @param object [Symbol, :"organization.certificate"] The object type, which is always `organization.certificate`.

          # @see OpenAI::Models::Admin::Organization::CertificateListResponse#certificate_details
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
