# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::DataRetention#update
        class DataRetentionUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute retention_type
          #   The desired organization data retention type.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::DataRetentionUpdateParams::RetentionType]
          required :retention_type,
                   enum: -> { OpenAI::Admin::Organization::DataRetentionUpdateParams::RetentionType }

          # @!method initialize(retention_type:, request_options: {})
          #   @param retention_type [Symbol, OpenAI::Models::Admin::Organization::DataRetentionUpdateParams::RetentionType] The desired organization data retention type.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # The desired organization data retention type.
          module RetentionType
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
    end
  end
end
