# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        class OneTimeAutomation < OpenAI::Internal::Type::BaseModel
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

          # @!attribute run_at
          #   The Unix timestamp, in seconds, of the scheduled occurrence.
          #
          #   @return [Integer]
          required :run_at, Integer

          # @!attribute status
          #   Completion means the schedule has finished, not the agent's work.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Agents::OneTimeAutomation::Status]
          required :status, enum: -> { OpenAI::Beta::Agents::OneTimeAutomation::Status }

          # @!attribute target
          #   The session configuration or existing session receiving invocations.
          #
          #   @return [OpenAI::Models::Beta::Agents::AutomationTarget::NewSession, OpenAI::Models::Beta::Agents::AutomationTarget::ExistingSession]
          required :target, union: -> { OpenAI::Beta::Agents::AutomationTarget }

          # @!attribute type
          #   The type of the object. Always `once`.
          #
          #   @return [Symbol, :once]
          required :type, const: :once

          # @!method initialize(id:, created_at:, created_by:, metadata:, name:, run_at:, status:, target:, object: :"agent.automation", type: :once)
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
          #   @param metadata [Hash{Symbol=>String}]
          #     Custom string key-value pairs attached to the automation.
          #
          #   @param name [String]
          #     The automation's display name.
          #
          #   @param run_at [Integer]
          #     The Unix timestamp, in seconds, of the scheduled occurrence.
          #
          #   @param status [Symbol, OpenAI::Models::Beta::Agents::OneTimeAutomation::Status]
          #     Completion means the schedule has finished, not the agent's work.
          #
          #   @param target [OpenAI::Models::Beta::Agents::AutomationTarget::NewSession, OpenAI::Models::Beta::Agents::AutomationTarget::ExistingSession]
          #     The session configuration or existing session receiving invocations.
          #
          #   @param object [Symbol, :"agent.automation"]
          #     Always `agent.automation`.
          #
          #   @param type [Symbol, :once]
          #     The type of the object. Always `once`.

          # Completion means the schedule has finished, not the agent's work.
          #
          # @see OpenAI::Models::Beta::Agents::OneTimeAutomation#status
          module Status
            extend OpenAI::Internal::Type::Enum

            ACTIVE = :active
            PAUSED = :paused
            COMPLETED = :completed

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
