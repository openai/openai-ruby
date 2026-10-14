# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        RunStepDelta = Runs::RunStepDelta

        module Runs
          class RunStepDelta < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Runs::RunStepDelta,
                  OpenAI::Internal::AnyHash
                )
              end

            # The details of the run step.
            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::Threads::Runs::RunStepDelta::StepDetails::Variants
                )
              )
            end
            attr_reader :step_details

            sig do
              params(
                step_details:
                  T.any(
                    OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta::OrHash,
                    OpenAI::Beta::Threads::Runs::ToolCallDeltaObject::OrHash
                  )
              ).void
            end
            attr_writer :step_details

            # The delta containing the fields that have changed on the run step.
            sig do
              params(
                step_details:
                  T.any(
                    OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta::OrHash,
                    OpenAI::Beta::Threads::Runs::ToolCallDeltaObject::OrHash
                  )
              ).returns(T.attached_class)
            end
            def self.new(
              # The details of the run step.
              step_details: nil
            )
            end

            sig do
              override.returns(
                {
                  step_details:
                    OpenAI::Beta::Threads::Runs::RunStepDelta::StepDetails::Variants
                }
              )
            end
            def to_hash
            end

            # The details of the run step.
            module StepDetails
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta,
                    OpenAI::Beta::Threads::Runs::ToolCallDeltaObject
                  )
                end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::Threads::Runs::RunStepDelta::StepDetails::Variants
                  ]
                )
              end
              def self.variants
              end
            end
          end
        end
      end
    end
  end
end
