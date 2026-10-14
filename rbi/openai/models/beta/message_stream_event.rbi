# typed: strong

module OpenAI
  module Models

    module Beta

      # Occurs when a
      # [message](https://developers.openai.com/api/docs/assistants/migration) is
      # created.
      module MessageStreamEvent
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::MessageStreamEvent::ThreadMessageCreated,
            OpenAI::Beta::MessageStreamEvent::ThreadMessageInProgress,
            OpenAI::Beta::MessageStreamEvent::ThreadMessageDelta,
            OpenAI::Beta::MessageStreamEvent::ThreadMessageCompleted,
            OpenAI::Beta::MessageStreamEvent::ThreadMessageIncomplete
          )
        end

        class ThreadMessageCreated < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::MessageStreamEvent::ThreadMessageCreated,
              OpenAI::Internal::AnyHash
            )
          end

          # Represents a message within a
          # [thread](https://developers.openai.com/api/docs/assistants/migration).
          sig { returns(OpenAI::Beta::Threads::Message) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Message::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [message](https://developers.openai.com/api/docs/assistants/migration) is
          # created.
          sig do
            params(

              data: OpenAI::Beta::Threads::Message::OrHash,

              event: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Represents a message within a
            # [thread](https://developers.openai.com/api/docs/assistants/migration).
            data:,

            event: :"thread.message.created"
          )
          end

          sig do
            override.returns(
              {data: OpenAI::Beta::Threads::Message, event: Symbol}
            )
          end
          def to_hash
          end

        end

        class ThreadMessageInProgress < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::MessageStreamEvent::ThreadMessageInProgress,
              OpenAI::Internal::AnyHash
            )
          end

          # Represents a message within a
          # [thread](https://developers.openai.com/api/docs/assistants/migration).
          sig { returns(OpenAI::Beta::Threads::Message) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Message::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [message](https://developers.openai.com/api/docs/assistants/migration) moves to
          # an `in_progress` state.
          sig do
            params(

              data: OpenAI::Beta::Threads::Message::OrHash,

              event: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Represents a message within a
            # [thread](https://developers.openai.com/api/docs/assistants/migration).
            data:,

            event: :"thread.message.in_progress"
          )
          end

          sig do
            override.returns(
              {data: OpenAI::Beta::Threads::Message, event: Symbol}
            )
          end
          def to_hash
          end

        end

        class ThreadMessageDelta < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::MessageStreamEvent::ThreadMessageDelta,
              OpenAI::Internal::AnyHash
            )
          end

          # Represents a message delta i.e. any changed fields on a message during
          # streaming.
          sig { returns(OpenAI::Beta::Threads::MessageDeltaEvent) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::MessageDeltaEvent::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when parts of a
          # [Message](https://developers.openai.com/api/docs/assistants/migration) are being
          # streamed.
          sig do
            params(

              data: OpenAI::Beta::Threads::MessageDeltaEvent::OrHash,

              event: Symbol
            )
              .returns(T.attached_class)
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
              {data: OpenAI::Beta::Threads::MessageDeltaEvent, event: Symbol}
            )
          end
          def to_hash
          end

        end

        class ThreadMessageCompleted < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::MessageStreamEvent::ThreadMessageCompleted,
              OpenAI::Internal::AnyHash
            )
          end

          # Represents a message within a
          # [thread](https://developers.openai.com/api/docs/assistants/migration).
          sig { returns(OpenAI::Beta::Threads::Message) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Message::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [message](https://developers.openai.com/api/docs/assistants/migration) is
          # completed.
          sig do
            params(

              data: OpenAI::Beta::Threads::Message::OrHash,

              event: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Represents a message within a
            # [thread](https://developers.openai.com/api/docs/assistants/migration).
            data:,

            event: :"thread.message.completed"
          )
          end

          sig do
            override.returns(
              {data: OpenAI::Beta::Threads::Message, event: Symbol}
            )
          end
          def to_hash
          end

        end

        class ThreadMessageIncomplete < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::MessageStreamEvent::ThreadMessageIncomplete,
              OpenAI::Internal::AnyHash
            )
          end

          # Represents a message within a
          # [thread](https://developers.openai.com/api/docs/assistants/migration).
          sig { returns(OpenAI::Beta::Threads::Message) }
          attr_reader :data

          sig { params(data: OpenAI::Beta::Threads::Message::OrHash).void }
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [message](https://developers.openai.com/api/docs/assistants/migration) ends
          # before it is completed.
          sig do
            params(

              data: OpenAI::Beta::Threads::Message::OrHash,

              event: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Represents a message within a
            # [thread](https://developers.openai.com/api/docs/assistants/migration).
            data:,

            event: :"thread.message.incomplete"
          )
          end

          sig do
            override.returns(
              {data: OpenAI::Beta::Threads::Message, event: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::MessageStreamEvent::Variants]) }
        def self.variants
        end

      end

    end

  end
end
