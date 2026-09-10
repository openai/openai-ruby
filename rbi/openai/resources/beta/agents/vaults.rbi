# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Vaults

          sig { returns(OpenAI::Resources::Beta::Agents::Vaults::Credentials) }
          attr_reader :credentials

          # Creates a vault for the current project. See
          # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
          sig {
            params(
              metadata: T.nilable(T::Hash[Symbol, String]),
              name: String,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Beta::Agents::Vault)
          }
          def create(
            # Key-value pairs to associate with the vault, such as an application or team
            # identifier.
            metadata: nil,
            # The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
            # trimming.
            name: nil,
            request_options: {}
          )
          end

          # Retrieves a vault by its ID. See
          # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
          sig {
            params(vault_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Beta::Agents::Vault
            )
          }
          def retrieve(
            # The ID of the vault.
            vault_id,
            request_options: {}
          )
          end

          # Lists vaults using ID-based pagination. See
          # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
          sig {
            params(
              after: String,
              limit: T.nilable(Integer),
              order: OpenAI::Beta::Agents::VaultListParams::Order::OrSymbol,
              status: T.any(
                OpenAI::Beta::Agents::VaultStatus::OrSymbol,
                T::Array[OpenAI::Beta::Agents::VaultStatus::OrSymbol]
              ),
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::Agents::Vault])
          }
          def list(
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

          # Deletes a vault and all its credentials. See
          # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
          sig {
            params(vault_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Beta::Agents::VaultDeleted
            )
          }
          def delete(
            # The ID of the vault.
            vault_id,
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
