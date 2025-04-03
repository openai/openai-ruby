# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStepDelta < OpenAI::Internal::Type::BaseModel
            # The details of the run step.
            sig do
              returns(
                T.nilable(
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta,
                    OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject
                  )
                )
              )
            end
            attr_reader :step_details

            sig do
              params(
                step_details: T.any(
                  OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject
                )
              )
                .void
            end
            attr_writer :step_details

            # The delta containing the fields that have changed on the run step.
            sig do
              params(
                step_details: T.any(
                  OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject
                )
              )
                .returns(T.attached_class)
            end
            def self.new(step_details: nil)
            end

            sig do
              override
                .returns(
                  {
                    step_details: T.any(
                      OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta,
                      OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject
                    )
                  }
                )
            end
            def to_hash
            end

            # The details of the run step.
            module StepDetails
              extend OpenAI::Internal::Type::Union

              sig do
                override
                  .returns(
                    [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta, OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject]
                  )
              end
              def self.variants
              end
            end
          end
        end

        RunStepDelta = Runs::RunStepDelta
      end
    end
  end
end
