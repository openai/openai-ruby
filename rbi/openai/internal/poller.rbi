# typed: strong

module OpenAI
  module Internal
    # @api private
    class Poller
      DEFAULT_INTERVAL = T.let(T.unsafe(nil), Float)
      DEFAULT_TIMEOUT = T.let(T.unsafe(nil), Float)

      sig do
        params(
          operation: String,
          poll_interval: T.nilable(T.any(Integer, Float)),
          timeout: T.nilable(T.any(Integer, Float))
        ).returns(T.attached_class)
      end
      def self.new(operation:, poll_interval: nil, timeout: DEFAULT_TIMEOUT)
      end

      sig do
        params(
          poll_interval: T.nilable(T.any(Integer, Float)),
          timeout: T.nilable(T.any(Integer, Float))
        ).returns([T.nilable(Float), T.nilable(Float)])
      end
      def self.validate!(poll_interval: nil, timeout: DEFAULT_TIMEOUT)
      end

      sig do
        params(
          request_options: T.nilable(OpenAI::RequestOptions::OrHash),
          extra_headers: T::Hash[String, T.nilable(String)],
          resource: T.anything,
          blk: T.proc.params(options: T::Hash[Symbol, T.anything]).returns(T.anything)
        ).returns(T.anything)
      end
      def request(request_options, extra_headers: {}, resource: nil, &blk)
      end

      sig { params(resource: T.anything).returns(T.nilable(Float)) }
      def check_deadline!(resource = nil)
      end

      sig { params(resource: OpenAI::Internal::Type::BaseModel).void }
      def wait(resource)
      end
    end
  end
end
