# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        AutomationInvocationSource = Automations::AutomationInvocationSource

        module Automations

          module AutomationInvocationSource
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Automations::AutomationInvocationSource::Manual,
                OpenAI::Beta::Agents::Automations::AutomationInvocationSource::Automation
              )
            end

            class Manual < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Automations::AutomationInvocationSource::Manual,
                  OpenAI::Internal::AnyHash
                )
              end

              # The type of the object. Always `manual`.
              sig { returns(Symbol) }
              attr_accessor :type

              sig do
                params(

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The type of the object. Always `manual`.

                type: :manual
              )
              end

              sig do
                override.returns(
                  {type: Symbol}
                )
              end
              def to_hash
              end

            end

            class Automation < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::Agents::Automations::AutomationInvocationSource::Automation,
                  OpenAI::Internal::AnyHash
                )
              end

              # The automation snapshot for this occurrence, excluding confidential values.
              sig { returns(OpenAI::Beta::Agents::Automation::Variants) }
              attr_accessor :automation

              # The type of the object. Always `automation`.
              sig { returns(Symbol) }
              attr_accessor :type

              sig do
                params(

                  automation: T.any(
                    OpenAI::Beta::Agents::PeriodicAutomation::OrHash,
                    OpenAI::Beta::Agents::OneTimeAutomation::OrHash
                  ),

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The automation snapshot for this occurrence, excluding confidential values.
                automation:,

                # The type of the object. Always `automation`.

                type: :automation
              )
              end

              sig do
                override.returns(
                  {automation: OpenAI::Beta::Agents::Automation::Variants, type: Symbol}
                )
              end
              def to_hash
              end

            end

            sig { override.returns(T::Array[OpenAI::Beta::Agents::Automations::AutomationInvocationSource::Variants]) }
            def self.variants
            end

          end

        end

      end

    end

  end
end
