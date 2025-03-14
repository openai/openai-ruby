# typed: strong

module OpenAI
  module Models
    module Beta
      # Represents an event emitted when streaming a Run.
      #
      #   Each event in a server-sent events stream has an `event` and `data` property:
      #
      #   ```
      #   event: thread.created
      #   data: {"id": "thread_123", "object": "thread", ...}
      #   ```
      #
      #   We emit events whenever a new object is created, transitions to a new state, or
      #   is being streamed in parts (deltas). For example, we emit `thread.run.created`
      #   when a new run is created, `thread.run.completed` when a run completes, and so
      #   on. When an Assistant chooses to create a message during a run, we emit a
      #   `thread.message.created event`, a `thread.message.in_progress` event, many
      #   `thread.message.delta` events, and finally a `thread.message.completed` event.
      #
      #   We may add additional events over time, so we recommend handling unknown events
      #   gracefully in your code. See the
      #   [Assistants API quickstart](https://platform.openai.com/docs/assistants/overview)
      #   to learn how to integrate the Assistants API with streaming.
      class AssistantStreamEvent < OpenAI::Union
        abstract!

        class ThreadCreated < OpenAI::BaseModel
          # Represents a thread that contains
          #   [messages](https://platform.openai.com/docs/api-reference/messages).
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

          # Whether to enable input audio transcription.
          sig { returns(T.nilable(T::Boolean)) }
          def enabled
          end

          sig { params(_: T::Boolean).returns(T::Boolean) }
          def enabled=(_)
          end

          # Occurs when a new
          #   [thread](https://platform.openai.com/docs/api-reference/threads/object) is
          #   created.
          sig { params(data: OpenAI::Models::Beta::Thread, enabled: T::Boolean, event: Symbol).returns(T.attached_class) }
          def self.new(data:, enabled: nil, event: :"thread.created")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Thread, event: Symbol, enabled: T::Boolean}) }
          def to_hash
          end
        end

        class ThreadRunCreated < OpenAI::BaseModel
          # Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a new
          #   [run](https://platform.openai.com/docs/api-reference/runs/object) is created.
          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.created")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunQueued < OpenAI::BaseModel
          # Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   moves to a `queued` status.
          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.queued")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunInProgress < OpenAI::BaseModel
          # Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   moves to an `in_progress` status.
          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.in_progress")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunRequiresAction < OpenAI::BaseModel
          # Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   moves to a `requires_action` status.
          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.requires_action")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunCompleted < OpenAI::BaseModel
          # Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   is completed.
          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.completed")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunIncomplete < OpenAI::BaseModel
          # Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   ends with status `incomplete`.
          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.incomplete")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunFailed < OpenAI::BaseModel
          # Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   fails.
          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.failed")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunCancelling < OpenAI::BaseModel
          # Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   moves to a `cancelling` status.
          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.cancelling")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunCancelled < OpenAI::BaseModel
          # Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   is cancelled.
          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.cancelled")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadRunExpired < OpenAI::BaseModel
          # Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   expires.
          sig { params(data: OpenAI::Models::Beta::Threads::Run, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.run.expired")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash
          end
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

        class ThreadMessageCreated < OpenAI::BaseModel
          # Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
          #   created.
          sig { params(data: OpenAI::Models::Beta::Threads::Message, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.message.created")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Message, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadMessageInProgress < OpenAI::BaseModel
          # Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) moves
          #   to an `in_progress` state.
          sig { params(data: OpenAI::Models::Beta::Threads::Message, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.message.in_progress")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Message, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadMessageDelta < OpenAI::BaseModel
          # Represents a message delta i.e. any changed fields on a message during
          #   streaming.
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

          # Occurs when parts of a
          #   [Message](https://platform.openai.com/docs/api-reference/messages/object) are
          #   being streamed.
          sig { params(data: OpenAI::Models::Beta::Threads::MessageDeltaEvent, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.message.delta")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::MessageDeltaEvent, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadMessageCompleted < OpenAI::BaseModel
          # Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
          #   completed.
          sig { params(data: OpenAI::Models::Beta::Threads::Message, event: Symbol).returns(T.attached_class) }
          def self.new(data:, event: :"thread.message.completed")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Message, event: Symbol}) }
          def to_hash
          end
        end

        class ThreadMessageIncomplete < OpenAI::BaseModel
          # Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
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

          # Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) ends
          #   before it is completed.
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

          # Occurs when an
          #   [error](https://platform.openai.com/docs/guides/error-codes#api-errors) occurs.
          #   This can happen due to an internal server error or a timeout.
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
                [OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent]
              )
          end
          def variants
          end
        end
      end
    end
  end
end
