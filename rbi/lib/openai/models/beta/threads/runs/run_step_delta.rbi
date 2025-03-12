# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        RunStepDelta = T.type_alias { Runs::RunStepDelta }

        module Runs
          class RunStepDelta < OpenAI::BaseModel
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

            class StepDetails < OpenAI::Union
              abstract!

              class << self
                sig do
                  override
                    .returns(
                      [[Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta], [Symbol, OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject]]
                    )
                end
                private def variants
                end
              end
            end
          end
        end
      end
    end
  end
end
