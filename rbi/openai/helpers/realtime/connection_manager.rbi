# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConnectionManager
        # @api private
        sig do
          params(
            client: OpenAI::Client,
            query: T::Hash[String, String],
            websocket_base_url: T.nilable(String),
            transport: T.untyped,
            request_options: T.nilable(OpenAI::RequestOptions::OrHash),
            transport_options: T::Hash[Symbol, T.untyped],
            connection_class: T.class_of(OpenAI::Realtime::Connection)
          )
            .returns(T.attached_class)
        end
        def self.new(
          client:,
          query:,
          websocket_base_url:,
          transport:,
          request_options:,
          transport_options:,
          connection_class: OpenAI::Realtime::Connection
        )
        end

        # @api private
        sig do
          params(
            block: T
              .proc
              .params(connection: OpenAI::Realtime::Connection)
              .returns(T.untyped)
          )
            .returns(T.untyped)
        end
        def open(&block)
        end
      end
    end
  end
end
