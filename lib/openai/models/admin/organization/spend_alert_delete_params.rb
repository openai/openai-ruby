# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::SpendAlerts#delete
        class SpendAlertDeleteParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute alert_id
          #
          #   @return [String]
          required :alert_id, String

          # @!method initialize(alert_id:, request_options: {})
          #   @param alert_id [String]
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
