# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Environments
          # @return [OpenAI::Resources::Beta::Agents::Environments::Files]
          attr_reader :files

          # @return [OpenAI::Resources::Beta::Agents::Environments::Templates]
          attr_reader :templates

          # Creates an OpenAI-hosted environment before creating a session. Requires access
          # to the prewarming beta.
          #
          # @overload create(environment:, vault_ids: nil, idempotency_key: nil, request_options: {})
          #
          # @param environment [OpenAI::Models::Beta::Agents::EnvironmentCreateParams::Environment]
          #   Body param: The required hosting type and its configuration.
          #
          # @param vault_ids [Array<String>, nil]
          #   Body param: The IDs of up to 10 vaults made available to an OpenAI-hosted
          #   environment.
          #
          # @param idempotency_key [String]
          #   Header param: Deduplicates creation for 24 hours within the authenticated
          #   organization, project, and creator. Retry the same JSON parameters with the same
          #   key to retrieve the original environment in its current state. Different
          #   parameters or an incomplete hosted creation return 409. Deleted environments are
          #   not recreated. After retention expires, the key may create a new environment.
          #   Without this header, each request creates a new environment.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Agents::EnvironmentInfo]
          #
          # @see OpenAI::Models::Beta::Agents::EnvironmentCreateParams
          def create(params)
            parsed, options = OpenAI::Beta::Agents::EnvironmentCreateParams.dump_request(params)
            header_params = {idempotency_key: "idempotency-key"}
            @client.request(
              method: :post,
              path: "agents/environments",
              headers: {"openai-beta" => "agents=v1"}.merge(
                parsed.slice(*header_params.keys).transform_keys(header_params)
              ),
              body: parsed.except(*header_params.keys),
              model: OpenAI::Beta::Agents::EnvironmentInfo,
              security: {bearer_auth: true},
              options: options
            )
          end

          # Retrieves an execution environment's connection status and safe installed
          # metadata. See
          # [environment lifecycle](https://developers.openai.com/api/docs/guides/agents-api/environments/lifecycle).
          #
          # @overload retrieve(environment_id, request_options: {})
          #
          # @param environment_id [String]
          #   The ID of the environment.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Agents::EnvironmentInfo]
          #
          # @see OpenAI::Models::Beta::Agents::EnvironmentRetrieveParams
          def retrieve(environment_id, params = {})
            @client.request(
              method: :get,
              path: ["agents/environments/%1$s", environment_id],
              headers: {"openai-beta" => "agents=v1"},
              model: OpenAI::Beta::Agents::EnvironmentInfo,
              security: {bearer_auth: true},
              options: params[:request_options]
            )
          end

          # Lists OpenAI-hosted environments owned by the authenticated principal. Requires
          # access to the prewarming beta.
          #
          # @overload list(after: nil, limit: nil, order: nil, type: nil, request_options: {})
          #
          # @param after [String]
          #   Return environments after this environment ID in the selected order.
          #
          # @param limit [Integer]
          #   The maximum number of environments to return, between 1 and 100. Defaults to 20.
          #
          # @param order [Symbol, OpenAI::Models::Beta::Agents::EnvironmentListParams::Order]
          #   The order in which environments are returned. Defaults to `desc`.
          #
          # @param type [Symbol, OpenAI::Models::Beta::Agents::EnvironmentListParams::Type]
          #   The hosting type to list. Defaults to `openai_hosted`.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Agents::EnvironmentInfo>]
          #
          # @see OpenAI::Models::Beta::Agents::EnvironmentListParams
          def list(params = {})
            parsed, options = OpenAI::Beta::Agents::EnvironmentListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "agents/environments",
              query: query,
              headers: {"openai-beta" => "agents=v1"},
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Beta::Agents::EnvironmentInfo,
              security: {bearer_auth: true},
              options: options
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
            @files = OpenAI::Resources::Beta::Agents::Environments::Files.new(client: client)
            @templates = OpenAI::Resources::Beta::Agents::Environments::Templates.new(client: client)
          end
        end
      end
    end
  end
end
