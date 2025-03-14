# typed: strong

module OpenAI
  module Models
    module Beta
      # Occurs when a
      #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
      #   created.
      class MessageStreamEvent < OpenAI::Union
        abstract!

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

        class << self
          sig do
            override
              .returns(
                [OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageIncomplete]
              )
          end
          def variants
          end
        end
      end
    end
  end
end
