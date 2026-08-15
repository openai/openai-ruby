# typed: strong

module OpenAI
  module Models
    module Realtime
      module Transports
        class AsyncWebSocket
          sig do
            params(
              tls_configurator:
                T.nilable(T.proc.params(context: OpenSSL::SSL::SSLContext).void)
            ).void
          end
          def initialize(&tls_configurator)
          end

          class Socket
            # @api private
            sig do
              params(connection: T.untyped, url: URI::Generic).returns(
                T.attached_class
              )
            end
            def self.new(connection, url:)
            end

            sig { returns(T.untyped) }
            def read
            end

            sig { params(message: String).void }
            def write(message)
            end

            sig { params(code: Integer, reason: String).void }
            def close(code: 1000, reason: "")
            end

            sig { returns(T::Boolean) }
            def closed?
            end
          end

          sig do
            params(
              url: URI::Generic,
              headers: T::Hash[String, String],
              timeout: T.nilable(Float),
              endpoint_options: T.untyped,
              block: T.proc.params(socket: Socket).returns(T.untyped)
            ).returns(T.untyped)
          end
          def open(url:, headers:, timeout:, **endpoint_options, &block)
          end
        end
      end
    end
  end
end
