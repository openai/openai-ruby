# typed: strong

module OpenAI
  module Providers
    class << self
      sig do
        params(
          region: T.nilable(String),
          base_url: T.nilable(String),
          api_key: T.nilable(String),
          token_provider: T.nilable(T.proc.returns(String)),
          access_key_id: T.nilable(String),
          secret_access_key: T.nilable(String),
          session_token: T.nilable(String),
          profile: T.nilable(String),
          credentials_provider: T.untyped
        ).returns(OpenAI::Internal::Provider::Handle)
      end
      def bedrock(
        region: nil,
        base_url: nil,
        api_key: nil,
        token_provider: nil,
        access_key_id: nil,
        secret_access_key: nil,
        session_token: nil,
        profile: nil,
        credentials_provider: nil
      )
      end
    end
  end
end
