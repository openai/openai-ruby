# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        class PeriodicAutomation < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The automation ID.
          #
          #   @return [String]
          required :id, String

          # @!attribute created_at
          #   The creation time as a Unix timestamp in seconds.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute created_by
          #   Service-recorded provenance; callers cannot supply this field.
          #
          #   @return [OpenAI::Models::Beta::Agents::AutomationCreatedBy::Developer, OpenAI::Models::Beta::Agents::AutomationCreatedBy::Agent]
          required :created_by, union: -> { OpenAI::Beta::Agents::AutomationCreatedBy }

          # @!attribute expression
          #   The cron expression determining scheduled occurrences.
          #
          #   @return [String]
          required :expression, String

          # @!attribute metadata
          #   Custom string key-value pairs attached to the automation.
          #
          #   @return [Hash{Symbol=>String}]
          required :metadata, OpenAI::Internal::Type::HashOf[String]

          # @!attribute name
          #   The automation's display name.
          #
          #   @return [String]
          required :name, String

          # @!attribute object
          #   Always `agent.automation`.
          #
          #   @return [Symbol, :"agent.automation"]
          required :object, const: :"agent.automation"

          # @!attribute status
          #   Whether scheduled delivery is active or paused.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Agents::PeriodicAutomation::Status]
          required :status, enum: -> { OpenAI::Beta::Agents::PeriodicAutomation::Status }

          # @!attribute target
          #   The session configuration or existing session receiving invocations.
          #
          #   @return [OpenAI::Models::Beta::Agents::AutomationTarget::NewSession, OpenAI::Models::Beta::Agents::AutomationTarget::ExistingSession]
          required :target, union: -> { OpenAI::Beta::Agents::AutomationTarget }

          # @!attribute timezone
          #   The timezone used to interpret the expression.
          #
          #   @return [String]
          required :timezone, String

          # @!attribute type
          #   The type of the object. Always `periodic`.
          #
          #   @return [Symbol, :periodic]
          required :type, const: :periodic

          # @!method initialize(id:, created_at:, created_by:, expression:, metadata:, name:, status:, target:, timezone:, object: :"agent.automation", type: :periodic)
          #   Fields shared by periodic and one-time automations.
          #
          #   @param id [String]
          #     The automation ID.
          #
          #   @param created_at [Integer]
          #     The creation time as a Unix timestamp in seconds.
          #
          #   @param created_by [OpenAI::Models::Beta::Agents::AutomationCreatedBy::Developer, OpenAI::Models::Beta::Agents::AutomationCreatedBy::Agent]
          #     Service-recorded provenance; callers cannot supply this field.
          #
          #   @param expression [String]
          #     The cron expression determining scheduled occurrences.
          #
          #   @param metadata [Hash{Symbol=>String}]
          #     Custom string key-value pairs attached to the automation.
          #
          #   @param name [String]
          #     The automation's display name.
          #
          #   @param status [Symbol, OpenAI::Models::Beta::Agents::PeriodicAutomation::Status]
          #     Whether scheduled delivery is active or paused.
          #
          #   @param target [OpenAI::Models::Beta::Agents::AutomationTarget::NewSession, OpenAI::Models::Beta::Agents::AutomationTarget::ExistingSession]
          #     The session configuration or existing session receiving invocations.
          #
          #   @param timezone [String]
          #     The timezone used to interpret the expression.
          #
          #   @param object [Symbol, :"agent.automation"]
          #     Always `agent.automation`.
          #
          #   @param type [Symbol, :periodic]
          #     The type of the object. Always `periodic`.

          # Whether scheduled delivery is active or paused.
          #
          # @see OpenAI::Models::Beta::Agents::PeriodicAutomation#status
          module Status
            extend OpenAI::Internal::Type::Enum

            ACTIVE = :active
            PAUSED = :paused

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
