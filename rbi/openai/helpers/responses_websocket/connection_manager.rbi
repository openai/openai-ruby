# typed: strong

module OpenAI
  module Models
    module Responses
      class ConnectionManager
        # @api private
        sig do
          params(
            client: OpenAI::Client,
            websocket_base_url: T.nilable(String),
            transport: T.anything,
            request_options: T.nilable(OpenAI::RequestOptions::OrHash),
            transport_options: T::Hash[Symbol, T.anything]
          )
            .returns(T.attached_class)
        end
        def self.new(
          client:,
          websocket_base_url:,
          transport:,
          request_options:,
          transport_options:
        )
        end

        # @api private
        sig do
          params(
            block: T.proc.params(connection: OpenAI::Responses::Connection).returns(T.anything)
          )
            .returns(T.anything)
        end
        def open(&block)
        end
      end
    end
  end
end
