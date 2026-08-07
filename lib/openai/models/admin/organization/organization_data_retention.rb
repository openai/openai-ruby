# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::DataRetention#retrieve
        class OrganizationDataRetention < OpenAI::Internal::Type::BaseModel
          # @!attribute object
          #   The object type, which is always `organization.data_retention`.
          #
          #   @return [Symbol, :"organization.data_retention"]
          required :object, const: :"organization.data_retention"

          # @!attribute type
          #   The configured organization data retention type.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::OrganizationDataRetention::Type]
          required :type, enum: -> { OpenAI::Admin::Organization::OrganizationDataRetention::Type }

          # @!method initialize(type:, object: :"organization.data_retention")
          #   Represents the organization's data retention control setting.
          #
          #   @param type [Symbol, OpenAI::Models::Admin::Organization::OrganizationDataRetention::Type] The configured organization data retention type.
          #
          #   @param object [Symbol, :"organization.data_retention"] The object type, which is always `organization.data_retention`.

          # The configured organization data retention type.
          #
          # @see OpenAI::Models::Admin::Organization::OrganizationDataRetention#type
          module Type
            extend OpenAI::Internal::Type::Enum

            ZERO_DATA_RETENTION = :zero_data_retention
            MODIFIED_ABUSE_MONITORING = :modified_abuse_monitoring
            ENHANCED_ZERO_DATA_RETENTION = :enhanced_zero_data_retention
            ENHANCED_MODIFIED_ABUSE_MONITORING = :enhanced_modified_abuse_monitoring

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end

      OrganizationDataRetention = Organization::OrganizationDataRetention
    end
  end
end
