# typed: strong

module OpenAI
  class Client
    # @api private
    sig do
      params(
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
    def with_responses_websocket_connection_request(
      websocket_base_url: nil,
      options: nil,
      &block
    )
    end
  end

  module Errors
    class ResponsesConnectionError < OpenAI::Errors::WebSocketConnectionError
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
          http_status: T.nilable(Integer)
        )
          .returns(T.attached_class)
      end
      def self.new(url:, message: nil, http_status: nil)
      end
    end

    class ResponsesProtocolError < OpenAI::Errors::WebSocketProtocolError
      sig { returns(T.nilable(Exception)) }
      def cause
      end

      # @api private
      sig { returns(T.attached_class) }
      def self.new
      end
    end

    class ResponsesClientEventError < OpenAI::Errors::Error
      sig { returns(T.nilable(Exception)) }
      def cause
      end

      # @api private
      sig { returns(T.attached_class) }
      def self.new
      end
    end

    class ResponsesSendError < ResponsesConnectionError
      sig { returns(Symbol) }
      attr_reader :outcome

      # @api private
      sig { params(url: URI::Generic).returns(T.attached_class) }
      def self.new(url:)
      end
    end
  end

  module Resources
    class Responses
      sig do
        params(
          websocket_base_url: T.nilable(String),
          request_options: T.nilable(OpenAI::RequestOptions::OrHash),
          transport: T.anything,
          transport_options: T::Hash[Symbol, T.anything],
          block: T.proc.params(connection: OpenAI::Responses::Connection).returns(T.anything)
        )
          .returns(T.anything)
      end
      def connect(
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
