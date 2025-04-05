# typed: strong

module OpenAI
  module Models
    module Beta
      # Occurs when a new
      # [run](https://platform.openai.com/docs/api-reference/runs/object) is created.
      module RunStreamEvent
        extend OpenAI::Internal::Type::Union

        class ThreadRunCreated < OpenAI::Internal::Type::BaseModel
          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a new
          # [run](https://platform.openai.com/docs/api-reference/runs/object) is created.
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
          def self.new(data:, event: :"thread.run.created"); end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash; end
        end

        class ThreadRunQueued < OpenAI::Internal::Type::BaseModel
          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # moves to a `queued` status.
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
          def self.new(data:, event: :"thread.run.queued"); end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash; end
        end

        class ThreadRunInProgress < OpenAI::Internal::Type::BaseModel
          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # moves to an `in_progress` status.
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
          def self.new(data:, event: :"thread.run.in_progress"); end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash; end
        end

        class ThreadRunRequiresAction < OpenAI::Internal::Type::BaseModel
          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # moves to a `requires_action` status.
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
          def self.new(data:, event: :"thread.run.requires_action"); end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash; end
        end

        class ThreadRunCompleted < OpenAI::Internal::Type::BaseModel
          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # is completed.
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
          def self.new(data:, event: :"thread.run.completed"); end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash; end
        end

        class ThreadRunIncomplete < OpenAI::Internal::Type::BaseModel
          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # ends with status `incomplete`.
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
          def self.new(data:, event: :"thread.run.incomplete"); end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash; end
        end

        class ThreadRunFailed < OpenAI::Internal::Type::BaseModel
          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # fails.
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
          def self.new(data:, event: :"thread.run.failed"); end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash; end
        end

        class ThreadRunCancelling < OpenAI::Internal::Type::BaseModel
          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # moves to a `cancelling` status.
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
          def self.new(data:, event: :"thread.run.cancelling"); end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash; end
        end

        class ThreadRunCancelled < OpenAI::Internal::Type::BaseModel
          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # is cancelled.
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
          def self.new(data:, event: :"thread.run.cancelled"); end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash; end
        end

        class ThreadRunExpired < OpenAI::Internal::Type::BaseModel
          # Represents an execution run on a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Models::Beta::Threads::Run) }
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          # expires.
          sig do
            params(data: T.any(OpenAI::Models::Beta::Threads::Run, OpenAI::Internal::AnyHash), event: Symbol)
              .returns(T.attached_class)
          end
          def self.new(data:, event: :"thread.run.expired"); end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Run, event: Symbol}) }
          def to_hash; end
        end

        sig do
          override
            .returns(
              [OpenAI::Models::Beta::RunStreamEvent::ThreadRunCreated, OpenAI::Models::Beta::RunStreamEvent::ThreadRunQueued, OpenAI::Models::Beta::RunStreamEvent::ThreadRunInProgress, OpenAI::Models::Beta::RunStreamEvent::ThreadRunRequiresAction, OpenAI::Models::Beta::RunStreamEvent::ThreadRunCompleted, OpenAI::Models::Beta::RunStreamEvent::ThreadRunIncomplete, OpenAI::Models::Beta::RunStreamEvent::ThreadRunFailed, OpenAI::Models::Beta::RunStreamEvent::ThreadRunCancelling, OpenAI::Models::Beta::RunStreamEvent::ThreadRunCancelled, OpenAI::Models::Beta::RunStreamEvent::ThreadRunExpired]
            )
        end
        def self.variants; end
      end
    end
  end
end
