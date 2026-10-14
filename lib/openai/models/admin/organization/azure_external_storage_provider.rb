# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        class AzureExternalStorageProvider < OpenAI::Internal::Type::BaseModel
          # @!attribute account_name
          #
          #   @return [String]
          required :account_name, String

          # @!attribute container
          #
          #   @return [String]
          required :container, String

          # @!attribute region
          #
          #   @return [String]
          required :region, String

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

          # @!method initialize(account_name:, container:, region:, resource_group:, subscription_id:, tenant_id:, type: :azure)
          #   @param account_name [String]
          #   @param container [String]
          #   @param region [String]
          #   @param resource_group [String]
          #   @param subscription_id [String]
          #   @param tenant_id [String]
          #   @param type [Symbol, :azure]
        end
      end
    end
  end
end
