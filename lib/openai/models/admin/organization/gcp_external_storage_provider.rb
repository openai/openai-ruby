# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        class GcpExternalStorageProvider < OpenAI::Internal::Type::BaseModel
          # @!attribute audience
          #
          #   @return [String]
          required :audience, String

          # @!attribute bucket
          #
          #   @return [String]
          required :bucket, String

          # @!attribute region
          #
          #   @return [String]
          required :region, String

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

          # @!method initialize(audience:, bucket:, region:, workload_identity_pool_id:, workload_identity_project_number:, workload_identity_provider_id:, type: :gcp)
          #   @param audience [String]
          #   @param bucket [String]
          #   @param region [String]
          #   @param workload_identity_pool_id [String]
          #   @param workload_identity_project_number [String]
          #   @param workload_identity_provider_id [String]
          #   @param type [Symbol, :gcp]
        end
      end
    end
  end
end
