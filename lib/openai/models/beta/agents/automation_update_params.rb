# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # @see OpenAI::Resources::Beta::Agents::Automations#update
        class AutomationUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute automation_id
          #
          #   @return [String]
          required :automation_id, String

          # @!attribute expression
          #   Only accepted for periodic automations.
          #
          #   @return [String, nil]
          optional :expression, String

          # @!attribute metadata
          #   Replaces all metadata; omit to leave unchanged.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :metadata, OpenAI::Internal::Type::HashOf[String]

          # @!attribute name
          #
          #   @return [String, nil]
          optional :name, String

          # @!attribute run_at
          #   A future Unix timestamp in seconds; accepted only before a one-time scheduled
          #   invocation exists.
          #
          #   @return [Integer, nil]
          optional :run_at, Integer

          # @!attribute target
          #   Replaces the complete target, retaining its type and any creator session.
          #
          #   @return [OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession, OpenAI::Models::Beta::Agents::AutomationTargetParam::ExistingSession, nil]
          optional :target, union: -> { OpenAI::Beta::Agents::AutomationTargetParam }

          # @!attribute timezone
          #   Only accepted for periodic automations.
          #
          #   @return [String, nil]
          optional :timezone, String

          # @!method initialize(automation_id:, expression: nil, metadata: nil, name: nil, run_at: nil, target: nil, timezone: nil, request_options: {})
          #   @param automation_id [String]
          #
          #   @param expression [String]
          #     Only accepted for periodic automations.
          #
          #   @param metadata [Hash{Symbol=>String}]
          #     Replaces all metadata; omit to leave unchanged.
          #
          #   @param name [String]
          #
          #   @param run_at [Integer]
          #     A future Unix timestamp in seconds; accepted only before a one-time scheduled
          #     invocation exists.
          #
          #   @param target [OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession, OpenAI::Models::Beta::Agents::AutomationTargetParam::ExistingSession]
          #     Replaces the complete target, retaining its type and any creator session.
          #
          #   @param timezone [String]
          #     Only accepted for periodic automations.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
