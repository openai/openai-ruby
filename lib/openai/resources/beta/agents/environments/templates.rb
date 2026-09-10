# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Environments
          class Templates
            # Creates reusable environment configuration without returning confidential setup
            # commands or environment values. See
            # [reusing a hosted setup](https://developers.openai.com/api/docs/guides/agents-api/tools#reuse-a-hosted-plugin-setup).
            #
            # @overload create(capability_directories: nil, env: nil, files: nil, name: nil, network: nil, packages: nil, plugins: nil, setup_commands: nil, skills: nil, request_options: {})
            #
            # @param capability_directories [Array<String>, nil]
            #   Directories that contain capabilities exposed to the agent. Defaults to an empty
            #   list.
            #
            # @param env [Hash{Symbol=>String}, nil]
            #   Environment variables made available to the agent.
            #
            # @param files [Array<OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID, OpenAI::Models::Beta::HostedEnvironmentFileParam::Inline>, nil]
            #   Files available before the agent starts. Defaults to an empty list.
            #
            # @param name [String, nil]
            #   An optional human-readable display name for the template.
            #
            # @param network [OpenAI::Models::Beta::Agents::Environments::TemplateCreateParams::Network, nil]
            #   Network access for an OpenAI-hosted environment.
            #
            # @param packages [OpenAI::Models::Beta::Agents::Environments::TemplateCreateParams::Packages, nil]
            #   Packages to install in an OpenAI-hosted environment.
            #
            # @param plugins [Array<OpenAI::Models::Beta::HostedPluginParam>, nil]
            #   Plugins provided as inline ZIP archives. Defaults to an empty list.
            #
            # @param setup_commands [Array<OpenAI::Models::Beta::SetupCommandParam>, nil]
            #   Ordered, confidential setup commands. Command bodies are never returned.
            #
            # @param skills [Array<OpenAI::Models::Beta::HostedSkillParam::SkillReference, OpenAI::Models::Beta::HostedSkillParam::Inline>, nil]
            #   Skills referenced by ID or provided as inline ZIP archives. Defaults to an empty
            #   list.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate]
            #
            # @see OpenAI::Models::Beta::Agents::Environments::TemplateCreateParams
            def create(params = {})
              parsed, options = OpenAI::Beta::Agents::Environments::TemplateCreateParams.dump_request(params)
              @client.request(
                method: :post,
                path: "agents/environments/templates",
                body: parsed,
                model: OpenAI::Beta::Agents::Environments::EnvironmentTemplate,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
              )
            end

            # Retrieves reusable environment configuration without returning confidential
            # values. See
            # [reusing a hosted setup](https://developers.openai.com/api/docs/guides/agents-api/tools#reuse-a-hosted-plugin-setup).
            #
            # @overload retrieve(environment_template_id, request_options: {})
            #
            # @param environment_template_id [String]
            #   The ID of the reusable environment template.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate]
            #
            # @see OpenAI::Models::Beta::Agents::Environments::TemplateRetrieveParams
            def retrieve(environment_template_id, params = {})
              @client.request(
                method: :get,
                path: ["agents/environments/templates/%1$s", environment_template_id],
                model: OpenAI::Beta::Agents::Environments::EnvironmentTemplate,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **params[:request_options].to_h}
              )
            end

            # Updates reusable environment configuration without returning confidential
            # values. See
            # [reusing a hosted setup](https://developers.openai.com/api/docs/guides/agents-api/tools#reuse-a-hosted-plugin-setup).
            #
            # @overload update(environment_template_id, capability_directories: nil, env: nil, files: nil, name: nil, network: nil, packages: nil, plugins: nil, setup_commands: nil, skills: nil, request_options: {})
            #
            # @param environment_template_id [String]
            #   The ID of the reusable environment template.
            #
            # @param capability_directories [Array<String>, nil]
            #   Directories that expose capabilities to the agent.
            #
            # @param env [Hash{Symbol=>String}, nil]
            #   Replacement confidential environment values.
            #
            # @param files [Array<OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID, OpenAI::Models::Beta::HostedEnvironmentFileParam::Inline>, nil]
            #   Replacement file configuration materialized for each new session.
            #
            # @param name [String, nil]
            #   A replacement human-readable display name, or `null` to clear the name.
            #
            # @param network [OpenAI::Models::Beta::Agents::Environments::TemplateUpdateParams::Network, nil]
            #   Network access for an OpenAI-hosted environment.
            #
            # @param packages [OpenAI::Models::Beta::Agents::Environments::TemplateUpdateParams::Packages, nil]
            #   Packages to install in an OpenAI-hosted environment.
            #
            # @param plugins [Array<OpenAI::Models::Beta::HostedPluginParam>, nil]
            #   Replacement plugin configuration installed for each new session.
            #
            # @param setup_commands [Array<OpenAI::Models::Beta::SetupCommandParam>, nil]
            #   Replacement confidential setup commands, never included in returned resources.
            #
            # @param skills [Array<OpenAI::Models::Beta::HostedSkillParam::SkillReference, OpenAI::Models::Beta::HostedSkillParam::Inline>, nil]
            #   Replacement skill configuration installed for each new session.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate]
            #
            # @see OpenAI::Models::Beta::Agents::Environments::TemplateUpdateParams
            def update(environment_template_id, params = {})
              parsed, options = OpenAI::Beta::Agents::Environments::TemplateUpdateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["agents/environments/templates/%1$s", environment_template_id],
                body: parsed,
                model: OpenAI::Beta::Agents::Environments::EnvironmentTemplate,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
              )
            end

            # Lists reusable environment templates without returning confidential values. See
            # [reusing a hosted setup](https://developers.openai.com/api/docs/guides/agents-api/tools#reuse-a-hosted-plugin-setup).
            #
            # @overload list(after: nil, limit: nil, order: nil, request_options: {})
            #
            # @param after [String]
            #   Return resources after this resource ID in the selected order.
            #
            # @param limit [Integer]
            #   The maximum number of resources to return, between 1 and 100. Defaults to 20.
            #
            # @param order [Symbol, OpenAI::Models::Beta::Agents::Environments::TemplateListParams::Order]
            #   The order in which resources are returned. Defaults to `desc`.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplate>]
            #
            # @see OpenAI::Models::Beta::Agents::Environments::TemplateListParams
            def list(params = {})
              parsed, options = OpenAI::Beta::Agents::Environments::TemplateListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: "agents/environments/templates",
                query: query,
                page: OpenAI::Internal::CursorPage,
                model: OpenAI::Beta::Agents::Environments::EnvironmentTemplate,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
              )
            end

            # Deletes reusable environment configuration and all confidential template inputs.
            # See
            # [reusing a hosted setup](https://developers.openai.com/api/docs/guides/agents-api/tools#reuse-a-hosted-plugin-setup).
            #
            # @overload delete(environment_template_id, request_options: {})
            #
            # @param environment_template_id [String]
            #   The ID of the reusable environment template.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Environments::EnvironmentTemplateDeleted]
            #
            # @see OpenAI::Models::Beta::Agents::Environments::TemplateDeleteParams
            def delete(environment_template_id, params = {})
              @client.request(
                method: :delete,
                path: ["agents/environments/templates/%1$s", environment_template_id],
                model: OpenAI::Beta::Agents::Environments::EnvironmentTemplateDeleted,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **params[:request_options].to_h}
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
