# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationItemDeletedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemDeletedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the item that was deleted.
        sig { returns(String) }
        attr_accessor :item_id

        # The event type, must be `conversation.item.deleted`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when an item in the conversation is deleted by the client with a
        # `conversation.item.delete` event. This event is used to synchronize the server's
        # understanding of the conversation history with the client's view.
        sig do
          params(event_id: String, item_id: String, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # The ID of the item that was deleted.
          item_id:,
          # The event type, must be `conversation.item.deleted`.
          type: :"conversation.item.deleted"
        )
        end

        sig do
          override.returns({ event_id: String, item_id: String, type: Symbol })
        end
        def to_hash
        end
      end
    end
  end
end
