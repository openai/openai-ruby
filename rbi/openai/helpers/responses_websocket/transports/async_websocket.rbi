# typed: strong

module OpenAI
  module Models
    module Responses
      module Transports
        class AsyncWebSocket
          # @api private
          module PeekableFramer
            # @api private
            sig { returns(T::Boolean) }
            def next_frame_compressed?
            end
          end

          # @api private
          class BoundedFramer
            # @api private
            sig { params(value: T::Boolean).returns(T::Boolean) }
            def compression_negotiated=(value)
            end
          end

          # @api private
          module BoundedInflate
            # @api private
            sig { params(max_bytes: Integer, framer: BoundedFramer).void }
            def bound_decoded_messages(max_bytes, framer)
            end
          end

          sig { void }
          def initialize
          end

          sig do
            params(
              url: URI::Generic,
              headers: T::Hash[String, String],
              timeout: T.nilable(Float),
              options: T.anything,
              block: T.proc.params(socket: T.anything).returns(T.anything)
            )
              .returns(T.anything)
          end
          def open(url:, headers:, timeout:, **options, &block)
          end
        end
      end
    end
  end
end
