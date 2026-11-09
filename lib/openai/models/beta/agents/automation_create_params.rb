# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Automations#create
        class AutomationCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute create_automation_params
          #   Creates an automation without invoking it immediately.
          #
          #   @return [OpenAI::Models::Beta::Agents::AutomationScheduleParam::Periodic, OpenAI::Models::Beta::Agents::AutomationScheduleParam::Once]
          required :create_automation_params, union: -> { OpenAI::Beta::Agents::AutomationScheduleParam }

          # @!method initialize(create_automation_params:, request_options: {})
          #   @param create_automation_params [OpenAI::Models::Beta::Agents::AutomationScheduleParam::Periodic, OpenAI::Models::Beta::Agents::AutomationScheduleParam::Once]
          #     Creates an automation without invoking it immediately.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
