# typed: strong

module OpenAI
  module Models
    module Beta
      # Occurs when a new
      # [run](https://platform.openai.com/docs/api-reference/runs/object) is created.
      module RunStreamEvent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Beta::RunStreamEvent::ThreadRunCreated,
              OpenAI::Beta::RunStreamEvent::ThreadRunQueued,
              OpenAI::Beta::RunStreamEvent::ThreadRunInProgress,
              OpenAI::Beta::RunStreamEvent::ThreadRunRequiresAction,
              OpenAI::Beta::RunStreamEvent::ThreadRunCompleted,
              OpenAI::Beta::RunStreamEvent::ThreadRunIncomplete,
              OpenAI::Beta::RunStreamEvent::ThreadRunFailed,
              OpenAI::Beta::RunStreamEvent::ThreadRunCancelling,
              OpenAI::Beta::RunStreamEvent::ThreadRunCancelled,
              OpenAI::Beta::RunStreamEvent::ThreadRunExpired
            )
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

        sig do
          override.returns(T::Array[OpenAI::Beta::RunStreamEvent::Variants])
        end
        def self.variants
        end
      end
    end
  end
end
