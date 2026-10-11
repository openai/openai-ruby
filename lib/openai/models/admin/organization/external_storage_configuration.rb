# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::ExternalStorage#create
        class ExternalStorageConfiguration < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #
          #   @return [String]
          required :id, String

          # @!attribute created_at
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute geography
          #
          #   @return [String]
          required :geography, String

          # @!attribute object
          #
          #   @return [Symbol, :"organization.external_storage"]
          required :object, const: :"organization.external_storage"

          # @!attribute project_id
          #
          #   @return [String]
          required :project_id, String

          # @!attribute provider
          #
          #   @return [OpenAI::Models::Admin::Organization::AwsExternalStorageProvider, OpenAI::Models::Admin::Organization::AzureExternalStorageProvider, OpenAI::Models::Admin::Organization::GcpExternalStorageProvider, OpenAI::Models::Admin::Organization::ExternalStorageConfiguration::Provider::Oci]
          required :provider, union: -> { OpenAI::Admin::Organization::ExternalStorageConfiguration::Provider }

          # @!attribute status
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::ExternalStorageConfiguration::Status]
          required :status, enum: -> { OpenAI::Admin::Organization::ExternalStorageConfiguration::Status }

          # @!method initialize(id:, created_at:, geography:, project_id:, provider:, status:, object: :"organization.external_storage")
          #   @param id [String]
          #   @param created_at [Integer]
          #   @param geography [String]
          #   @param project_id [String]
          #   @param provider [OpenAI::Models::Admin::Organization::AwsExternalStorageProvider, OpenAI::Models::Admin::Organization::AzureExternalStorageProvider, OpenAI::Models::Admin::Organization::GcpExternalStorageProvider, OpenAI::Models::Admin::Organization::ExternalStorageConfiguration::Provider::Oci]
          #   @param status [Symbol, OpenAI::Models::Admin::Organization::ExternalStorageConfiguration::Status]
          #   @param object [Symbol, :"organization.external_storage"]

          # @see OpenAI::Models::Admin::Organization::ExternalStorageConfiguration#provider
          module Provider
            extend OpenAI::Internal::Type::Union

            discriminator :type

            variant :aws, -> { OpenAI::Admin::Organization::AwsExternalStorageProvider }

            variant :azure, -> { OpenAI::Admin::Organization::AzureExternalStorageProvider }

            variant :gcp, -> { OpenAI::Admin::Organization::GcpExternalStorageProvider }

            variant :oci, -> { OpenAI::Admin::Organization::ExternalStorageConfiguration::Provider::Oci }

            class Oci < OpenAI::Internal::Type::BaseModel
              # @!attribute bucket
              #
              #   @return [String]
              required :bucket, String

              # @!attribute region
              #
              #   @return [String]
              required :region, String

              # @!attribute tenancy_ocid
              #
              #   @return [String]
              required :tenancy_ocid, String

              # @!attribute type
              #
              #   @return [Symbol, :oci]
              required :type, const: :oci

              # @!method initialize(bucket:, region:, tenancy_ocid:, type: :oci)
              #   @param bucket [String]
              #   @param region [String]
              #   @param tenancy_ocid [String]
              #   @param type [Symbol, :oci]
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Admin::Organization::AwsExternalStorageProvider, OpenAI::Models::Admin::Organization::AzureExternalStorageProvider, OpenAI::Models::Admin::Organization::GcpExternalStorageProvider, OpenAI::Models::Admin::Organization::ExternalStorageConfiguration::Provider::Oci)]
          end

          # @see OpenAI::Models::Admin::Organization::ExternalStorageConfiguration#status
          module Status
            extend OpenAI::Internal::Type::Enum

            PENDING = :pending
            VALIDATED = :validated
            UNHEALTHY = :unhealthy

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
