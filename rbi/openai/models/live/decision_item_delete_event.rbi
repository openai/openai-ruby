# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionItemDeleteEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionItemDeleteEvent,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :item_id

        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client identifier for correlating this command with a server event's
        # client_event_id or error.client_event_id.
        sig { returns(T.nilable(String)) }
        attr_accessor :event_id

        # Delete an input item from future decisions without starting an evaluation or
        # changing Live voice context.
        sig do
          params(

            item_id: String,

            event_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          item_id:,

          # Optional client identifier for correlating this command with a server event's
          # client_event_id or error.client_event_id.
          event_id: nil,

          type: :"decision.item.delete"
        )
        end

        sig do
          override.returns(
            {item_id: String, type: Symbol, event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
