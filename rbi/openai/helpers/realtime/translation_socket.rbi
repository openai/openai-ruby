# typed: strong

module OpenAI
  module Models
    module Realtime
      class TranslationSocketConnection < OpenAI::WebSocket::TypedConnection
        ClientEvent = type_member(:in) { {fixed: OpenAI::Realtime::RealtimeTranslationClientEvent::Variants} }
        Elem = type_member(:out) do
          {fixed: T.any(OpenAI::Realtime::RealtimeTranslationServerEvent::Variants, T::Hash[Symbol, T.untyped])}
        end

        include OpenAI::WebSocket::RecoveryConnection

        # @api private
        sig { params(socket: T.untyped, url: URI::Generic, recovery: T.untyped).returns(T.attached_class) }
        def self.new(socket:, url:, recovery: nil)
        end

        sig { returns(T.nilable(String)) }
        def receive_raw
        end

        sig { params(data: String).returns(Elem) }
        def parse_event(data)
        end

        sig { params(data: String).void }
        def send_raw(data)
        end

        sig { void }
        def abort
        end
      end
    end
  end

  module Resources
    class Realtime
      class Translations
        sig do
          type_parameters(:T)
            .params(
              query: T::Hash[T.untyped, T.untyped],
              websocket_base_url: T.nilable(String),
              request_options: T.nilable(OpenAI::RequestOptions::OrHash),
              transport: T.untyped,
              transport_options: T::Hash[Symbol, T.untyped],
              reconnect: T::Boolean,
              max_reconnect_attempts: Integer,
              max_queue_bytes: Integer,
              on_reconnected: T.nilable(T.proc.params(connection: OpenAI::Realtime::TranslationSocketConnection).void),
              on_reconnecting: T.nilable(
                T
                  .proc
                  .params(context: T::Hash[Symbol, T.untyped])
                  .returns(T.nilable(T.any(FalseClass, T::Hash[Symbol, T.untyped])))
              ),
              block: T
                .proc
                .params(connection: OpenAI::Realtime::TranslationSocketConnection)
                .returns(T.type_parameter(:T))
            )
            .returns(T.type_parameter(:T))
        end
        def connect(
          query: {},
          websocket_base_url: nil,
          request_options: nil,
          transport: nil,
          transport_options: {},
          reconnect: false,
          max_reconnect_attempts: 5,
          max_queue_bytes: 0,
          on_reconnected: nil,
          on_reconnecting: nil,
          &block
        )
        end
      end
    end
  end
end
