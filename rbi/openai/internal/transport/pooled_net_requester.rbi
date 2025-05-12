# typed: strong

module OpenAI
  module Internal
    module Transport
      # @api private
      class PooledNetRequester
        extend OpenAI::Internal::Util::SorbetRuntimeSupport

        Request =
          T.type_alias do
            {
              method: Symbol,
              url: URI::Generic,
              headers: T::Hash[String, String],
              body: T.anything,
              deadline: Float
            }
          end

        # from the golang stdlib
        # https://github.com/golang/go/blob/c8eced8580028328fde7c03cbfcb720ce15b2358/src/net/http/transport.go#L49
        KEEP_ALIVE_TIMEOUT = 30

        class << self
          # @api private
          sig { params(url: URI::Generic).returns(Net::HTTP) }
          def connect(url)
          end

          # @api private
          sig { params(conn: Net::HTTP, deadline: Float).void }
          def calibrate_socket_timeout(conn, deadline)
          end

          # @api private
          sig do
            params(
              request: OpenAI::Internal::Transport::PooledNetRequester::Request,
              blk: T.proc.params(arg0: String).void
            ).returns([Net::HTTPGenericRequest, T.proc.void])
          end
          def build_request(request, &blk)
          end
        end

        # @api private
        sig do
          params(
            url: URI::Generic,
            deadline: Float,
            blk: T.proc.params(arg0: Net::HTTP).void
          ).void
        end
        private def with_pool(url, deadline:, &blk)
        end

        # @api private
        sig do
          params(
            request: OpenAI::Internal::Transport::PooledNetRequester::Request
          ).returns([Integer, Net::HTTPResponse, T::Enumerable[String]])
        end
        def execute(request)
        end

        # @api private
        sig { params(size: Integer).returns(T.attached_class) }
        def self.new(size: Etc.nprocessors)
        end
      end
    end
  end
end
