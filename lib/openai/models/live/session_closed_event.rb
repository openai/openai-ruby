# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class SessionClosedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute reason
        #   Why the Live session ended: `close_requested` for an application close or hangup
        #   request, `expired` for the session duration limit, `content` for a safety
        #   filter, `remote_hangup` for a graceful remote disconnect, or `connection_lost`
        #   for an unexpected primary or upstream disconnection.
        #
        #   @return [Symbol, OpenAI::Models::Live::SessionClosedEvent::Reason]
        required :reason, union: -> { OpenAI::Live::SessionClosedEvent::Reason }

        # @!attribute session
        #   The resolved Live session configuration and server-assigned session metadata.
        #
        #   @return [OpenAI::Models::Live::SessionResource]
        required :session, -> { OpenAI::Live::SessionResource }

        # @!attribute type
        #   The event type, always `session.closed`.
        #
        #   @return [Symbol, :"session.closed"]
        required :type, const: :"session.closed"

        # @!attribute usage
        #   The final cumulative Live audio usage after session finalization.
        #
        #   @return [OpenAI::Models::Live::SessionUsage]
        required :usage, -> { OpenAI::Live::SessionUsage }

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!method initialize(event_id:, reason:, session:, usage:, client_event_id: nil, type: :"session.closed")
        #   Returned after the Live session finishes finalizing, with the close reason,
        #   final session snapshot, and cumulative audio usage. A connection closing without
        #   this event does not confirm successful finalization.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param reason [Symbol, OpenAI::Models::Live::SessionClosedEvent::Reason]
        #     Why the Live session ended: `close_requested` for an application close or hangup
        #     request, `expired` for the session duration limit, `content` for a safety
        #     filter, `remote_hangup` for a graceful remote disconnect, or `connection_lost`
        #     for an unexpected primary or upstream disconnection.
        #
        #   @param session [OpenAI::Models::Live::SessionResource]
        #     The resolved Live session configuration and server-assigned session metadata.
        #
        #   @param usage [OpenAI::Models::Live::SessionUsage]
        #     The final cumulative Live audio usage after session finalization.
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param type [Symbol, :"session.closed"]
        #     The event type, always `session.closed`.

        # Why the Live session ended: `close_requested` for an application close or hangup
        # request, `expired` for the session duration limit, `content` for a safety
        # filter, `remote_hangup` for a graceful remote disconnect, or `connection_lost`
        # for an unexpected primary or upstream disconnection.
        #
        # @see OpenAI::Models::Live::SessionClosedEvent#reason
        module Reason
          extend OpenAI::Internal::Type::Union

          variant const: -> { OpenAI::Models::Live::SessionClosedEvent::Reason::CLOSE_REQUESTED }

          variant const: -> { OpenAI::Models::Live::SessionClosedEvent::Reason::EXPIRED }

          variant const: -> { OpenAI::Models::Live::SessionClosedEvent::Reason::CONTENT }

          variant const: -> { OpenAI::Models::Live::SessionClosedEvent::Reason::REMOTE_HANGUP }

          variant const: -> { OpenAI::Models::Live::SessionClosedEvent::Reason::CONNECTION_LOST }

          # @!method self.variants
          #   @return [Array(Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { OpenAI::Live::SessionClosedEvent::Reason::TaggedSymbol }
          end

          # @!group

          CLOSE_REQUESTED = :close_requested
          EXPIRED = :expired
          CONTENT = :content
          REMOTE_HANGUP = :remote_hangup
          CONNECTION_LOST = :connection_lost

          # @!endgroup
        end
      end
    end
  end
end
