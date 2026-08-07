# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::DataRetention#update
          class DataRetentionUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute retention_type
            #   The desired project data retention type.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType]
            required :retention_type,
                     enum: -> { OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType }

            # @!method initialize(project_id:, retention_type:, request_options: {})
            #   @param project_id [String]
            #
            #   @param retention_type [Symbol, OpenAI::Models::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType] The desired project data retention type.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # The desired project data retention type.
            module RetentionType
              extend OpenAI::Internal::Type::Enum

              ORGANIZATION_DEFAULT = :organization_default
              NONE = :none
              ZERO_DATA_RETENTION = :zero_data_retention
              MODIFIED_ABUSE_MONITORING = :modified_abuse_monitoring
              ENHANCED_ZERO_DATA_RETENTION = :enhanced_zero_data_retention
              ENHANCED_MODIFIED_ABUSE_MONITORING = :enhanced_modified_abuse_monitoring

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
