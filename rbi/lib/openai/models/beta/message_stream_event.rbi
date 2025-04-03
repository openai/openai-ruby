# typed: strong

module OpenAI
  module Models
    module Beta
      # Occurs when a
      #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
      #   created.
      module MessageStreamEvent
        extend OpenAI::Union

        class ThreadMessageCreated < OpenAI::BaseModel
          # Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          sig { returns(OpenAI::Models::Beta::Threads::Message) }
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Message, OpenAI::Internal::Util::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
          #   created.
          sig do
            params(
              data: T.any(OpenAI::Models::Beta::Threads::Message, OpenAI::Internal::Util::AnyHash),
              event: Symbol
            )
              .returns(T.attached_class)
          end
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
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Message, OpenAI::Internal::Util::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) moves
          #   to an `in_progress` state.
          sig do
            params(
              data: T.any(OpenAI::Models::Beta::Threads::Message, OpenAI::Internal::Util::AnyHash),
              event: Symbol
            )
              .returns(T.attached_class)
          end
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
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::MessageDeltaEvent, OpenAI::Internal::Util::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when parts of a
          #   [Message](https://platform.openai.com/docs/api-reference/messages/object) are
          #   being streamed.
          sig do
            params(
              data: T.any(OpenAI::Models::Beta::Threads::MessageDeltaEvent, OpenAI::Internal::Util::AnyHash),
              event: Symbol
            )
              .returns(T.attached_class)
          end
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
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Message, OpenAI::Internal::Util::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
          #   completed.
          sig do
            params(
              data: T.any(OpenAI::Models::Beta::Threads::Message, OpenAI::Internal::Util::AnyHash),
              event: Symbol
            )
              .returns(T.attached_class)
          end
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
          attr_reader :data

          sig { params(data: T.any(OpenAI::Models::Beta::Threads::Message, OpenAI::Internal::Util::AnyHash)).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) ends
          #   before it is completed.
          sig do
            params(
              data: T.any(OpenAI::Models::Beta::Threads::Message, OpenAI::Internal::Util::AnyHash),
              event: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(data:, event: :"thread.message.incomplete")
          end

          sig { override.returns({data: OpenAI::Models::Beta::Threads::Message, event: Symbol}) }
          def to_hash
          end
        end

        sig do
          override
            .returns(
              [OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::MessageStreamEvent::ThreadMessageIncomplete]
            )
        end
        def self.variants
        end
      end
    end
  end
end
