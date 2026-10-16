# typed: strong

module OpenAI
  module Resources

    class Realtime

      include OpenAI::WebSocket::Resource

      # @api private
      sig { params(query: T::Hash[T.untyped, T.untyped]).returns(T::Hash[Symbol, T.untyped]) }
      def __websocket_request(query: {})
      end

      # @api private
      sig { returns(T.untyped) }
      def __websocket_client_event
      end

      # @api private
      sig { returns(T.untyped) }
      def __websocket_server_event
      end

      sig { returns(OpenAI::Resources::Realtime::ClientSecrets) }
      attr_reader :client_secrets

      sig { returns(OpenAI::Resources::Realtime::Calls) }
      attr_reader :calls

      sig { returns(OpenAI::Resources::Realtime::Translations) }
      attr_reader :translations

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end

  end
end
