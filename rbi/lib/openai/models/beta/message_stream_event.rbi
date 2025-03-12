# typed: strong

module OpenAI
  module Models
    module Beta
      class MessageStreamEvent < OpenAI::Union
        abstract!

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

        class << self
          sig do
            override
              .returns(
                [[Symbol, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageCreated], [Symbol, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageInProgress], [Symbol, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageDelta], [Symbol, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageCompleted], [Symbol, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageIncomplete]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
