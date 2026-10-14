# typed: strong

module OpenAI
  module Models

    module Live

      class SessionClosedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::SessionClosedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the Live server event.
        sig { returns(String) }
        attr_accessor :event_id

        # Why the Live session ended: `close_requested` for an application close or hangup
        # request, `expired` for the session duration limit, `content` for a safety
        # filter, `remote_hangup` for a graceful remote disconnect, or `connection_lost`
        # for an unexpected primary or upstream disconnection.
        sig { returns(OpenAI::Live::SessionClosedEvent::Reason::OrSymbol) }
        attr_accessor :reason

        # The resolved Live session configuration and server-assigned session metadata.
        sig { returns(OpenAI::Live::SessionResource) }
        attr_reader :session

        sig { params(session: OpenAI::Live::SessionResource::OrHash).void }
        attr_writer :session

        # The event type, always `session.closed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The final cumulative Live audio usage after session finalization.
        sig { returns(OpenAI::Live::SessionUsage) }
        attr_reader :usage

        sig { params(usage: OpenAI::Live::SessionUsage::OrHash).void }
        attr_writer :usage

        # The event_id of the client command associated with this server event, when
        # supplied.
        sig { returns(T.nilable(String)) }
        attr_reader :client_event_id

        sig { params(client_event_id: String).void }
        attr_writer :client_event_id

        # Returned after the Live session finishes finalizing, with the close reason,
        # final session snapshot, and cumulative audio usage. A connection closing without
        # this event does not confirm successful finalization.
        sig do
          params(

            event_id: String,

            reason: OpenAI::Live::SessionClosedEvent::Reason::OrSymbol,

            session: OpenAI::Live::SessionResource::OrHash,

            usage: OpenAI::Live::SessionUsage::OrHash,

            client_event_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the Live server event.
          event_id:,

          # Why the Live session ended: `close_requested` for an application close or hangup
          # request, `expired` for the session duration limit, `content` for a safety
          # filter, `remote_hangup` for a graceful remote disconnect, or `connection_lost`
          # for an unexpected primary or upstream disconnection.
          reason:,

          # The resolved Live session configuration and server-assigned session metadata.
          session:,

          # The final cumulative Live audio usage after session finalization.
          usage:,

          # The event_id of the client command associated with this server event, when
          # supplied.
          client_event_id: nil,

          # The event type, always `session.closed`.

          type: :"session.closed"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              reason: OpenAI::Live::SessionClosedEvent::Reason::OrSymbol,
              session: OpenAI::Live::SessionResource,
              type: Symbol,
              usage: OpenAI::Live::SessionUsage,
              client_event_id: T.nilable(String)
            }
          )
        end
        def to_hash
        end

        # Why the Live session ended: `close_requested` for an application close or hangup
        # request, `expired` for the session duration limit, `content` for a safety
        # filter, `remote_hangup` for a graceful remote disconnect, or `connection_lost`
        # for an unexpected primary or upstream disconnection.
        module Reason
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { OpenAI::Live::SessionClosedEvent::Reason::TaggedSymbol }

          sig { override.returns(T::Array[OpenAI::Live::SessionClosedEvent::Reason::Variants]) }
          def self.variants
          end

          TaggedSymbol = T.type_alias do
            T.all(Symbol, OpenAI::Live::SessionClosedEvent::Reason)
          end

          OrSymbol = T.type_alias { T.any(Symbol, String) }

          CLOSE_REQUESTED = T.let(:close_requested, OpenAI::Live::SessionClosedEvent::Reason::TaggedSymbol)
          EXPIRED = T.let(:expired, OpenAI::Live::SessionClosedEvent::Reason::TaggedSymbol)
          CONTENT = T.let(:content, OpenAI::Live::SessionClosedEvent::Reason::TaggedSymbol)
          REMOTE_HANGUP = T.let(:remote_hangup, OpenAI::Live::SessionClosedEvent::Reason::TaggedSymbol)
          CONNECTION_LOST = T.let(:connection_lost, OpenAI::Live::SessionClosedEvent::Reason::TaggedSymbol)

        end

      end

    end

  end
end
