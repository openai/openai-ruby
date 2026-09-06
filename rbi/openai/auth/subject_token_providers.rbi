# typed: strong

module OpenAI
  module Auth
    module SubjectTokenProviders
      class K8sServiceAccountTokenProvider
        include OpenAI::Auth::SubjectTokenProvider

        sig { params(token_path: String).void }
        def initialize(token_path: "/var/run/secrets/kubernetes.io/serviceaccount/token")
        end

        sig { returns(Symbol) }
        def token_type
        end

        sig { returns(String) }
        def get_token
        end
      end

      class AzureManagedIdentityTokenProvider
        include OpenAI::Auth::SubjectTokenProvider

        sig do
          params(
            resource: String,
            object_id: T.nilable(String),
            client_id: T.nilable(String),
            msi_res_id: T.nilable(String),
            api_version: String,
            timeout: Float
          )
            .void
        end
        def initialize(
          resource: "https://management.azure.com/",
          object_id: nil,
          client_id: nil,
          msi_res_id: nil,
          api_version: "2018-02-01",
          timeout: 10.0
        )
        end

        sig { returns(Symbol) }
        def token_type
        end

        sig { returns(String) }
        def get_token
        end
      end

      class GCPIDTokenProvider
        include OpenAI::Auth::SubjectTokenProvider

        sig { params(audience: String, timeout: Float).void }
        def initialize(audience: "https://api.openai.com/v1", timeout: 10.0)
        end

        sig { returns(Symbol) }
        def token_type
        end

        sig { returns(String) }
        def get_token
        end
      end
    end
  end
end
