# typed: strong

module OpenAI
  module Resources

    class Live

      class Forks

        include OpenAI::WebSocket::Resource

        # @api private
        sig { params(session_id: String, query: T::Hash[T.untyped, T.untyped]).returns(T::Hash[Symbol, T.untyped]) }
        def __websocket_request(session_id, query: {})
        end

        # @api private
        sig { returns(T.untyped) }
        def __websocket_client_event
        end

        # @api private
        sig { returns(T.untyped) }
        def __websocket_server_event
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end

    end

  end
end
