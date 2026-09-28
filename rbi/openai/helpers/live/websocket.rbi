# typed: strong

module OpenAI
  class Client < OpenAI::Internal::Transport::BaseClient
    # @api private
    sig do
      params(
        path: T.any(String, T::Array[String]),
        websocket_base_url: T.nilable(String),
        options: T.nilable(OpenAI::RequestOptions::OrHash),
        block: T
          .proc
          .params(
            request: OpenAI::Internal::Transport::BaseClient::RequestInput,
            mark_handshake_completed: T.proc.void
          )
          .returns(T.anything)
      )
        .returns(T.anything)
    end
    def with_live_websocket_connection_request(path: "live/sessions", websocket_base_url: nil, options: nil, &block)
    end
  end

  module Errors
    class LiveConnectionError < OpenAI::Errors::WebSocketConnectionError
    end

    class LiveProtocolError < OpenAI::Errors::WebSocketProtocolError
      sig { returns(T.attached_class) }
      def self.new
      end
    end
  end

  module Models
    module Live
      class UnknownServerEvent
        sig { returns(Symbol) }
        attr_reader :type
        sig { returns(T::Hash[T.any(String, Symbol), T.anything]) }
        attr_reader :data
        sig { params(data: T::Hash[T.any(String, Symbol), T.anything]).returns(T.attached_class) }
        def self.new(data:)
        end

        sig { returns(T::Hash[T.any(String, Symbol), T.anything]) }
        def to_h
        end

        sig { returns(String) }
        def inspect
        end

        alias to_s inspect
      end

      class Connection
        include Enumerable
        ServerEvent = T.type_alias { T.any(OpenAI::Live::ServerEvent::Variants, OpenAI::Live::UnknownServerEvent) }
        ClientEvent = T.type_alias do
          T.any(OpenAI::Live::ClientEvent::Variants, T::Hash[T.any(String, Symbol), T.anything])
        end

        Elem = type_member { {fixed: ServerEvent} }
        sig { returns(URI::Generic) }
        attr_reader :url
        sig { params(socket: T.anything, url: URI::Generic).returns(T.attached_class) }
        def self.new(socket:, url:)
        end

        sig do
          params(block: T.nilable(T.proc.params(event: ServerEvent).void)).returns(
            T.any(OpenAI::Live::Connection, T::Enumerator[ServerEvent])
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

        sig { params(event: ClientEvent).void }
        def send_event(event)
        end

        sig { params(data: String).void }
        def send_raw(data)
        end

        sig { params(code: Integer, reason: String).void }
        def close(code: 1000, reason: "")
        end

        sig { void }
        def abort
        end

        sig { returns(T::Boolean) }
        def closed?
        end
      end

      class SidebandConnection < Connection
        Elem = type_member { {fixed: Connection::ServerEvent} }
      end

      # Fork sessions use distinct input/output variants; expose that protocol
      # directly so the primary Connection's shipped signatures stay precise.
      class ForkConnection
        include Enumerable
        ServerEvent = T.type_alias { T.any(OpenAI::Live::ForkServerEvent::Variants, OpenAI::Live::UnknownServerEvent) }
        ClientEvent = T.type_alias do
          T.any(OpenAI::Live::ForkClientEvent::Variants, T::Hash[T.any(String, Symbol), T.anything])
        end

        Elem = type_member { {fixed: ServerEvent} }
        sig { returns(URI::Generic) }
        attr_reader :url
        sig { params(socket: T.anything, url: URI::Generic).returns(T.attached_class) }
        def self.new(socket:, url:)
        end

        sig do
          params(block: T.nilable(T.proc.params(event: ServerEvent).void)).returns(
            T.any(OpenAI::Live::ForkConnection, T::Enumerator[ServerEvent])
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

        sig { params(event: ClientEvent).void }
        def send_event(event)
        end

        sig { params(data: String).void }
        def send_raw(data)
        end

        sig { params(code: Integer, reason: String).void }
        def close(code: 1000, reason: "")
        end

        sig { void }
        def abort
        end

        sig { returns(T::Boolean) }
        def closed?
        end
      end
    end
  end

  module Resources
    class Live
      sig do
        type_parameters(:T)
          .params(
            websocket_base_url: T.nilable(String),
            request_options: T.nilable(OpenAI::RequestOptions::OrHash),
            transport: T.untyped,
            transport_options: T::Hash[Symbol, T.anything],
            block: T.proc.params(connection: OpenAI::Live::Connection).returns(T.type_parameter(:T))
          )
          .returns(T.type_parameter(:T))
      end
      def connect(websocket_base_url: nil, request_options: nil, transport: nil, transport_options: {}, &block)
      end

      class Sideband
        sig do
          type_parameters(:T)
            .params(
              session_id: String,
              websocket_base_url: T.nilable(String),
              request_options: T.nilable(OpenAI::RequestOptions::OrHash),
              transport: T.untyped,
              transport_options: T::Hash[Symbol, T.anything],
              block: T.proc.params(connection: OpenAI::Live::SidebandConnection).returns(T.type_parameter(:T))
            )
            .returns(T.type_parameter(:T))
        end
        def connect(
          session_id,
          websocket_base_url: nil,
          request_options: nil,
          transport: nil,
          transport_options: {},
          &block
        )
        end
      end

      class Forks
        sig do
          type_parameters(:T)
            .params(
              session_id: String,
              websocket_base_url: T.nilable(String),
              request_options: T.nilable(OpenAI::RequestOptions::OrHash),
              transport: T.untyped,
              transport_options: T::Hash[Symbol, T.anything],
              block: T.proc.params(connection: OpenAI::Live::ForkConnection).returns(T.type_parameter(:T))
            )
            .returns(T.type_parameter(:T))
        end
        def connect(
          session_id,
          websocket_base_url: nil,
          request_options: nil,
          transport: nil,
          transport_options: {},
          &block
        )
        end
      end
    end
  end
end
