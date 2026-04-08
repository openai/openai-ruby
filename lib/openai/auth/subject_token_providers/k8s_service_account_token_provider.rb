# frozen_string_literal: true

module OpenAI
  module Auth
    module SubjectTokenProviders
      class K8sServiceAccountTokenProvider
        include OpenAI::Auth::SubjectTokenProvider

        DEFAULT_TOKEN_PATH = "/var/run/secrets/kubernetes.io/serviceaccount/token"

        def initialize(token_path: self.class::DEFAULT_TOKEN_PATH)
          @token_path = token_path
        end

        def token_type
          TokenType::JWT
        end

        def get_token
          File.read(@token_path).strip
        rescue SystemCallError => e
          raise OpenAI::Errors::SubjectTokenProviderError.new(
            message: "Failed to read Kubernetes service account token from #{@token_path}: #{e.message}",
            provider: "kubernetes",
            cause: e
          )
        rescue StandardError => e
          raise OpenAI::Errors::SubjectTokenProviderError.new(
            message: "Unexpected error reading Kubernetes token: #{e.message}",
            provider: "kubernetes",
            cause: e
          )
        end
      end
    end
  end
end
