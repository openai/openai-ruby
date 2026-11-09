# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Automations
          # @see OpenAI::Resources::Beta::Agents::Automations::Invocations#create
          class AutomationInvocation < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The invocation ID.
            #
            #   @return [String]
            required :id, String

            # @!attribute automation_id
            #   The automation that owns the invocation.
            #
            #   @return [String]
            required :automation_id, String

            # @!attribute created_at
            #   The creation time as a Unix timestamp in seconds.
            #
            #   @return [Integer]
            required :created_at, Integer

            # @!attribute error
            #   The permanent delivery failure, or null when no failure occurred.
            #
            #   @return [OpenAI::Models::Beta::Agents::Automations::AutomationInvocation::Error, nil]
            required :error, -> { OpenAI::Beta::Agents::Automations::AutomationInvocation::Error }, nil?: true

            # @!attribute object
            #   Always `agent.automation.invocation`.
            #
            #   @return [Symbol, :"agent.automation.invocation"]
            required :object, const: :"agent.automation.invocation"

            # @!attribute scheduled_at
            #   The intended occurrence as a Unix timestamp in seconds, or null for manual runs.
            #
            #   @return [Integer, nil]
            required :scheduled_at, Integer, nil?: true

            # @!attribute session_id
            #   The target or newly created session ID, or null before one is available.
            #
            #   @return [String, nil]
            required :session_id, String, nil?: true

            # @!attribute skip_reason
            #   Why an occurrence was skipped, or null when it was not skipped.
            #
            #   @return [Symbol, :pending_delivery, nil]
            required :skip_reason, const: :pending_delivery, nil?: true

            # @!attribute source
            #   Whether the invocation was manual or scheduled.
            #
            #   @return [OpenAI::Models::Beta::Agents::Automations::AutomationInvocationSource::Manual, OpenAI::Models::Beta::Agents::Automations::AutomationInvocationSource::Automation]
            required :source, union: -> { OpenAI::Beta::Agents::Automations::AutomationInvocationSource }

            # @!attribute status
            #   Delivery status; completed does not mean the agent's work has finished.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Agents::Automations::AutomationInvocation::Status]
            required :status, enum: -> { OpenAI::Beta::Agents::Automations::AutomationInvocation::Status }

            # @!method initialize(id:, automation_id:, created_at:, error:, scheduled_at:, session_id:, source:, status:, object: :"agent.automation.invocation", skip_reason: :pending_delivery)
            #   One attempted delivery by an automation.
            #
            #   @param id [String]
            #     The invocation ID.
            #
            #   @param automation_id [String]
            #     The automation that owns the invocation.
            #
            #   @param created_at [Integer]
            #     The creation time as a Unix timestamp in seconds.
            #
            #   @param error [OpenAI::Models::Beta::Agents::Automations::AutomationInvocation::Error, nil]
            #     The permanent delivery failure, or null when no failure occurred.
            #
            #   @param scheduled_at [Integer, nil]
            #     The intended occurrence as a Unix timestamp in seconds, or null for manual runs.
            #
            #   @param session_id [String, nil]
            #     The target or newly created session ID, or null before one is available.
            #
            #   @param source [OpenAI::Models::Beta::Agents::Automations::AutomationInvocationSource::Manual, OpenAI::Models::Beta::Agents::Automations::AutomationInvocationSource::Automation]
            #     Whether the invocation was manual or scheduled.
            #
            #   @param status [Symbol, OpenAI::Models::Beta::Agents::Automations::AutomationInvocation::Status]
            #     Delivery status; completed does not mean the agent's work has finished.
            #
            #   @param object [Symbol, :"agent.automation.invocation"]
            #     Always `agent.automation.invocation`.
            #
            #   @param skip_reason [Symbol, :pending_delivery, nil]
            #     Why an occurrence was skipped, or null when it was not skipped.

            # @see OpenAI::Models::Beta::Agents::Automations::AutomationInvocation#error
            class Error < OpenAI::Internal::Type::BaseModel
              # @!attribute code
              #   A machine-readable error code.
              #
              #   @return [String]
              required :code, String

              # @!attribute message
              #   A public explanation of the delivery failure.
              #
              #   @return [String]
              required :message, String

              # @!method initialize(code:, message:)
              #   The permanent delivery failure, or null when no failure occurred.
              #
              #   @param code [String]
              #     A machine-readable error code.
              #
              #   @param message [String]
              #     A public explanation of the delivery failure.
            end

            # Delivery status; completed does not mean the agent's work has finished.
            #
            # @see OpenAI::Models::Beta::Agents::Automations::AutomationInvocation#status
            module Status
              extend OpenAI::Internal::Type::Enum

              QUEUED = :queued
              COMPLETED = :completed
              FAILED = :failed
              SKIPPED = :skipped

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end

        AutomationInvocation = Automations::AutomationInvocation
      end
    end
  end
end
