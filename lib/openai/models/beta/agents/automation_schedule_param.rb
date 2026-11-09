# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # Creates an automation without invoking it immediately.
        module AutomationScheduleParam
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :periodic, -> { OpenAI::Beta::Agents::AutomationScheduleParam::Periodic }

          variant :once, -> { OpenAI::Beta::Agents::AutomationScheduleParam::Once }

          class Periodic < OpenAI::Internal::Type::BaseModel
            # @!attribute expression
            #   A standard five-field cron expression defining scheduled occurrences.
            #
            #   @return [String]
            required :expression, String

            # @!attribute name
            #   A human-readable name for the automation.
            #
            #   @return [String]
            required :name, String

            # @!attribute target
            #   The session an automation invocation targets.
            #
            #   @return [OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession, OpenAI::Models::Beta::Agents::AutomationTargetParam::ExistingSession]
            required :target, union: -> { OpenAI::Beta::Agents::AutomationTargetParam }

            # @!attribute timezone
            #   The IANA timezone used to interpret the cron expression.
            #
            #   @return [String]
            required :timezone, String

            # @!attribute type
            #   The type of the object. Always `periodic`.
            #
            #   @return [Symbol, :periodic]
            required :type, const: :periodic

            # @!attribute metadata
            #
            #   @return [Hash{Symbol=>String}, nil]
            optional :metadata, OpenAI::Internal::Type::HashOf[String]

            # @!method initialize(expression:, name:, target:, timezone:, metadata: nil, type: :periodic)
            #   @param expression [String]
            #     A standard five-field cron expression defining scheduled occurrences.
            #
            #   @param name [String]
            #     A human-readable name for the automation.
            #
            #   @param target [OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession, OpenAI::Models::Beta::Agents::AutomationTargetParam::ExistingSession]
            #     The session an automation invocation targets.
            #
            #   @param timezone [String]
            #     The IANA timezone used to interpret the cron expression.
            #
            #   @param metadata [Hash{Symbol=>String}]
            #
            #   @param type [Symbol, :periodic]
            #     The type of the object. Always `periodic`.
          end

          class Once < OpenAI::Internal::Type::BaseModel
            # @!attribute name
            #   A human-readable name for the automation.
            #
            #   @return [String]
            required :name, String

            # @!attribute run_at
            #   A future Unix timestamp in seconds.
            #
            #   @return [Integer]
            required :run_at, Integer

            # @!attribute target
            #   The session an automation invocation targets.
            #
            #   @return [OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession, OpenAI::Models::Beta::Agents::AutomationTargetParam::ExistingSession]
            required :target, union: -> { OpenAI::Beta::Agents::AutomationTargetParam }

            # @!attribute type
            #   The type of the object. Always `once`.
            #
            #   @return [Symbol, :once]
            required :type, const: :once

            # @!attribute metadata
            #
            #   @return [Hash{Symbol=>String}, nil]
            optional :metadata, OpenAI::Internal::Type::HashOf[String]

            # @!method initialize(name:, run_at:, target:, metadata: nil, type: :once)
            #   @param name [String]
            #     A human-readable name for the automation.
            #
            #   @param run_at [Integer]
            #     A future Unix timestamp in seconds.
            #
            #   @param target [OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession, OpenAI::Models::Beta::Agents::AutomationTargetParam::ExistingSession]
            #     The session an automation invocation targets.
            #
            #   @param metadata [Hash{Symbol=>String}]
            #
            #   @param type [Symbol, :once]
            #     The type of the object. Always `once`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::Agents::AutomationScheduleParam::Periodic, OpenAI::Models::Beta::Agents::AutomationScheduleParam::Once)]
        end
      end
    end
  end
end
