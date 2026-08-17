# typed: strong

module OpenAI
  module Auth
    # @api private
    class WorkloadIdentityRequestPolicy
      sig do
        params(
          config:
            T.nilable(
              T.any(
                OpenAI::Auth::WorkloadIdentity,
                OpenAI::Auth::X509WorkloadIdentity
              )
            ),
          base_url: T.any(String, URI::Generic)
        ).returns(T.nilable(OpenAI::Auth::WorkloadIdentityRequestPolicy))
      end
      def self.build(config, base_url:)
      end

      sig do
        params(base_url: T.any(String, URI::Generic)).returns(T.attached_class)
      end
      def self.new(base_url)
      end

      sig do
        params(
          request: OpenAI::Internal::Transport::BaseClient::RequestInput,
          bearer_auth: T::Boolean,
          expected_authorization: T.nilable(String)
        ).returns(OpenAI::Internal::Transport::BaseClient::RequestInput)
      end
      def decorate_request(request, bearer_auth:, expected_authorization:)
      end

      sig do
        params(
          request: OpenAI::Internal::Transport::BaseClient::RequestInput
        ).returns(T::Boolean)
      end
      def authenticated?(request)
      end

      sig do
        params(
          request: OpenAI::Internal::Transport::BaseClient::RequestInput
        ).returns(T.nilable(String))
      end
      def authenticated_token(request)
      end

      sig do
        params(
          request: OpenAI::Internal::Transport::BaseClient::RequestInput
        ).void
      end
      def validate_before_token!(request)
      end

      sig do
        params(
          request: OpenAI::Internal::Transport::BaseClient::RequestInput,
          token: String
        ).returns(OpenAI::Internal::Transport::BaseClient::RequestInput)
      end
      def authorize(request, token)
      end

      sig do
        params(
          request: OpenAI::Internal::Transport::BaseClient::RequestInput,
          original_headers: T::Hash[String, String]
        ).void
      end
      def validate_prepared!(request, original_headers:)
      end

      # @api private
      class X509 < OpenAI::Auth::WorkloadIdentityRequestPolicy
        sig do
          params(base_url: T.any(String, URI::Generic)).returns(
            T.attached_class
          )
        end
        def self.new(base_url)
        end
      end
    end
  end
end
