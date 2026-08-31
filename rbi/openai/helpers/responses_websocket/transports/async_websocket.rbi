# typed: strong

module OpenAI
  module Models
    module Responses
      module Transports
        class AsyncWebSocket
          sig { void }
          def initialize
          end

          sig do
            params(
              url: URI::Generic,
              headers: T::Hash[String, String],
              timeout: T.nilable(Float),
              options: T.untyped,
              block: T.proc.params(socket: T.untyped).returns(T.untyped)
            )
              .returns(T.untyped)
          end
          def open(url:, headers:, timeout:, **options, &block)
          end
        end
      end
    end
  end
end
