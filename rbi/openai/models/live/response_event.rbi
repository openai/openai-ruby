# typed: strong

module OpenAI
  module Models

    module Live

      class ResponseEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::ResponseEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The nested Responses streaming event. Dispatch on its type field. Response
        # lifecycle snapshots omit input and clear instructions, tools, and output to keep
        # messages small; consume granular output events for the generated content.
        sig { returns(T::Hash[Symbol, T.anything]) }
        attr_accessor :event

        # The unique ID of the Live server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The event type, always `response.event`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The event_id of the client command associated with this server event, when
        # supplied.
        sig { returns(T.nilable(String)) }
        attr_reader :client_event_id

        sig { params(client_event_id: String).void }
        attr_writer :client_event_id

        # The Live delegation associated with the nested Responses event. May be null or
        # omitted when the event cannot be correlated with a delegation.
        sig { returns(T.nilable(String)) }
        attr_accessor :delegation_id

        # A streaming Responses API event from a backend delegated to by the Live session.
        # Use the outer delegation_id to associate the nested stream with its Live
        # delegation.
        sig do
          params(

            event: T::Hash[Symbol, T.anything],

            event_id: String,

            client_event_id: String,

            delegation_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The nested Responses streaming event. Dispatch on its type field. Response
          # lifecycle snapshots omit input and clear instructions, tools, and output to keep
          # messages small; consume granular output events for the generated content.
          event:,

          # The unique ID of the Live server event.
          event_id:,

          # The event_id of the client command associated with this server event, when
          # supplied.
          client_event_id: nil,

          # The Live delegation associated with the nested Responses event. May be null or
          # omitted when the event cannot be correlated with a delegation.
          delegation_id: nil,

          # The event type, always `response.event`.

          type: :"response.event"
        )
        end

        sig do
          override.returns(
            {
              event: T::Hash[Symbol, T.anything],
              event_id: String,
              type: Symbol,
              client_event_id: T.nilable(String),
              delegation_id: T.nilable(String)
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
