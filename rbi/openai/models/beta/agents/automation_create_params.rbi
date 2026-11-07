# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class AutomationCreateParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::AutomationCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

          # Creates an automation without invoking it immediately.
          sig {
            returns(
              T.any(
                OpenAI::Beta::Agents::AutomationScheduleParam::Periodic,
                OpenAI::Beta::Agents::AutomationScheduleParam::Once
              )
            )
          }
          attr_accessor :create_automation_params

          sig do
            params(

              create_automation_params: T.any(
                OpenAI::Beta::Agents::AutomationScheduleParam::Periodic::OrHash,
                OpenAI::Beta::Agents::AutomationScheduleParam::Once::OrHash
              ),

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Creates an automation without invoking it immediately.
            create_automation_params:,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                create_automation_params: T.any(
                  OpenAI::Beta::Agents::AutomationScheduleParam::Periodic,
                  OpenAI::Beta::Agents::AutomationScheduleParam::Once
                ),
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
