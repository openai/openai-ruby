# typed: strong

module OpenAI
  module Models
    module Beta
      class RunStepStreamEvent < OpenAI::Union
        abstract!

        class ThreadRunStepCreated < OpenAI::BaseModel
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

          sig { params(data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.step.created")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunStepInProgress < OpenAI::BaseModel
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

          sig { params(data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.step.in_progress")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunStepDelta < OpenAI::BaseModel
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

          sig { params(data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.step.completed")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunStepFailed < OpenAI::BaseModel
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

          sig { params(data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.step.failed")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunStepCancelled < OpenAI::BaseModel
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

          sig { params(data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.step.cancelled")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunStepExpired < OpenAI::BaseModel
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

          sig { params(data: OpenAI::Models::Beta::Threads::Runs::RunStep, event: Symbol).returns(T.attached_class) }
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
                [[Symbol, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCreated], [Symbol, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepInProgress], [Symbol, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepDelta], [Symbol, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCompleted], [Symbol, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepFailed], [Symbol, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCancelled], [Symbol, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepExpired]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
