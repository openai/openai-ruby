# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::ExternalKeys#create
        class ExternalKeyCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute body
          #
          #   @return [OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Aws, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Gcp, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Azure]
          required :body, union: -> { OpenAI::Admin::Organization::ExternalKeyCreateParams::Body }

          # @!method initialize(body:, request_options: {})
          #   @param body [OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Aws, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Gcp, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Azure]
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          module Body
            extend OpenAI::Internal::Type::Union

            discriminator :type

            variant :aws, -> { OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws }

            variant :gcp, -> { OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp }

            variant :azure, -> { OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure }

            class Aws < OpenAI::Internal::Type::BaseModel
              # @!attribute external_id
              #   The ExternalID that OpenAI will pass in the AssumeRole call for the customer's
              #   AWS account. This must be the OpenAI organization ID or an API project ID that
              #   belongs to the organization.
              #
              #   @return [String]
              required :external_id, String

              # @!attribute kms_arn
              #   The Key Management System ARN for the master key you manage
              #
              #   @return [String]
              required :kms_arn, String

              # @!attribute name
              #   A friendly name to identify this config
              #
              #   @return [String]
              required :name, String

              # @!attribute role_arn
              #   The Role ARN that OpenAI will assume to call your KMS
              #
              #   @return [String]
              required :role_arn, String

              # @!attribute type
              #
              #   @return [Symbol, :aws]
              required :type, const: :aws

              # @!attribute purpose
              #
              #   @return [Symbol, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Aws::Purpose, nil]
              optional :purpose, enum: -> { OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws::Purpose }

              # @!method initialize(external_id:, kms_arn:, name:, role_arn:, purpose: nil, type: :aws)
              #   @param external_id [String]
              #     The ExternalID that OpenAI will pass in the AssumeRole call for the customer's
              #     AWS account. This must be the OpenAI organization ID or an API project ID that
              #     belongs to the organization.
              #
              #   @param kms_arn [String]
              #     The Key Management System ARN for the master key you manage
              #
              #   @param name [String]
              #     A friendly name to identify this config
              #
              #   @param role_arn [String]
              #     The Role ARN that OpenAI will assume to call your KMS
              #
              #   @param purpose [Symbol, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Aws::Purpose]
              #
              #   @param type [Symbol, :aws]

              # @see OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Aws#purpose
              module Purpose
                extend OpenAI::Internal::Type::Enum

                EKM = :ekm
                PSP_DECRYPTION = :psp_decryption

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end

            class Gcp < OpenAI::Internal::Type::BaseModel
              # @!attribute audience
              #   The aud field in the identity token OpenAI will pass in the call to the
              #   customer's GCP STS. This must be the OpenAI organization ID or an API project ID
              #   that belongs to the organization.
              #
              #   @return [String]
              required :audience, String

              # @!attribute kms_key_location
              #   The region where your Key Management System master key is located
              #
              #   @return [String]
              required :kms_key_location, String

              # @!attribute kms_key_name
              #   The name of the Key Management System master key you manage
              #
              #   @return [String]
              required :kms_key_name, String

              # @!attribute kms_key_ring_name
              #   The Key Management System key ring for the master key you manage
              #
              #   @return [String]
              required :kms_key_ring_name, String

              # @!attribute kms_project_id
              #   The string GCP project name where your KMS resides
              #
              #   @return [String]
              required :kms_project_id, String

              # @!attribute name
              #   A friendly name to identify this config
              #
              #   @return [String]
              required :name, String

              # @!attribute type
              #
              #   @return [Symbol, :gcp]
              required :type, const: :gcp

              # @!attribute workload_identity_pool_id
              #   The pool containing the Workload Identity provider that you registered for
              #   OpenAI
              #
              #   @return [String]
              required :workload_identity_pool_id, String

              # @!attribute workload_identity_project_number
              #   The numeric GCP project number where you registered OpenAI's workload identity
              #
              #   @return [String]
              required :workload_identity_project_number, String

              # @!attribute workload_identity_provider_id
              #   The Workload Identity provider that you registered for OpenAI
              #
              #   @return [String]
              required :workload_identity_provider_id, String

              # @!attribute kms_key_version
              #   An exact CryptoKeyVersion number. Required for PSP decryption; not accepted for
              #   EKM.
              #
              #   @return [String, nil]
              optional :kms_key_version, String

              # @!attribute purpose
              #
              #   @return [Symbol, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Gcp::Purpose, nil]
              optional :purpose, enum: -> { OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp::Purpose }

              # @!method initialize(audience:, kms_key_location:, kms_key_name:, kms_key_ring_name:, kms_project_id:, name:, workload_identity_pool_id:, workload_identity_project_number:, workload_identity_provider_id:, kms_key_version: nil, purpose: nil, type: :gcp)
              #   @param audience [String]
              #     The aud field in the identity token OpenAI will pass in the call to the
              #     customer's GCP STS. This must be the OpenAI organization ID or an API project ID
              #     that belongs to the organization.
              #
              #   @param kms_key_location [String]
              #     The region where your Key Management System master key is located
              #
              #   @param kms_key_name [String]
              #     The name of the Key Management System master key you manage
              #
              #   @param kms_key_ring_name [String]
              #     The Key Management System key ring for the master key you manage
              #
              #   @param kms_project_id [String]
              #     The string GCP project name where your KMS resides
              #
              #   @param name [String]
              #     A friendly name to identify this config
              #
              #   @param workload_identity_pool_id [String]
              #     The pool containing the Workload Identity provider that you registered for
              #     OpenAI
              #
              #   @param workload_identity_project_number [String]
              #     The numeric GCP project number where you registered OpenAI's workload identity
              #
              #   @param workload_identity_provider_id [String]
              #     The Workload Identity provider that you registered for OpenAI
              #
              #   @param kms_key_version [String]
              #     An exact CryptoKeyVersion number. Required for PSP decryption; not accepted for
              #     EKM.
              #
              #   @param purpose [Symbol, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Gcp::Purpose]
              #
              #   @param type [Symbol, :gcp]

              # @see OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Gcp#purpose
              module Purpose
                extend OpenAI::Internal::Type::Enum

                EKM = :ekm
                PSP_DECRYPTION = :psp_decryption

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end

            class Azure < OpenAI::Internal::Type::BaseModel
              # @!attribute key_name
              #   The name of the Azure Key Vault master key that you manage
              #
              #   @return [String]
              required :key_name, String

              # @!attribute name
              #   A friendly name to identify this config
              #
              #   @return [String]
              required :name, String

              # @!attribute tenant_id
              #   Your Azure tenant UUID
              #
              #   @return [String]
              required :tenant_id, String

              # @!attribute type
              #
              #   @return [Symbol, :azure]
              required :type, const: :azure

              # @!attribute vault_uri
              #   The URI of the Azure vault containing the master key you manage
              #
              #   @return [String]
              required :vault_uri, String

              # @!attribute key_version
              #   An exact Azure Key Vault key version. Required for PSP decryption; not accepted
              #   for EKM.
              #
              #   @return [String, nil]
              optional :key_version, String

              # @!attribute purpose
              #
              #   @return [Symbol, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Azure::Purpose, nil]
              optional(
                :purpose,
                enum: -> { OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure::Purpose }
              )

              # @!method initialize(key_name:, name:, tenant_id:, vault_uri:, key_version: nil, purpose: nil, type: :azure)
              #   @param key_name [String]
              #     The name of the Azure Key Vault master key that you manage
              #
              #   @param name [String]
              #     A friendly name to identify this config
              #
              #   @param tenant_id [String]
              #     Your Azure tenant UUID
              #
              #   @param vault_uri [String]
              #     The URI of the Azure vault containing the master key you manage
              #
              #   @param key_version [String]
              #     An exact Azure Key Vault key version. Required for PSP decryption; not accepted
              #     for EKM.
              #
              #   @param purpose [Symbol, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Azure::Purpose]
              #
              #   @param type [Symbol, :azure]

              # @see OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Azure#purpose
              module Purpose
                extend OpenAI::Internal::Type::Enum

                EKM = :ekm
                PSP_DECRYPTION = :psp_decryption

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Aws, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Gcp, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Azure)]
          end
        end
      end
    end
  end
end
