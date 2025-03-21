# typed: strong

module OpenAI
  module Models
    module Beta
      # Occurs when a
      #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
      #   is created.
      module RunStepStreamEvent
        extend OpenAI::Union

        Variants =
          type_template(:out) do
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
            params(_: T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash))
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
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
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
            params(_: T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash))
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
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
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
            params(_: T.any(OpenAI::Models::Beta::Threads::Runs::RunStepDeltaEvent, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::Runs::RunStepDeltaEvent, OpenAI::Util::AnyHash))
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
            params(
              data: T.any(OpenAI::Models::Beta::Threads::Runs::RunStepDeltaEvent, OpenAI::Util::AnyHash),
              event: Symbol
            )
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
            params(_: T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash))
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
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
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
            params(_: T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash))
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
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
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
            params(_: T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash))
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
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
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
            params(_: T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash))
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
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Runs::RunStep, OpenAI::Util::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
          def self.new(data:, event: :"thread.run.step.expired")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol}) }
          def to_hash
          end
        end

        class << self
          sig do
            override
              .returns(
                [OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepExpired]
              )
          end
          def variants
          end
        end
      end
    end
  end
end
