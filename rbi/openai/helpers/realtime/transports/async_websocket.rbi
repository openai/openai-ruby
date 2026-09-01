# typed: strong

module OpenAI
  module Models
    module Realtime
      module Transports
        class AsyncWebSocket
          sig do
            params(
              tls_configurator: T.nilable(T.proc.params(context: OpenSSL::SSL::SSLContext).void)
            )
              .void
          end
          def initialize(&tls_configurator)
          end

          sig do
            params(
              url: URI::Generic,
              headers: T::Hash[String, String],
              timeout: T.nilable(Float),
              endpoint_options: T.anything,
              block: T.proc.params(socket: T.anything).returns(T.anything)
            )
              .returns(T.anything)
          end
          def open(url:, headers:, timeout:, **endpoint_options, &block)
          end
        end
      end
    end
  end
end
