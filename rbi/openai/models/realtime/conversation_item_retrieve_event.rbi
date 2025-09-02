# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationItemRetrieveEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemRetrieveEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the item to retrieve.
        sig { returns(String) }
        attr_accessor :item_id

        # The event type, must be `conversation.item.retrieve`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Send this event when you want to retrieve the server's representation of a
        # specific item in the conversation history. This is useful, for example, to
        # inspect user audio after noise cancellation and VAD. The server will respond
        # with a `conversation.item.retrieved` event, unless the item does not exist in
        # the conversation history, in which case the server will respond with an error.
        sig do
          params(item_id: String, event_id: String, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # The ID of the item to retrieve.
          item_id:,
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # The event type, must be `conversation.item.retrieve`.
          type: :"conversation.item.retrieve"
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
