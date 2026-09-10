# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Vaults

          class Credentials

            # Creates a vault credential. Secret values are write-only and are never returned.
            # See
            # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
            sig {
              params(
                vault_id: String,
                auth: T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::McpOauth::OrHash,
                  OpenAI::Beta::Agents::Vaults::CredentialAuthCreateParam::StaticBearer::OrHash
                ),
                name: String,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Beta::Agents::Vaults::Credential)
            }
            def create(
              # The ID of the vault.
              vault_id,
              # The authentication method and secret values to store for the MCP server.
              auth:,
              # The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
              # trimming.
              name:,
              request_options: {}
            )
            end

            # Retrieves vault credential metadata without returning secret values. See
            # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
            sig {
              params(credential_id: String, vault_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                OpenAI::Beta::Agents::Vaults::Credential
              )
            }
            def retrieve(
              # The ID of the vault credential.
              credential_id,
              # The ID of the vault.
              vault_id:,
              request_options: {}
            )
            end

            # Rotates a vault credential's write-only secret and returns only credential
            # metadata. See
            # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
            sig {
              params(
                credential_id: String,
                vault_id: String,
                auth: T.any(
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::McpOauth::OrHash,
                  OpenAI::Beta::Agents::Vaults::CredentialAuthRotateParam::StaticBearer::OrHash
                ),
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Beta::Agents::Vaults::Credential)
            }
            def update(
              # Path param: The ID of the vault credential.
              credential_id,
              # Path param: The ID of the vault.
              vault_id:,
              # Body param: Replacement values for the credential's existing authentication
              # method.
              auth:,
              request_options: {}
            )
            end

            # Lists a vault's credentials using ID-based pagination without returning secret
            # values. See
            # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
            sig {
              params(
                vault_id: String,
                after: String,
                limit: T.nilable(Integer),
                order: OpenAI::Beta::Agents::Vaults::CredentialListParams::Order::OrSymbol,
                status: T.any(
                  OpenAI::Beta::Agents::VaultStatus::OrSymbol,
                  T::Array[OpenAI::Beta::Agents::VaultStatus::OrSymbol]
                ),
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::Agents::Vaults::Credential])
            }
            def list(
              # The ID of the vault.
              vault_id,
              # Return resources after this resource ID in the selected order.
              after: nil,
              # The maximum number of resources to return. Defaults to 20. Values are clamped
              # between 1 and 100.
              limit: nil,
              # Sort order by the `created_at` timestamp. Use `asc` for ascending order or
              # `desc` for descending order. Defaults to `desc`.
              order: nil,
              # Filter by one status or a list, such as `status=active` or
              # `status[]=active&status[]=archived`. Both statuses are included by default.
              status: nil,
              request_options: {}
            )
            end

            # Deletes a vault credential. See
            # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
            sig {
              params(credential_id: String, vault_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                OpenAI::Beta::Agents::Vaults::CredentialDeleted
              )
            }
            def delete(
              # The ID of the vault credential.
              credential_id,
              # The ID of the vault.
              vault_id:,
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
end
