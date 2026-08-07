# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Certificates#create
        class Certificate < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The identifier, which can be referenced in API endpoints
          #
          #   @return [String]
          required :id, String

          # @!attribute certificate_details
          #
          #   @return [OpenAI::Models::Admin::Organization::Certificate::CertificateDetails]
          required :certificate_details, -> { OpenAI::Admin::Organization::Certificate::CertificateDetails }

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
          #   The object type.
          #
          #   - If creating, updating, or getting a specific certificate, the object type is
          #     `certificate`.
          #   - If listing, activating, or deactivating certificates for the organization, the
          #     object type is `organization.certificate`.
          #   - If listing, activating, or deactivating certificates for a project, the object
          #     type is `organization.project.certificate`.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::Certificate::Object]
          required :object, enum: -> { OpenAI::Admin::Organization::Certificate::Object }

          # @!attribute active
          #   Whether the certificate is currently active at the specified scope. Not returned
          #   when getting details for a specific certificate.
          #
          #   @return [Boolean, nil]
          optional :active, OpenAI::Internal::Type::Boolean

          # @!method initialize(id:, certificate_details:, created_at:, name:, object:, active: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::Certificate} for more details.
          #
          #   Represents an individual `certificate` uploaded to the organization.
          #
          #   @param id [String] The identifier, which can be referenced in API endpoints
          #
          #   @param certificate_details [OpenAI::Models::Admin::Organization::Certificate::CertificateDetails]
          #
          #   @param created_at [Integer] The Unix timestamp (in seconds) of when the certificate was uploaded.
          #
          #   @param name [String, nil] The name of the certificate.
          #
          #   @param object [Symbol, OpenAI::Models::Admin::Organization::Certificate::Object] The object type.
          #
          #   @param active [Boolean] Whether the certificate is currently active at the specified scope. Not returned

          # @see OpenAI::Models::Admin::Organization::Certificate#certificate_details
          class CertificateDetails < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   The content of the certificate in PEM format.
            #
            #   @return [String, nil]
            optional :content, String

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

            # @!method initialize(content: nil, expires_at: nil, valid_at: nil)
            #   @param content [String] The content of the certificate in PEM format.
            #
            #   @param expires_at [Integer] The Unix timestamp (in seconds) of when the certificate expires.
            #
            #   @param valid_at [Integer] The Unix timestamp (in seconds) of when the certificate becomes valid.
          end

          # The object type.
          #
          # - If creating, updating, or getting a specific certificate, the object type is
          #   `certificate`.
          # - If listing, activating, or deactivating certificates for the organization, the
          #   object type is `organization.certificate`.
          # - If listing, activating, or deactivating certificates for a project, the object
          #   type is `organization.project.certificate`.
          #
          # @see OpenAI::Models::Admin::Organization::Certificate#object
          module Object
            extend OpenAI::Internal::Type::Enum

            CERTIFICATE = :certificate
            ORGANIZATION_CERTIFICATE = :"organization.certificate"
            ORGANIZATION_PROJECT_CERTIFICATE = :"organization.project.certificate"

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
