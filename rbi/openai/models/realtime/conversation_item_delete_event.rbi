# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationItemDeleteEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemDeleteEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the item to delete.
        sig { returns(String) }
        attr_accessor :item_id

        # The event type, must be `conversation.item.delete`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Send this event when you want to remove any item from the conversation history.
        # The server will respond with a `conversation.item.deleted` event, unless the
        # item does not exist in the conversation history, in which case the server will
        # respond with an error.
        sig do
          params(item_id: String, event_id: String, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # The ID of the item to delete.
          item_id:,
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # The event type, must be `conversation.item.delete`.
          type: :"conversation.item.delete"
        )
        end

        sig do
          override.returns({ item_id: String, type: Symbol, event_id: String })
        end
        def to_hash
        end
      end
    end
  end
end
