# typed: strong

module OpenAI
  module Models

    module Live

      class InfoEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::InfoEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # A machine-readable code for the notice, such as `data_channel_permissions`.
        sig { returns(String) }
        attr_accessor :code

        # The unique ID of the Live server event.
        sig { returns(String) }
        attr_accessor :event_id

        # A human-readable explanation of the Live session notice.
        sig { returns(String) }
        attr_accessor :message

        # The event type, always `info`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The event_id of the client command associated with this server event, when
        # supplied.
        sig { returns(T.nilable(String)) }
        attr_reader :client_event_id

        sig { params(client_event_id: String).void }
        attr_writer :client_event_id

        # An informational notice about the Live session, such as the event permissions
        # applied to a frontend data channel.
        sig do
          params(

            code: String,

            event_id: String,

            message: String,

            client_event_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # A machine-readable code for the notice, such as `data_channel_permissions`.
          code:,

          # The unique ID of the Live server event.
          event_id:,

          # A human-readable explanation of the Live session notice.
          message:,

          # The event_id of the client command associated with this server event, when
          # supplied.
          client_event_id: nil,

          # The event type, always `info`.

          type: :info
        )
        end

        sig do
          override.returns(
            {code: String, event_id: String, message: String, type: Symbol, client_event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
