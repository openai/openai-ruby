# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Vaults
          class Credentials
            # Creates a vault credential. Secret values are write-only and are never returned.
            # See
            # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
            #
            # @overload create(vault_id, auth:, name:, request_options: {})
            #
            # @param vault_id [String]
            #   The ID of the vault.
            #
            # @param auth [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthCreateParam::StaticBearer]
            #   The authentication method and secret values to store for the MCP server.
            #
            # @param name [String]
            #   The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
            #   trimming.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Vaults::Credential]
            #
            # @see OpenAI::Models::Beta::Agents::Vaults::CredentialCreateParams
            def create(vault_id, params)
              parsed, options = OpenAI::Beta::Agents::Vaults::CredentialCreateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["vaults/%1$s/credentials", vault_id],
                body: parsed,
                model: OpenAI::Beta::Agents::Vaults::Credential,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
              )
            end

            # Retrieves vault credential metadata without returning secret values. See
            # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
            #
            # @overload retrieve(credential_id, vault_id:, request_options: {})
            #
            # @param credential_id [String]
            #   The ID of the vault credential.
            #
            # @param vault_id [String]
            #   The ID of the vault.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Vaults::Credential]
            #
            # @see OpenAI::Models::Beta::Agents::Vaults::CredentialRetrieveParams
            def retrieve(credential_id, params)
              parsed, options = OpenAI::Beta::Agents::Vaults::CredentialRetrieveParams.dump_request(params)
              vault_id = parsed.delete(:vault_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :get,
                path: ["vaults/%1$s/credentials/%2$s", vault_id, credential_id],
                model: OpenAI::Beta::Agents::Vaults::Credential,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
              )
            end

            # Rotates a vault credential's write-only secret and returns only credential
            # metadata. See
            # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
            #
            # @overload update(credential_id, vault_id:, auth:, request_options: {})
            #
            # @param credential_id [String]
            #   Path param: The ID of the vault credential.
            #
            # @param vault_id [String]
            #   Path param: The ID of the vault.
            #
            # @param auth [OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth, OpenAI::Models::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer]
            #   Body param: Replacement values for the credential's existing authentication
            #   method.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Vaults::Credential]
            #
            # @see OpenAI::Models::Beta::Agents::Vaults::CredentialUpdateParams
            def update(credential_id, params)
              parsed, options = OpenAI::Beta::Agents::Vaults::CredentialUpdateParams.dump_request(params)
              vault_id = parsed.delete(:vault_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :post,
                path: ["vaults/%1$s/credentials/%2$s", vault_id, credential_id],
                body: parsed,
                model: OpenAI::Beta::Agents::Vaults::Credential,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
              )
            end

            # Lists a vault's credentials using ID-based pagination without returning secret
            # values. See
            # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
            #
            # @overload list(vault_id, after: nil, limit: nil, order: nil, status: nil, request_options: {})
            #
            # @param vault_id [String]
            #   The ID of the vault.
            #
            # @param after [String]
            #   Return resources after this resource ID in the selected order.
            #
            # @param limit [Integer, nil]
            #   The maximum number of resources to return. Defaults to 20. Values are clamped
            #   between 1 and 100.
            #
            # @param order [Symbol, OpenAI::Models::Beta::Agents::Vaults::CredentialListParams::Order]
            #   Sort order by the `created_at` timestamp. Use `asc` for ascending order or
            #   `desc` for descending order. Defaults to `desc`.
            #
            # @param status [Symbol, OpenAI::Models::Beta::Agents::VaultStatus, Array<Symbol, OpenAI::Models::Beta::Agents::VaultStatus>]
            #   Filter by one status or a list, such as `status=active` or
            #   `status[]=active&status[]=archived`. Both statuses are included by default.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Agents::Vaults::Credential>]
            #
            # @see OpenAI::Models::Beta::Agents::Vaults::CredentialListParams
            def list(vault_id, params = {})
              parsed, options = OpenAI::Beta::Agents::Vaults::CredentialListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["vaults/%1$s/credentials", vault_id],
                query: query,
                page: OpenAI::Internal::CursorPage,
                model: OpenAI::Beta::Agents::Vaults::Credential,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
              )
            end

            # Deletes a vault credential. See
            # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
            #
            # @overload delete(credential_id, vault_id:, request_options: {})
            #
            # @param credential_id [String]
            #   The ID of the vault credential.
            #
            # @param vault_id [String]
            #   The ID of the vault.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Vaults::CredentialDeleted]
            #
            # @see OpenAI::Models::Beta::Agents::Vaults::CredentialDeleteParams
            def delete(credential_id, params)
              parsed, options = OpenAI::Beta::Agents::Vaults::CredentialDeleteParams.dump_request(params)
              vault_id = parsed.delete(:vault_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :delete,
                path: ["vaults/%1$s/credentials/%2$s", vault_id, credential_id],
                model: OpenAI::Beta::Agents::Vaults::CredentialDeleted,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
              )
            end

            # @api private
            #
            # @param client [OpenAI::Client]
            def initialize(client:)
              @client = client
            end
          end
        end
      end
    end
  end
end
