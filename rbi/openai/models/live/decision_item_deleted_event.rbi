# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionItemDeletedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionItemDeletedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the Live server event.
        sig { returns(String) }
        attr_accessor :event_id

        sig { returns(String) }
        attr_accessor :item_id

        sig { returns(Symbol) }
        attr_accessor :type

        # The event_id of the client command associated with this server event, when
        # supplied.
        sig { returns(T.nilable(String)) }
        attr_reader :client_event_id

        sig { params(client_event_id: String).void }
        attr_writer :client_event_id

        # An input item was removed from future decisions.
        sig do
          params(

            event_id: String,

            item_id: String,

            client_event_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the Live server event.
          event_id:,

          item_id:,

          # The event_id of the client command associated with this server event, when
          # supplied.
          client_event_id: nil,

          type: :"decision.item.deleted"
        )
        end

        sig do
          override.returns(
            {event_id: String, item_id: String, type: Symbol, client_event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
