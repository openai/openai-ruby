# typed: strong

module OpenAI
  class Client < OpenAI::Internal::Transport::BaseClient
    # @api private
    sig do
      params(
        model: String,
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
    def with_translation_connection_request(model:, websocket_base_url: nil, options: nil, &block)
    end
  end

  module Errors
    class TranslationConnectionError < OpenAI::Errors::WebSocketConnectionError
    end

    class TranslationProtocolError < OpenAI::Errors::WebSocketProtocolError
      sig { returns(T.attached_class) }
      def self.new
      end
    end
  end

  module Models
    module Realtime
      class UnknownTranslationServerEvent < OpenAI::Realtime::UnknownServerEvent
        sig { returns(String) }
        def inspect
        end

        alias to_s inspect
      end

      class TranslationConnection
        include Enumerable
        ServerEvent = T.type_alias do
          T.any(
            OpenAI::Realtime::RealtimeTranslationServerEvent::Variants,
            OpenAI::Realtime::UnknownTranslationServerEvent
          )
        end

        ClientEvent = T.type_alias do
          T.any(OpenAI::Realtime::RealtimeTranslationClientEvent::Variants, T::Hash[T.any(String, Symbol), T.anything])
        end

        Elem = type_member { {fixed: ServerEvent} }
        sig { returns(URI::Generic) }
        attr_reader :url
        sig { params(socket: T.anything, url: URI::Generic).returns(T.attached_class) }
        def self.new(socket:, url:)
        end

        sig do
          params(block: T.nilable(T.proc.params(event: ServerEvent).void)).returns(
            T.any(OpenAI::Realtime::TranslationConnection, T::Enumerator[ServerEvent])
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

        sig do
          params(timeout: Numeric, block: T.proc.params(event: ServerEvent).void)
            .returns(OpenAI::Realtime::RealtimeTranslationSessionClosedEvent)
        end
        def finish(timeout:, &block)
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
    class Realtime
      sig do
        type_parameters(:T)
          .params(
            model: String,
            websocket_base_url: T.nilable(String),
            request_options: T.nilable(OpenAI::RequestOptions::OrHash),
            transport: T.untyped,
            transport_options: T::Hash[Symbol, T.anything],
            block: T.proc.params(connection: OpenAI::Realtime::TranslationConnection).returns(T.type_parameter(:T))
          )
          .returns(T.type_parameter(:T))
      end
      def connect_translation(
        model:,
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
