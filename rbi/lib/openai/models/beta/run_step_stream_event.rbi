# typed: strong

module OpenAI
  module Models
    module Beta
      # Occurs when a
      #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
      #   is created.
      class RunStepStreamEvent < OpenAI::Union
        abstract!

        Variants = type_template(:out) do
          {
            fixed: T.any(
              OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCreated,
              OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepInProgress,
              OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepDelta,
              OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCompleted,
              OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepFailed,
              OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCancelled,
              OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepExpired
            )
          }
        end

        class ThreadRunStepCreated < OpenAI::BaseModel
          # Represents a step in execution of a run.
          sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStep) }
          def data
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::Runs::RunStep)
              .returns(OpenAI::Models::Beta::Threads::Runs::RunStep)
          end
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          # Occurs when a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   is created.
          sig { params(data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.step.created")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunStepInProgress < OpenAI::BaseModel
          # Represents a step in execution of a run.
          sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStep) }
          def data
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::Runs::RunStep)
              .returns(OpenAI::Models::Beta::Threads::Runs::RunStep)
          end
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          # Occurs when a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   moves to an `in_progress` state.
          sig { params(data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.step.in_progress")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunStepDelta < OpenAI::BaseModel
          # Represents a run step delta i.e. any changed fields on a run step during
          #   streaming.
          sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStepDeltaEvent) }
          def data
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::Runs::RunStepDeltaEvent)
              .returns(OpenAI::Models::Beta::Threads::Runs::RunStepDeltaEvent)
          end
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          # Occurs when parts of a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   are being streamed.
          sig do
            params(data: OpenAI::Models::Beta::Threads::Runs::RunStepDeltaEvent, event: Symbol)
              .returns(T.attached_class)
          end
          def self.new(data:, event: :"thread.run.step.delta")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Runs::RunStepDeltaEvent, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunStepCompleted < OpenAI::BaseModel
          # Represents a step in execution of a run.
          sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStep) }
          def data
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::Runs::RunStep)
              .returns(OpenAI::Models::Beta::Threads::Runs::RunStep)
          end
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          # Occurs when a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   is completed.
          sig { params(data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.step.completed")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunStepFailed < OpenAI::BaseModel
          # Represents a step in execution of a run.
          sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStep) }
          def data
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::Runs::RunStep)
              .returns(OpenAI::Models::Beta::Threads::Runs::RunStep)
          end
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          # Occurs when a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   fails.
          sig { params(data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.step.failed")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunStepCancelled < OpenAI::BaseModel
          # Represents a step in execution of a run.
          sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStep) }
          def data
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::Runs::RunStep)
              .returns(OpenAI::Models::Beta::Threads::Runs::RunStep)
          end
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          # Occurs when a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   is cancelled.
          sig { params(data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.step.cancelled")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunStepExpired < OpenAI::BaseModel
          # Represents a step in execution of a run.
          sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStep) }
          def data
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::Runs::RunStep)
              .returns(OpenAI::Models::Beta::Threads::Runs::RunStep)
          end
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          # Occurs when a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   expires.
          sig { params(data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.step.expired")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol}) }
          def to_hash
          end
        end
      end
    end
  end
end
