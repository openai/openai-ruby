# typed: strong

module OpenAI
  module Models
    module Beta
      # Represents an event emitted when streaming a Run.
      #
      # Each event in a server-sent events stream has an `event` and `data` property:
      #
      # ```
      # event: thread.created
      # data: {"id": "thread_123", "object": "thread", ...}
      # ```
      #
      # We emit events whenever a new object is created, transitions to a new state, or
      # is being streamed in parts (deltas). For example, we emit `thread.run.created`
      # when a new run is created, `thread.run.completed` when a run completes, and so
      # on. When an Assistant chooses to create a message during a run, we emit a
      # `thread.message.created event`, a `thread.message.in_progress` event, many
      # `thread.message.delta` events, and finally a `thread.message.completed` event.
      #
      # We may add additional events over time, so we recommend handling unknown events
      # gracefully in your code. See the
      # [Assistants API quickstart](https://platform.openai.com/docs/assistants/overview)
      # to learn how to integrate the Assistants API with streaming.
      module AssistantStreamEvent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Beta::AssistantStreamEvent::ThreadCreated,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunCreated,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunQueued,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunInProgress,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunRequiresAction,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunCompleted,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunIncomplete,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunFailed,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunCancelling,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunCancelled,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunExpired,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCreated,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunStepInProgress,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunStepDelta,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCompleted,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunStepFailed,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCancelled,
              OpenAI::Beta::AssistantStreamEvent::ThreadRunStepExpired,
              OpenAI::Beta::AssistantStreamEvent::ThreadMessageCreated,
              OpenAI::Beta::AssistantStreamEvent::ThreadMessageInProgress,
              OpenAI::Beta::AssistantStreamEvent::ThreadMessageDelta,
              OpenAI::Beta::AssistantStreamEvent::ThreadMessageCompleted,
              OpenAI::Beta::AssistantStreamEvent::ThreadMessageIncomplete,
              OpenAI::Beta::AssistantStreamEvent::ErrorEvent
            )
          end

        class ThreadCreated < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents a thread that contains
          # [messages](https://platform.openai.com/docs/api-reference/messages).
          sig { returns(OpenAI::Beta::Thread) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Thread::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Whether to enable input audio transcription.
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :enabled

          sig { params(enabled: T::Boolean).void }
          attr_writer :enabled

          # Occurs when a new
          # [thread](https://platform.openai.com/docs/api-reference/threads/object) is
          # created.
          sig do
            params(
              data: OpenAI::Beta::Thread::OrHash,
              enabled: T::Boolean,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a thread that contains
            # [messages](https://platform.openai.com/docs/api-reference/messages).
            data:,
            # Whether to enable input audio transcription.
            enabled: nil,
            event: :"thread.created"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Thread, event: Symbol, enabled: T::Boolean }
            )
          end
          def to_hash
          end
        end

        class ThreadRunCreated < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Run::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a new
          # [run](https://platform.openai.com/docs/api-reference/runs/object) is created.
          sig do
            params(
              data: OpenAI::Beta::Threads::Run::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents an execution run on a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.run.created"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Run, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunQueued < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Run::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # moves to a `queued` status.
          sig do
            params(
              data: OpenAI::Beta::Threads::Run::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents an execution run on a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.run.queued"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Run, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunInProgress < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Run::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # moves to an `in_progress` status.
          sig do
            params(
              data: OpenAI::Beta::Threads::Run::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents an execution run on a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.run.in_progress"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Run, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunRequiresAction < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Run::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # moves to a `requires_action` status.
          sig do
            params(
              data: OpenAI::Beta::Threads::Run::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents an execution run on a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.run.requires_action"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Run, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunCompleted < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Run::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # is completed.
          sig do
            params(
              data: OpenAI::Beta::Threads::Run::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents an execution run on a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.run.completed"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Run, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunIncomplete < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Run::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # ends with status `incomplete`.
          sig do
            params(
              data: OpenAI::Beta::Threads::Run::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents an execution run on a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.run.incomplete"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Run, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunFailed < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Run::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # fails.
          sig do
            params(
              data: OpenAI::Beta::Threads::Run::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents an execution run on a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.run.failed"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Run, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunCancelling < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Run::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # moves to a `cancelling` status.
          sig do
            params(
              data: OpenAI::Beta::Threads::Run::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents an execution run on a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.run.cancelling"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Run, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunCancelled < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Run::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # is cancelled.
          sig do
            params(
              data: OpenAI::Beta::Threads::Run::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents an execution run on a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.run.cancelled"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Run, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunExpired < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Run::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # expires.
          sig do
            params(
              data: OpenAI::Beta::Threads::Run::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents an execution run on a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.run.expired"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Run, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunStepCreated < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents a step in execution of a run.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStep) }
          attr_reader :data

          sig do
            params(data: OpenAI::Beta::Threads::Runs::RunStep::OrHash).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # is created.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStep::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a step in execution of a run.
            data:,
            event: :"thread.run.step.created"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Runs::RunStep, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunStepInProgress < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents a step in execution of a run.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStep) }
          attr_reader :data

          sig do
            params(data: OpenAI::Beta::Threads::Runs::RunStep::OrHash).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # moves to an `in_progress` state.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStep::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a step in execution of a run.
            data:,
            event: :"thread.run.step.in_progress"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Runs::RunStep, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunStepDelta < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents a run step delta i.e. any changed fields on a run step during
          # streaming.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStepDeltaEvent) }
          attr_reader :data

          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStepDeltaEvent::OrHash
            ).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when parts of a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # are being streamed.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStepDeltaEvent::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a run step delta i.e. any changed fields on a run step during
            # streaming.
            data:,
            event: :"thread.run.step.delta"
          )
          end

          sig do
            override.returns(
              {
                data: OpenAI::Beta::Threads::Runs::RunStepDeltaEvent,
                event: Symbol
              }
            )
          end
          def to_hash
          end
        end

        class ThreadRunStepCompleted < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents a step in execution of a run.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStep) }
          attr_reader :data

          sig do
            params(data: OpenAI::Beta::Threads::Runs::RunStep::OrHash).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # is completed.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStep::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a step in execution of a run.
            data:,
            event: :"thread.run.step.completed"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Runs::RunStep, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunStepFailed < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents a step in execution of a run.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStep) }
          attr_reader :data

          sig do
            params(data: OpenAI::Beta::Threads::Runs::RunStep::OrHash).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # fails.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStep::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a step in execution of a run.
            data:,
            event: :"thread.run.step.failed"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Runs::RunStep, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunStepCancelled < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents a step in execution of a run.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStep) }
          attr_reader :data

          sig do
            params(data: OpenAI::Beta::Threads::Runs::RunStep::OrHash).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # is cancelled.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStep::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a step in execution of a run.
            data:,
            event: :"thread.run.step.cancelled"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Runs::RunStep, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunStepExpired < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents a step in execution of a run.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStep) }
          attr_reader :data

          sig do
            params(data: OpenAI::Beta::Threads::Runs::RunStep::OrHash).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # expires.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStep::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a step in execution of a run.
            data:,
            event: :"thread.run.step.expired"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Runs::RunStep, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadMessageCreated < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents a message within a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Message) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Message::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [message](https://platform.openai.com/docs/api-reference/messages/object) is
          # created.
          sig do
            params(
              data: OpenAI::Beta::Threads::Message::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a message within a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.message.created"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Message, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadMessageInProgress < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents a message within a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Message) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Message::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [message](https://platform.openai.com/docs/api-reference/messages/object) moves
          # to an `in_progress` state.
          sig do
            params(
              data: OpenAI::Beta::Threads::Message::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a message within a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.message.in_progress"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Message, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadMessageDelta < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents a message delta i.e. any changed fields on a message during
          # streaming.
          sig { returns(OpenAI::Beta::Threads::MessageDeltaEvent) }
          attr_reader :data

          sig do
            params(data: OpenAI::Beta::Threads::MessageDeltaEvent::OrHash).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when parts of a
          # [Message](https://platform.openai.com/docs/api-reference/messages/object) are
          # being streamed.
          sig do
            params(
              data: OpenAI::Beta::Threads::MessageDeltaEvent::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a message delta i.e. any changed fields on a message during
            # streaming.
            data:,
            event: :"thread.message.delta"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::MessageDeltaEvent, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadMessageCompleted < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents a message within a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Message) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Message::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [message](https://platform.openai.com/docs/api-reference/messages/object) is
          # completed.
          sig do
            params(
              data: OpenAI::Beta::Threads::Message::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a message within a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.message.completed"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Message, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadMessageIncomplete < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Represents a message within a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Beta::Threads::Message) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Message::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [message](https://platform.openai.com/docs/api-reference/messages/object) ends
          # before it is completed.
          sig do
            params(
              data: OpenAI::Beta::Threads::Message::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a message within a
            # [thread](https://platform.openai.com/docs/api-reference/threads).
            data:,
            event: :"thread.message.incomplete"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Message, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ErrorEvent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          sig { returns(OpenAI::ErrorObject) }
          attr_reader :data

          sig { params(data: OpenAI::ErrorObject::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when an
          # [error](https://platform.openai.com/docs/guides/error-codes#api-errors) occurs.
          # This can happen due to an internal server error or a timeout.
          sig do
            params(data: OpenAI::ErrorObject::OrHash, event: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(data:, event: :error)
          end

          sig { override.returns({ data: OpenAI::ErrorObject, event: Symbol }) }
          def to_hash
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Beta::AssistantStreamEvent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
