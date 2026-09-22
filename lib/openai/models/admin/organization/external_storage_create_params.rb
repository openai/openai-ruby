# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::ExternalStorage#create
        class ExternalStorageCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute project_id
          #
          #   @return [String]
          required :project_id, String

          # @!attribute provider
          #
          #   @return [OpenAI::Models::Admin::Organization::ExternalStorageCreateParams::Provider::Aws, OpenAI::Models::Admin::Organization::ExternalStorageCreateParams::Provider::Azure, OpenAI::Models::Admin::Organization::ExternalStorageCreateParams::Provider::Gcp]
          required :provider, union: -> { OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider }

          # @!method initialize(project_id:, provider:, request_options: {})
          #   @param project_id [String]
          #   @param provider [OpenAI::Models::Admin::Organization::ExternalStorageCreateParams::Provider::Aws, OpenAI::Models::Admin::Organization::ExternalStorageCreateParams::Provider::Azure, OpenAI::Models::Admin::Organization::ExternalStorageCreateParams::Provider::Gcp]
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          module Provider
            extend OpenAI::Internal::Type::Union

            discriminator :type

            variant :aws, -> { OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Aws }

            variant :azure, -> { OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Azure }

            variant :gcp, -> { OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Gcp }

            class Aws < OpenAI::Internal::Type::BaseModel
              # @!attribute bucket
              #
              #   @return [String]
              required :bucket, String

              # @!attribute role_arn
              #
              #   @return [String]
              required :role_arn, String

              # @!attribute type
              #
              #   @return [Symbol, :aws]
              required :type, const: :aws

              # @!method initialize(bucket:, role_arn:, type: :aws)
              #   @param bucket [String]
              #   @param role_arn [String]
              #   @param type [Symbol, :aws]
            end

            class Azure < OpenAI::Internal::Type::BaseModel
              # @!attribute account_name
              #
              #   @return [String]
              required :account_name, String

              # @!attribute container
              #
              #   @return [String]
              required :container, String

              # @!attribute resource_group
              #
              #   @return [String]
              required :resource_group, String

              # @!attribute subscription_id
              #
              #   @return [String]
              required :subscription_id, String

              # @!attribute tenant_id
              #
              #   @return [String]
              required :tenant_id, String

              # @!attribute type
              #
              #   @return [Symbol, :azure]
              required :type, const: :azure

              # @!method initialize(account_name:, container:, resource_group:, subscription_id:, tenant_id:, type: :azure)
              #   @param account_name [String]
              #   @param container [String]
              #   @param resource_group [String]
              #   @param subscription_id [String]
              #   @param tenant_id [String]
              #   @param type [Symbol, :azure]
            end

            class Gcp < OpenAI::Internal::Type::BaseModel
              # @!attribute bucket
              #
              #   @return [String]
              required :bucket, String

              # @!attribute type
              #
              #   @return [Symbol, :gcp]
              required :type, const: :gcp

              # @!attribute workload_identity_pool_id
              #
              #   @return [String]
              required :workload_identity_pool_id, String

              # @!attribute workload_identity_project_number
              #
              #   @return [String]
              required :workload_identity_project_number, String

              # @!attribute workload_identity_provider_id
              #
              #   @return [String]
              required :workload_identity_provider_id, String

              # @!method initialize(bucket:, workload_identity_pool_id:, workload_identity_project_number:, workload_identity_provider_id:, type: :gcp)
              #   @param bucket [String]
              #   @param workload_identity_pool_id [String]
              #   @param workload_identity_project_number [String]
              #   @param workload_identity_provider_id [String]
              #   @param type [Symbol, :gcp]
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Admin::Organization::ExternalStorageCreateParams::Provider::Aws, OpenAI::Models::Admin::Organization::ExternalStorageCreateParams::Provider::Azure, OpenAI::Models::Admin::Organization::ExternalStorageCreateParams::Provider::Gcp)]
          end
        end
      end
    end
  end
end
