# typed: strong

module OpenAI
  module Models
    module Realtime
      class BaseConnection
        sig { returns(URI::Generic) }
        attr_reader :url

        # @api private
        sig do
          params(
            socket: T.untyped,
            url: URI::Generic,
            server_event_type: T.untyped,
            client_event_type: T.untyped
          ).returns(T.attached_class)
        end
        def self.new(socket:, url:, server_event_type:, client_event_type:)
        end

        sig { returns(T.nilable(String)) }
        def receive_raw
        end

        sig { params(data: String).void }
        def send_raw(data)
        end

        sig { params(code: Integer, reason: String).void }
        def close(code: 1000, reason: "")
        end

        # @api private
        sig { void }
        def abort
        end

        sig { returns(T::Boolean) }
        def closed?
        end
      end
    end
  end
end
