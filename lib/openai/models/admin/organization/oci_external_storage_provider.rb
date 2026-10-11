# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        class OciExternalStorageProvider < OpenAI::Internal::Type::BaseModel
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
      end
    end
  end
end
