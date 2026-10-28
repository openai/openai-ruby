# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::ExternalKeys#create
        class ExternalKey < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #
          #   @return [String]
          required :id, String

          # @!attribute api_project_ids
          #
          #   @return [Array<String>]
          required :api_project_ids, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute created_at
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute name
          #
          #   @return [String]
          required :name, String

          # @!attribute object
          #
          #   @return [String]
          required :object, String

          # @!attribute type
          #
          #   @return [String]
          required :type, String

          # @!attribute workspace_id
          #
          #   @return [String]
          required :workspace_id, String

          # @!attribute audience
          #
          #   @return [String, nil]
          optional :audience, String

          # @!attribute external_id
          #
          #   @return [String, nil]
          optional :external_id, String

          # @!attribute key_name
          #
          #   @return [String, nil]
          optional :key_name, String

          # @!attribute key_version
          #
          #   @return [String, nil]
          optional :key_version, String

          # @!attribute kms_arn
          #
          #   @return [String, nil]
          optional :kms_arn, String

          # @!attribute kms_key_location
          #
          #   @return [String, nil]
          optional :kms_key_location, String

          # @!attribute kms_key_name
          #
          #   @return [String, nil]
          optional :kms_key_name, String

          # @!attribute kms_key_ring_name
          #
          #   @return [String, nil]
          optional :kms_key_ring_name, String

          # @!attribute kms_key_version
          #
          #   @return [String, nil]
          optional :kms_key_version, String

          # @!attribute kms_project_id
          #
          #   @return [String, nil]
          optional :kms_project_id, String

          # @!attribute purpose
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::ExternalKey::Purpose, nil]
          optional :purpose, enum: -> { OpenAI::Admin::Organization::ExternalKey::Purpose }

          # @!attribute role_arn
          #
          #   @return [String, nil]
          optional :role_arn, String

          # @!attribute tenant_id
          #
          #   @return [String, nil]
          optional :tenant_id, String

          # @!attribute vault_uri
          #
          #   @return [String, nil]
          optional :vault_uri, String

          # @!attribute workload_identity_pool_id
          #
          #   @return [String, nil]
          optional :workload_identity_pool_id, String

          # @!attribute workload_identity_project_number
          #
          #   @return [String, nil]
          optional :workload_identity_project_number, String

          # @!attribute workload_identity_provider_id
          #
          #   @return [String, nil]
          optional :workload_identity_provider_id, String

          # @!method initialize(id:, api_project_ids:, created_at:, name:, object:, type:, workspace_id:, audience: nil, external_id: nil, key_name: nil, key_version: nil, kms_arn: nil, kms_key_location: nil, kms_key_name: nil, kms_key_ring_name: nil, kms_key_version: nil, kms_project_id: nil, purpose: nil, role_arn: nil, tenant_id: nil, vault_uri: nil, workload_identity_pool_id: nil, workload_identity_project_number: nil, workload_identity_provider_id: nil)
          #   @param id [String]
          #   @param api_project_ids [Array<String>]
          #   @param created_at [Integer]
          #   @param name [String]
          #   @param object [String]
          #   @param type [String]
          #   @param workspace_id [String]
          #   @param audience [String]
          #   @param external_id [String]
          #   @param key_name [String]
          #   @param key_version [String]
          #   @param kms_arn [String]
          #   @param kms_key_location [String]
          #   @param kms_key_name [String]
          #   @param kms_key_ring_name [String]
          #   @param kms_key_version [String]
          #   @param kms_project_id [String]
          #   @param purpose [Symbol, OpenAI::Models::Admin::Organization::ExternalKey::Purpose]
          #   @param role_arn [String]
          #   @param tenant_id [String]
          #   @param vault_uri [String]
          #   @param workload_identity_pool_id [String]
          #   @param workload_identity_project_number [String]
          #   @param workload_identity_provider_id [String]

          # @see OpenAI::Models::Admin::Organization::ExternalKey#purpose
          module Purpose
            extend OpenAI::Internal::Type::Enum

            EKM = :ekm
            PSP_DECRYPTION = :psp_decryption

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
