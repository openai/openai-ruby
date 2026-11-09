# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        # A saved automation and its schedule.
        module Automation
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::PeriodicAutomation,
              OpenAI::Beta::Agents::OneTimeAutomation
            )
          end

          sig { override.returns(T::Array[OpenAI::Beta::Agents::Automation::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
