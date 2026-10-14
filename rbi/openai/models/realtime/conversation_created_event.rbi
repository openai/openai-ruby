# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationCreatedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationCreatedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The conversation resource.
        sig do
          returns(OpenAI::Realtime::ConversationCreatedEvent::Conversation)
        end
        attr_reader :conversation

        sig do
          params(
            conversation:
              OpenAI::Realtime::ConversationCreatedEvent::Conversation::OrHash
          ).void
        end
        attr_writer :conversation

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The event type, must be `conversation.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when a conversation is created. Emitted right after session creation.
        sig do
          params(
            conversation:
              OpenAI::Realtime::ConversationCreatedEvent::Conversation::OrHash,
            event_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The conversation resource.
          conversation:,
          # The unique ID of the server event.
          event_id:,
          # The event type, must be `conversation.created`.
          type: :"conversation.created"
        )
        end

        sig do
          override.returns(
            {
              conversation:
                OpenAI::Realtime::ConversationCreatedEvent::Conversation,
              event_id: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Conversation < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::ConversationCreatedEvent::Conversation,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the conversation.
          sig { returns(T.nilable(String)) }
          attr_reader :id

          sig { params(id: String).void }
          attr_writer :id

          # The object type, must be `realtime.conversation`.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::ConversationCreatedEvent::Conversation::Object::OrSymbol
              )
            )
          end
          attr_reader :object

          sig do
            params(
              object:
                OpenAI::Realtime::ConversationCreatedEvent::Conversation::Object::OrSymbol
            ).void
          end
          attr_writer :object

          # The conversation resource.
          sig do
            params(
              id: String,
              object:
                OpenAI::Realtime::ConversationCreatedEvent::Conversation::Object::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the conversation.
            id: nil,
            # The object type, must be `realtime.conversation`.
            object: nil
          )
          end

          sig do
            override.returns(
              {
                id: String,
                object:
                  OpenAI::Realtime::ConversationCreatedEvent::Conversation::Object::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The object type, must be `realtime.conversation`.
          module Object
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::ConversationCreatedEvent::Conversation::Object
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            REALTIME_CONVERSATION =
              T.let(
                :"realtime.conversation",
                OpenAI::Realtime::ConversationCreatedEvent::Conversation::Object::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::ConversationCreatedEvent::Conversation::Object::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
