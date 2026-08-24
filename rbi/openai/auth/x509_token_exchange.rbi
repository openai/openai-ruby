# typed: strong

module OpenAI
  module Auth
    class X509TokenExchange
      sig do
        params(config: OpenAI::Auth::X509WorkloadIdentity, transport: OpenAI::Auth::X509Transport).void
      end
      def initialize(config, transport:)
      end

      sig { params(deadline: T.nilable(Float)).returns(T::Hash[Symbol, T.any(String, Float)]) }
      def fetch(deadline: nil)
      end
    end
  end
end
