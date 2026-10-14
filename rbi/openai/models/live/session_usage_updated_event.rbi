# typed: strong

module OpenAI
  module Models

    module Live

      class SessionUsageUpdatedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::SessionUsageUpdatedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the Live server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The event type, always `session.usage.updated`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The cumulative Live audio usage so far.
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

        # The latest measured Live context-window usage. Omitted when the context limit is
        # unknown.
        sig { returns(T.nilable(OpenAI::Live::SessionUsageUpdatedEvent::ContextWindow)) }
        attr_reader :context_window

        sig { params(context_window: OpenAI::Live::SessionUsageUpdatedEvent::ContextWindow::OrHash).void }
        attr_writer :context_window

        # Reports cumulative Live audio usage and, when available, the most recent
        # context-window usage. Delegated Responses token usage is reported separately in
        # response.event events.
        sig do
          params(

            event_id: String,

            usage: OpenAI::Live::SessionUsage::OrHash,

            client_event_id: String,

            context_window: OpenAI::Live::SessionUsageUpdatedEvent::ContextWindow::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the Live server event.
          event_id:,

          # The cumulative Live audio usage so far.
          usage:,

          # The event_id of the client command associated with this server event, when
          # supplied.
          client_event_id: nil,

          # The latest measured Live context-window usage. Omitted when the context limit is
          # unknown.
          context_window: nil,

          # The event type, always `session.usage.updated`.

          type: :"session.usage.updated"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              type: Symbol,
              usage: OpenAI::Live::SessionUsage,
              client_event_id: T.nilable(String),
              context_window: T.nilable(OpenAI::Live::SessionUsageUpdatedEvent::ContextWindow)
            }
          )
        end
        def to_hash
        end

        class ContextWindow < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::SessionUsageUpdatedEvent::ContextWindow,
              OpenAI::Internal::AnyHash
            )
          end

          # The latest active context token count divided by the Live model context limit.
          # Can decrease after compaction and may lag between measured audio frames.
          sig { returns(Float) }
          attr_accessor :usage_ratio

          # The latest measured Live context-window usage. Omitted when the context limit is
          # unknown.
          sig do
            params(

              usage_ratio: Float
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The latest active context token count divided by the Live model context limit.
            # Can decrease after compaction and may lag between measured audio frames.

            usage_ratio:
          )
          end

          sig do
            override.returns(
              {usage_ratio: Float}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
