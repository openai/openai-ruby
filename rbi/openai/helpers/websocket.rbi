# typed: strong

module OpenAI
  class Client < OpenAI::Internal::Transport::BaseClient
    # @api private
    sig do
      params(
        request: OpenAI::Internal::Transport::BaseClient::RequestComponents,
        websocket_base_url: T.nilable(String),
        options: T.nilable(OpenAI::RequestOptions::OrHash),
        recovery_request: T.untyped,
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
    def with_websocket_connection_request(
      request:,
      websocket_base_url: nil,
      options: nil,
      recovery_request: nil,
      &block
    )
    end
  end

  module WebSocket
    # @api private
    module RecoveryConnection
      # @api private
      sig { params(url: URI::Generic).void }
      def update_recovery_url(url)
      end

      sig { returns(T::Boolean) }
      def reconnecting?
      end

      sig { returns(T::Array[String]) }
      def pending_messages
      end

      sig { returns(T::Array[String]) }
      def take_pending_messages
      end

      sig { void }
      def flush_pending
      end
    end

    # @api private
    module Resource
      sig do
        params(
          path_arguments: T.untyped,
          query: T::Hash[T.untyped, T.untyped],
          websocket_base_url: T.nilable(String),
          request_options: T.untyped,
          transport: T.untyped,
          transport_options: T::Hash[T.untyped, T.untyped],
          block: T.proc.params(connection: TypedConnection[T.untyped, T.untyped]).returns(T.untyped)
        )
          .returns(T.untyped)
      end
      def connect(
        *path_arguments,
        query: {},
        websocket_base_url: nil,
        request_options: nil,
        transport: nil,
        transport_options: {},
        &block
      )
      end
    end

    # @api private
    module TypedResource
      extend T::Generic
      include Resource

      WebSocketClientEvent = type_member
      WebSocketServerEvent = type_member

      sig do
        params(
          path_arguments: T.untyped,
          query: T::Hash[T.untyped, T.untyped],
          websocket_base_url: T.nilable(String),
          request_options: T.untyped,
          transport: T.untyped,
          transport_options: T::Hash[T.untyped, T.untyped],
          block: T
            .proc
            .params(connection: TypedConnection[WebSocketClientEvent, WebSocketServerEvent])
            .returns(T.untyped)
        )
          .returns(T.untyped)
      end
      def connect(
        *path_arguments,
        query: {},
        websocket_base_url: nil,
        request_options: nil,
        transport: nil,
        transport_options: {},
        &block
      )
      end
    end

    # @api private
    class TypedConnection
      extend T::Generic
      include Enumerable

      ClientEvent = type_member(:in)
      Elem = type_member(:out)

      sig { returns(URI::Generic) }
      attr_reader :url

      sig { returns(T.nilable(Elem)) }
      def receive
      end

      sig { params(event: T.any(ClientEvent, T::Hash[T.any(String, Symbol), T.untyped])).void }
      def send_event(event)
      end

      sig do
        params(block: T.nilable(T.proc.params(event: Elem).void)).returns(
          T.any(TypedConnection[ClientEvent, Elem], T::Enumerator[Elem])
        )
      end
      def each(&block)
      end

      sig { params(code: Integer, reason: String).void }
      def close(code: 1000, reason: "")
      end

      sig { returns(T::Boolean) }
      def closed?
      end
    end
  end

  module Errors
    class WebSocketQueueFullError < OpenAI::Errors::Error
      sig { params(message: String).returns(T.attached_class) }
      def self.new(message = "WebSocket send queue is full; event was not accepted.")
      end
    end

    class WebSocketReconnectError < OpenAI::Errors::Error
      sig { returns(T::Array[String]) }
      attr_reader :unsent_messages
      sig { returns(T.nilable(String)) }
      attr_reader :uncertain_message
      # @api private
      sig {
        params(message: String, unsent_messages: T::Array[String], uncertain_message: T.nilable(String)).returns(
          T.attached_class
        )
      }
      def self.new(message:, unsent_messages: [], uncertain_message: nil)
      end
    end

    class WebSocketConnectionError < OpenAI::Errors::Error
      sig { returns(URI::Generic) }
      attr_reader :url

      sig { returns(T.nilable(Integer)) }
      attr_reader :http_status

      sig { returns(T.nilable(Exception)) }
      def cause
      end

      # @api private
      sig do
        params(
          url: URI::Generic,
          message: T.nilable(String),
          cause: T.nilable(Exception),
          http_status: T.nilable(Integer)
        )
          .returns(T.attached_class)
      end
      def self.new(url:, message: nil, cause: nil, http_status: nil)
      end
    end

    class WebSocketProtocolError < OpenAI::Errors::Error
    end
  end
end
