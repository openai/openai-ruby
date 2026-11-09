# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Automations
          module AutomationInvocationSource
            extend OpenAI::Internal::Type::Union

            discriminator :type

            variant :manual, -> { OpenAI::Beta::Agents::Automations::AutomationInvocationSource::Manual }

            variant :automation, -> { OpenAI::Beta::Agents::Automations::AutomationInvocationSource::Automation }

            class Manual < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   The type of the object. Always `manual`.
              #
              #   @return [Symbol, :manual]
              required :type, const: :manual

              # @!method initialize(type: :manual)
              #   @param type [Symbol, :manual]
              #     The type of the object. Always `manual`.
            end

            class Automation < OpenAI::Internal::Type::BaseModel
              # @!attribute automation
              #   The automation snapshot for this occurrence, excluding confidential values.
              #
              #   @return [OpenAI::Models::Beta::Agents::PeriodicAutomation, OpenAI::Models::Beta::Agents::OneTimeAutomation]
              required :automation, union: -> { OpenAI::Beta::Agents::Automation }

              # @!attribute type
              #   The type of the object. Always `automation`.
              #
              #   @return [Symbol, :automation]
              required :type, const: :automation

              # @!method initialize(automation:, type: :automation)
              #   @param automation [OpenAI::Models::Beta::Agents::PeriodicAutomation, OpenAI::Models::Beta::Agents::OneTimeAutomation]
              #     The automation snapshot for this occurrence, excluding confidential values.
              #
              #   @param type [Symbol, :automation]
              #     The type of the object. Always `automation`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::Agents::Automations::AutomationInvocationSource::Manual, OpenAI::Models::Beta::Agents::Automations::AutomationInvocationSource::Automation)]
          end
        end

        AutomationInvocationSource = Automations::AutomationInvocationSource
      end
    end
  end
end
