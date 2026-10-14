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

      sig { params(deadline: T.nilable(Float)).returns(T::Hash[Symbol, T.any(String, Float)]) }
      def fetch(deadline: nil)
      end
    end
  end
end
