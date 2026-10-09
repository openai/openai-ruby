# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Environments

          sig { returns(OpenAI::Resources::Beta::Agents::Environments::Files) }
          attr_reader :files

          sig { returns(OpenAI::Resources::Beta::Agents::Environments::Templates) }
          attr_reader :templates

          # Creates an OpenAI-hosted environment before creating a session. Requires access
          # to the prewarming beta.
          sig {
            params(
              environment: OpenAI::Beta::Agents::EnvironmentCreateParams::Environment::OrHash,
              vault_ids: T.nilable(T::Array[String]),
              idempotency_key: String,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Beta::Agents::EnvironmentInfo)
          }
          def create(
            # Body param: The required hosting type and its configuration.
            environment:,
            # Body param: The IDs of up to 10 vaults made available to an OpenAI-hosted
            # environment.
            vault_ids: nil,
            # Header param: Deduplicates creation for 24 hours within the authenticated
            # organization, project, and creator. Retry the same JSON parameters with the same
            # key to retrieve the original environment in its current state. Different
            # parameters or an incomplete hosted creation return 409. Deleted environments are
            # not recreated. After retention expires, the key may create a new environment.
            # Without this header, each request creates a new environment.
            idempotency_key: nil,
            request_options: {}
          )
          end

          # Retrieves an execution environment's connection status and safe installed
          # metadata. See
          # [environment lifecycle](https://developers.openai.com/api/docs/guides/agents-api/environments/lifecycle).
          sig {
            params(environment_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Beta::Agents::EnvironmentInfo
            )
          }
          def retrieve(
            # The ID of the environment.
            environment_id,
            request_options: {}
          )
          end

          # Lists OpenAI-hosted environments owned by the authenticated principal. Requires
          # access to the prewarming beta.
          sig {
            params(
              after: String,
              limit: Integer,
              order: OpenAI::Beta::Agents::EnvironmentListParams::Order::OrSymbol,
              type: OpenAI::Beta::Agents::EnvironmentListParams::Type::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::Agents::EnvironmentInfo])
          }
          def list(
            # Return environments after this environment ID in the selected order.
            after: nil,
            # The maximum number of environments to return, between 1 and 100. Defaults to 20.
            limit: nil,
            # The order in which environments are returned. Defaults to `desc`.
            order: nil,
            # The hosting type to list. Defaults to `openai_hosted`.
            type: nil,
            request_options: {}
          )
          end

          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end

      end

    end

  end
end
