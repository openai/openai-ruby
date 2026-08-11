# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class HostedToolPermissions
            # Returns a wrapper that exposes the raw HTTP response for each request.
            #
            # @return [HostedToolPermissions::WithRawResponse]
            def with_raw_response
              WithRawResponse.new(
                resource: HostedToolPermissions.new(
                  client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
                )
              )
            end

            # Returns hosted tool permissions for a project.
            #
            # @overload retrieve(project_id, request_options: {})
            #
            # @param project_id [String] The ID of the project.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionRetrieveParams
            def retrieve(project_id, params = {})
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/hosted_tool_permissions", project_id],
                model: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions,
                security: {admin_api_key_auth: true},
                options: params[:request_options]
              )
            end

            # Updates hosted tool permissions for a project.
            #
            # @overload update(project_id, code_interpreter: nil, file_search: nil, image_generation: nil, mcp: nil, web_search: nil, request_options: {})
            #
            # @param project_id [String] The ID of the project.
            #
            # @param code_interpreter [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter, nil] The code interpreter permission update.
            #
            # @param file_search [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch, nil] The file search permission update.
            #
            # @param image_generation [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration, nil] The image generation permission update.
            #
            # @param mcp [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp, nil] The MCP permission update.
            #
            # @param web_search [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch, nil] The web search permission update.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams
            def update(project_id, params = {})
              parsed, options =
                OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/hosted_tool_permissions", project_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # @api private
            #
            # @param client [OpenAI::Internal::Transport::RequestClient]
            def initialize(client:)
              @client = client
            end

            class WithRawResponse
              def retrieve(project_id, params = {})
                @resource.retrieve(project_id, params)
              end

              def update(project_id, params = {})
                @resource.update(project_id, params)
              end

              # @api private
              #
              # @param resource [HostedToolPermissions]
              def initialize(resource:)
                @resource = resource
              end
            end
          end
        end
      end
    end
  end
end
