# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStepDelta < OpenAI::BaseModel
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
            def step_details
            end

            sig do
              params(
                _: T.any(
                  OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta,
                  OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject
                )
              )
                .returns(
                  T.any(
                    OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta,
                    OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject
                  )
                )
            end
            def step_details=(_)
            end

            # The delta containing the fields that have changed on the run step.
            sig do
              params(
                step_details: T.any(
                  OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta,
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
            class StepDetails < OpenAI::Union
              abstract!

              Variants =
                type_template(:out) do
                  {
                    fixed: T.any(
                      OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta,
                      OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject
                    )
                  }
                end
            end
          end
        end

        RunStepDelta = Runs::RunStepDelta
      end
    end
  end
end
