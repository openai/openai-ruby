# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class Groups
            # @return [OpenAI::Resources::Admin::Organization::Projects::Groups::Roles]
            attr_reader :roles

            # Grants a group access to a project.
            #
            # @overload create(project_id, group_id:, role:, request_options: {})
            #
            # @param project_id [String] The ID of the project to update.
            #
            # @param group_id [String] Identifier of the group to add to the project.
            #
            # @param role [String] Identifier of the project role to grant to the group.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectGroup]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::GroupCreateParams
            def create(project_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::GroupCreateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/groups", project_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Projects::ProjectGroup,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Retrieves a project's group.
            #
            # @overload retrieve(group_id, project_id:, group_type: nil, request_options: {})
            #
            # @param group_id [String] Path param: The ID of the group to retrieve.
            #
            # @param project_id [String] Path param: The ID of the project to inspect.
            #
            # @param group_type [Symbol, OpenAI::Models::Admin::Organization::Projects::GroupRetrieveParams::GroupType] Query param: The type of group to retrieve.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectGroup]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::GroupRetrieveParams
            def retrieve(group_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::GroupRetrieveParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/groups/%2$s", project_id, group_id],
                query: query,
                model: OpenAI::Admin::Organization::Projects::ProjectGroup,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Admin::Organization::Projects::GroupListParams} for more
            # details.
            #
            # Lists the groups that have access to a project.
            #
            # @overload list(project_id, after: nil, limit: nil, order: nil, request_options: {})
            #
            # @param project_id [String] The ID of the project to inspect.
            #
            # @param after [String] Cursor for pagination. Provide the ID of the last group from the previous respon
            #
            # @param limit [Integer] A limit on the number of project groups to return. Defaults to 20.
            #
            # @param order [Symbol, OpenAI::Models::Admin::Organization::Projects::GroupListParams::Order] Sort order for the returned groups.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::NextCursorPage<OpenAI::Models::Admin::Organization::Projects::ProjectGroup>]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::GroupListParams
            def list(project_id, params = {})
              parsed, options = OpenAI::Admin::Organization::Projects::GroupListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/groups", project_id],
                query: query,
                page: OpenAI::Internal::NextCursorPage,
                model: OpenAI::Admin::Organization::Projects::ProjectGroup,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Revokes a group's access to a project.
            #
            # @overload delete(group_id, project_id:, request_options: {})
            #
            # @param group_id [String] The ID of the group to remove from the project.
            #
            # @param project_id [String] The ID of the project to update.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::GroupDeleteResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::GroupDeleteParams
            def delete(group_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::GroupDeleteParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :delete,
                path: ["organization/projects/%1$s/groups/%2$s", project_id, group_id],
                model: OpenAI::Models::Admin::Organization::Projects::GroupDeleteResponse,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # @api private
            #
            # @param client [OpenAI::Client]
            def initialize(client:)
              @client = client
              @roles = OpenAI::Resources::Admin::Organization::Projects::Groups::Roles.new(client: client)
            end
          end
        end
      end
    end
  end
end
