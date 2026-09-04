# typed: strong

module OpenAI
  module Auth
    class X509TokenExchange
      sig do
        params(config: OpenAI::Auth::X509WorkloadIdentity, transport: OpenAI::Auth::X509Transport).void
      end
      def initialize(config, transport:)
      end

      sig { returns(String) }
      def inspect
      end

      # @api private
      sig do
        params(identity: OpenAI::Auth::X509WorkloadIdentity, transport: OpenAI::Auth::X509Transport)
          .returns(T::Boolean)
      end
      def bound_to?(identity, transport:)
      end

      sig do
        params(
          deadline: T.nilable(Float),
          block: T.nilable(T.proc.params(response: OpenAI::HTTPClient::Response).void)
        )
          .returns(T::Hash[Symbol, T.any(String, Float)])
      end
      def fetch(deadline: nil, &block)
      end
    end
  end
end
