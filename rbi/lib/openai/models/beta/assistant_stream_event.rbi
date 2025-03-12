# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantStreamEvent < OpenAI::Union
        abstract!

        class ThreadCreated < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Thread) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Thread).returns(OpenAI::Models::Beta::Thread) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { returns(T.nilable(T::Boolean)) }
          def enabled
          end

          sig { params(_: T::Boolean).returns(T::Boolean) }
          def enabled=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Thread, enabled: T::Boolean, event: Symbol).returns(T.attached_class) }
          def self.new(data:, enabled: nil, event: :"thread.created")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Thread, event: Symbol, enabled: T::Boolean}) }
          def to_hash
          end
        end

        class ThreadRunCreated < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Run).returns(OpenAI::Models::Beta::Threads::Run) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.created")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunQueued < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Run).returns(OpenAI::Models::Beta::Threads::Run) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.queued")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunInProgress < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Run).returns(OpenAI::Models::Beta::Threads::Run) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.in_progress")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunRequiresAction < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Run).returns(OpenAI::Models::Beta::Threads::Run) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.requires_action")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunCompleted < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Run).returns(OpenAI::Models::Beta::Threads::Run) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.completed")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunIncomplete < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Run).returns(OpenAI::Models::Beta::Threads::Run) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.incomplete")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunFailed < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Run).returns(OpenAI::Models::Beta::Threads::Run) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.failed")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunCancelling < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Run).returns(OpenAI::Models::Beta::Threads::Run) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.cancelling")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunCancelled < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Run).returns(OpenAI::Models::Beta::Threads::Run) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.cancelled")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunExpired < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Run).returns(OpenAI::Models::Beta::Threads::Run) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.expired")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

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

        class ThreadMessageCreated < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Message) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Message).returns(OpenAI::Models::Beta::Threads::Message) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Message, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.message.created")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Message, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadMessageInProgress < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Message) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Message).returns(OpenAI::Models::Beta::Threads::Message) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Message, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.message.in_progress")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Message, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadMessageDelta < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::MessageDeltaEvent) }
          def data
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::MessageDeltaEvent)
              .returns(OpenAI::Models::Beta::Threads::MessageDeltaEvent)
          end
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::MessageDeltaEvent, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.message.delta")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::MessageDeltaEvent, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadMessageCompleted < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Message) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Message).returns(OpenAI::Models::Beta::Threads::Message) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Message, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.message.completed")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Message, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadMessageIncomplete < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::Message) }
          def data
          end

          sig { params(_: OpenAI::Models::Beta::Threads::Message).returns(OpenAI::Models::Beta::Threads::Message) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::Beta::Threads::Message, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.message.incomplete")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Message, event: Symbol}) }
          def to_hash
          end
        end

        class ErrorEvent < OpenAI::BaseModel
          sig { returns(OpenAI::Models::ErrorObject) }
          def data
          end

          sig { params(_: OpenAI::Models::ErrorObject).returns(OpenAI::Models::ErrorObject) }
          def data=(_)
          end

          sig { returns(Symbol) }
          def event
          end

          sig { params(_: Symbol).returns(Symbol) }
          def event=(_)
          end

          sig { params(data: OpenAI::Models::ErrorObject, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :error)
          end

          sig { override.returns({data: OpenAI::Models::ErrorObject, event: Symbol}) }
          def to_hash
          end
        end

        class << self
          sig do
            override
              .returns(
                [[Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete], [Symbol, OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
