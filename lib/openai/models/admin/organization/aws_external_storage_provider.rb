# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        class AwsExternalStorageProvider < OpenAI::Internal::Type::BaseModel
          # @!attribute account_id
          #
          #   @return [String]
          required :account_id, String

          # @!attribute bucket
          #
          #   @return [String]
          required :bucket, String

          # @!attribute external_id
          #
          #   @return [String]
          required :external_id, String

          # @!attribute region
          #
          #   @return [String]
          required :region, String

          # @!attribute role_arn
          #
          #   @return [String]
          required :role_arn, String

          # @!attribute type
          #
          #   @return [Symbol, :aws]
          required :type, const: :aws

          # @!method initialize(account_id:, bucket:, external_id:, region:, role_arn:, type: :aws)
          #   @param account_id [String]
          #   @param bucket [String]
          #   @param external_id [String]
          #   @param region [String]
          #   @param role_arn [String]
          #   @param type [Symbol, :aws]
        end
      end
    end
  end
end
