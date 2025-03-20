# typed: strong

module OpenAI
  module Models
    module Beta
      # Occurs when a new
      #   [run](https://platform.openai.com/docs/api-reference/runs/object) is created.
      module RunStreamEvent
        extend OpenAI::Union

        Variants =
          type_template(:out) do
            {
              fixed: T.any(
                OpenAI::Models::Beta::RunStreamEvent::ThreadRunCreated,
                OpenAI::Models::Beta::RunStreamEvent::ThreadRunQueued,
                OpenAI::Models::Beta::RunStreamEvent::ThreadRunInProgress,
                OpenAI::Models::Beta::RunStreamEvent::ThreadRunRequiresAction,
                OpenAI::Models::Beta::RunStreamEvent::ThreadRunCompleted,
                OpenAI::Models::Beta::RunStreamEvent::ThreadRunIncomplete,
                OpenAI::Models::Beta::RunStreamEvent::ThreadRunFailed,
                OpenAI::Models::Beta::RunStreamEvent::ThreadRunCancelling,
                OpenAI::Models::Beta::RunStreamEvent::ThreadRunCancelled,
                OpenAI::Models::Beta::RunStreamEvent::ThreadRunExpired
              )
            }
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
      end
    end
  end
end
