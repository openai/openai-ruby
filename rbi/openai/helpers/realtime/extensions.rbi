# typed: strong

module OpenAI
  class Client
    # @api private
    sig do
      params(
        path: String,
        query: T::Hash[String, String],
        websocket_base_url: T.nilable(String),
        options: T.nilable(OpenAI::RequestOptions::OrHash)
      )
        .returns(OpenAI::Internal::Transport::BaseClient::RequestInput)
    end
    def realtime_connection_request(
      path:,
      query:,
      websocket_base_url: nil,
      options: nil
    )
    end

    # @api private
    sig do
      params(
        path: String,
        query: T::Hash[String, String],
        websocket_base_url: T.nilable(String),
        options: T.nilable(OpenAI::RequestOptions::OrHash),
        block: T
          .proc
          .params(
            request: OpenAI::Internal::Transport::BaseClient::RequestInput,
            mark_handshake_completed: T.proc.void
          )
          .returns(T.untyped)
      )
        .returns(T.untyped)
    end
    def with_realtime_connection_request(
      path:,
      query:,
      websocket_base_url: nil,
      options: nil,
      &block
    )
    end
  end

  module Errors
    class RealtimeConnectionError < OpenAI::Errors::Error
      sig { returns(URI::Generic) }
      attr_reader :url

      # @api private
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

    class RealtimeProtocolError < OpenAI::Errors::Error
      sig { returns(String) }
      attr_reader :data

      sig { returns(T.nilable(StandardError)) }
      def cause
      end

      # @api private
      sig do
        params(data: String, cause: T.nilable(StandardError)).returns(
          T.attached_class
        )
      end
      def self.new(data:, cause: nil)
      end
    end
  end

  module Resources
    class Realtime
      sig do
        params(
          model: String,
          websocket_base_url: T.nilable(String),
          request_options: T.nilable(OpenAI::RequestOptions::OrHash),
          transport: T.untyped,
          transport_options: T::Hash[Symbol, T.untyped],
          block: T
            .proc
            .params(connection: OpenAI::Realtime::Connection)
            .returns(T.untyped)
        )
          .returns(T.untyped)
      end
      def connect(
        model:,
        websocket_base_url: nil,
        request_options: nil,
        transport: nil,
        transport_options: {},
        &block
      )
      end

      sig do
        params(
          websocket_base_url: T.nilable(String),
          request_options: T.nilable(OpenAI::RequestOptions::OrHash),
          transport: T.untyped,
          transport_options: T::Hash[Symbol, T.untyped],
          block: T
            .proc
            .params(connection: OpenAI::Realtime::Connection)
            .returns(T.untyped)
        )
          .returns(T.untyped)
      end
      def connect_transcription(
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
