# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class SessionUsageUpdatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute type
        #   The event type, always `session.usage.updated`.
        #
        #   @return [Symbol, :"session.usage.updated"]
        required :type, const: :"session.usage.updated"

        # @!attribute usage
        #   The cumulative Live audio usage so far.
        #
        #   @return [OpenAI::Models::Live::SessionUsage]
        required :usage, -> { OpenAI::Live::SessionUsage }

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!attribute context_window
        #   The latest measured Live context-window usage. Omitted when the context limit is
        #   unknown.
        #
        #   @return [OpenAI::Models::Live::SessionUsageUpdatedEvent::ContextWindow, nil]
        optional :context_window, -> { OpenAI::Live::SessionUsageUpdatedEvent::ContextWindow }

        # @!method initialize(event_id:, usage:, client_event_id: nil, context_window: nil, type: :"session.usage.updated")
        #   Reports cumulative Live audio usage and, when available, the most recent
        #   context-window usage. Delegated Responses token usage is reported separately in
        #   response.event events.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param usage [OpenAI::Models::Live::SessionUsage]
        #     The cumulative Live audio usage so far.
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param context_window [OpenAI::Models::Live::SessionUsageUpdatedEvent::ContextWindow]
        #     The latest measured Live context-window usage. Omitted when the context limit is
        #     unknown.
        #
        #   @param type [Symbol, :"session.usage.updated"]
        #     The event type, always `session.usage.updated`.

        # @see OpenAI::Models::Live::SessionUsageUpdatedEvent#context_window
        class ContextWindow < OpenAI::Internal::Type::BaseModel
          # @!attribute usage_ratio
          #   The latest active context token count divided by the Live model context limit.
          #   Can decrease after compaction and may lag between measured audio frames.
          #
          #   @return [Float]
          required :usage_ratio, Float

          # @!method initialize(usage_ratio:)
          #   The latest measured Live context-window usage. Omitted when the context limit is
          #   unknown.
          #
          #   @param usage_ratio [Float]
          #     The latest active context token count divided by the Live model context limit.
          #     Can decrease after compaction and may lag between measured audio frames.
        end
      end
    end
  end
end
