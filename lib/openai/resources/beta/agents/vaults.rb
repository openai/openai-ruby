# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Vaults
          # @return [OpenAI::Resources::Beta::Agents::Vaults::Credentials]
          attr_reader :credentials

          # Creates a vault for the current project. See
          # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
          #
          # @overload create(metadata: nil, name: nil, request_options: {})
          #
          # @param metadata [Hash{Symbol=>String}, nil]
          #   Key-value pairs to associate with the vault, such as an application or team
          #   identifier.
          #
          # @param name [String]
          #   The name is trimmed before storage. It must contain 1 to 256 UTF-8 bytes after
          #   trimming.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Agents::Vault]
          #
          # @see OpenAI::Models::Beta::Agents::VaultCreateParams
          def create(params = {})
            parsed, options = OpenAI::Beta::Agents::VaultCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "vaults",
              body: parsed,
              model: OpenAI::Beta::Agents::Vault,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
            )
          end

          # Retrieves a vault by its ID. See
          # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
          #
          # @overload retrieve(vault_id, request_options: {})
          #
          # @param vault_id [String]
          #   The ID of the vault.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Agents::Vault]
          #
          # @see OpenAI::Models::Beta::Agents::VaultRetrieveParams
          def retrieve(vault_id, params = {})
            @client.request(
              method: :get,
              path: ["vaults/%1$s", vault_id],
              model: OpenAI::Beta::Agents::Vault,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **params[:request_options].to_h}
            )
          end

          # Lists vaults using ID-based pagination. See
          # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
          #
          # @overload list(after: nil, limit: nil, order: nil, status: nil, request_options: {})
          #
          # @param after [String]
          #   Return resources after this resource ID in the selected order.
          #
          # @param limit [Integer, nil]
          #   The maximum number of resources to return. Defaults to 20. Values are clamped
          #   between 1 and 100.
          #
          # @param order [Symbol, OpenAI::Models::Beta::Agents::VaultListParams::Order]
          #   Sort order by the `created_at` timestamp. Use `asc` for ascending order or
          #   `desc` for descending order. Defaults to `desc`.
          #
          # @param status [Symbol, OpenAI::Models::Beta::Agents::VaultStatus, Array<Symbol, OpenAI::Models::Beta::Agents::VaultStatus>]
          #   Filter by one status or a list, such as `status=active` or
          #   `status[]=active&status[]=archived`. Both statuses are included by default.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Agents::Vault>]
          #
          # @see OpenAI::Models::Beta::Agents::VaultListParams
          def list(params = {})
            parsed, options = OpenAI::Beta::Agents::VaultListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "vaults",
              query: query,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Beta::Agents::Vault,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
            )
          end

          # Deletes a vault and all its credentials. See
          # [vaults](https://developers.openai.com/api/docs/guides/agents-api/tools/vaults).
          #
          # @overload delete(vault_id, request_options: {})
          #
          # @param vault_id [String]
          #   The ID of the vault.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Agents::VaultDeleted]
          #
          # @see OpenAI::Models::Beta::Agents::VaultDeleteParams
          def delete(vault_id, params = {})
            @client.request(
              method: :delete,
              path: ["vaults/%1$s", vault_id],
              model: OpenAI::Beta::Agents::VaultDeleted,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **params[:request_options].to_h}
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
            @credentials = OpenAI::Resources::Beta::Agents::Vaults::Credentials.new(client: client)
          end
        end
      end
    end
  end
end
