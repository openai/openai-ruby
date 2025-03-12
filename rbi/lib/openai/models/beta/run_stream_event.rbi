# typed: strong

module OpenAI
  module Models
    module Beta
      class RunStreamEvent < OpenAI::Union
        abstract!

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

        class << self
          sig do
            override
              .returns(
                [[Symbol, OpenAI::Models::Beta::RunStreamEvent::ThreadRunCreated], [Symbol, OpenAI::Models::Beta::RunStreamEvent::ThreadRunQueued], [Symbol, OpenAI::Models::Beta::RunStreamEvent::ThreadRunInProgress], [Symbol, OpenAI::Models::Beta::RunStreamEvent::ThreadRunRequiresAction], [Symbol, OpenAI::Models::Beta::RunStreamEvent::ThreadRunCompleted], [Symbol, OpenAI::Models::Beta::RunStreamEvent::ThreadRunIncomplete], [Symbol, OpenAI::Models::Beta::RunStreamEvent::ThreadRunFailed], [Symbol, OpenAI::Models::Beta::RunStreamEvent::ThreadRunCancelling], [Symbol, OpenAI::Models::Beta::RunStreamEvent::ThreadRunCancelled], [Symbol, OpenAI::Models::Beta::RunStreamEvent::ThreadRunExpired]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
