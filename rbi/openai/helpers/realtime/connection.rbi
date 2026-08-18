# typed: strong

module OpenAI
  module Models
    module Realtime
      class Connection
        include Enumerable

        ServerEvent =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeServerEvent::Variants,
              OpenAI::Realtime::UnknownServerEvent
            )
          end

        ClientEvent =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeClientEvent::Variants,
              OpenAI::Internal::AnyHash
            )
          end

        Elem = type_member { { fixed: ServerEvent } }

        sig { returns(URI::Generic) }
        attr_reader :url

        sig { returns(OpenAI::Realtime::ConnectionResources::Session) }
        attr_reader :session

        sig { returns(OpenAI::Realtime::ConnectionResources::Response) }
        attr_reader :response

        sig { returns(OpenAI::Realtime::ConnectionResources::Conversation) }
        attr_reader :conversation

        # @api private
        sig { params(socket: T.untyped, url: URI::Generic).returns(T.attached_class) }
        def self.new(socket:, url:)
        end

        sig do
          params(block: T.nilable(T.proc.params(event: ServerEvent).void)).returns(
            T.any(OpenAI::Realtime::Connection, T::Enumerator[ServerEvent])
          )
        end
        def each(&block)
        end

        sig { returns(T.nilable(ServerEvent)) }
        def receive
        end

        sig { returns(T.nilable(String)) }
        def receive_raw
        end

        sig { params(data: String).returns(ServerEvent) }
        def parse_event(data)
        end

        sig { params(event: ClientEvent).void }
        def send_event(event)
        end

        sig { params(data: String).void }
        def send_raw(data)
        end

        sig { params(code: Integer, reason: String).void }
        def close(code: 1000, reason: "")
        end

        # @api private
        sig { void }
        def abort
        end

        sig { returns(T::Boolean) }
        def closed?
        end
      end
    end
  end
end
