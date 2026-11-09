# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        # A saved automation and its schedule.
        #
        # @see OpenAI::Resources::Beta::Agents::Automations#create
        module Automation
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Fields shared by periodic and one-time automations.
          variant :periodic, -> { OpenAI::Beta::Agents::PeriodicAutomation }

          # Fields shared by periodic and one-time automations.
          variant :once, -> { OpenAI::Beta::Agents::OneTimeAutomation }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::Agents::PeriodicAutomation, OpenAI::Models::Beta::Agents::OneTimeAutomation)]
        end
      end
    end
  end
end
