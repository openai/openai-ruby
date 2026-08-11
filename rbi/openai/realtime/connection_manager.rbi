# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConnectionManager
        # @api private
        sig do
          params(
            client: OpenAI::Client,
            path: String,
            query: T::Hash[String, String],
            connection_class: T.class_of(OpenAI::Realtime::BaseConnection),
            transport: T.untyped,
            request_options: T.nilable(OpenAI::RequestOptions::OrHash),
            transport_options: T::Hash[Symbol, T.untyped]
          ).returns(T.attached_class)
        end
        def self.new(
          client:,
          path:,
          query:,
          connection_class:,
          transport:,
          request_options:,
          transport_options:
        )
        end

        sig do
          params(
            block:
              T
                .proc
                .params(connection: OpenAI::Realtime::BaseConnection)
                .returns(T.untyped)
          ).returns(T.untyped)
        end
        def open(&block)
        end
      end
    end
  end
end
