# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class Groups
            class Roles
              # Assigns a project role to a group within a project.
              #
              # @overload create(group_id, project_id:, role_id:, request_options: {})
              #
              # @param group_id [String] Path param: The ID of the group that should receive the project role.
              #
              # @param project_id [String] Path param: The ID of the project to update.
              #
              # @param role_id [String] Body param: Identifier of the role to assign.
              #
              # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
              #
              # @return [OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse]
              #
              # @see OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateParams
              def create(group_id, params)
                parsed, options = OpenAI::Admin::Organization::Projects::Groups::RoleCreateParams.dump_request(params)
                project_id =
                  parsed.delete(:project_id) do
                    raise ArgumentError.new("missing required path argument #{_1}")
                  end
                @client.request(
                  method: :post,
                  path: ["projects/%1$s/groups/%2$s/roles", project_id, group_id],
                  body: parsed,
                  model: OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse,
                  security: {admin_api_key_auth: true},
                  options: options
                )
              end

              # Some parameter documentations has been truncated, see
              # {OpenAI::Models::Admin::Organization::Projects::Groups::RoleListParams} for more
              # details.
              #
              # Lists the project roles assigned to a group within a project.
              #
              # @overload list(group_id, project_id:, after: nil, limit: nil, order: nil, request_options: {})
              #
              # @param group_id [String] Path param: The ID of the group to inspect.
              #
              # @param project_id [String] Path param: The ID of the project to inspect.
              #
              # @param after [String] Query param: Cursor for pagination. Provide the value from the previous response
              #
              # @param limit [Integer] Query param: A limit on the number of project role assignments to return.
              #
              # @param order [Symbol, OpenAI::Models::Admin::Organization::Projects::Groups::RoleListParams::Order] Query param: Sort order for the returned project roles.
              #
              # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
              #
              # @return [OpenAI::Internal::NextCursorPage<OpenAI::Models::Admin::Organization::Projects::Groups::RoleListResponse>]
              #
              # @see OpenAI::Models::Admin::Organization::Projects::Groups::RoleListParams
              def list(group_id, params)
                parsed, options = OpenAI::Admin::Organization::Projects::Groups::RoleListParams.dump_request(params)
                query = OpenAI::Internal::Util.encode_query_params(parsed)
                project_id =
                  parsed.delete(:project_id) do
                    raise ArgumentError.new("missing required path argument #{_1}")
                  end
                @client.request(
                  method: :get,
                  path: ["projects/%1$s/groups/%2$s/roles", project_id, group_id],
                  query: query,
                  page: OpenAI::Internal::NextCursorPage,
                  model: OpenAI::Models::Admin::Organization::Projects::Groups::RoleListResponse,
                  security: {admin_api_key_auth: true},
                  options: options
                )
              end

              # Unassigns a project role from a group within a project.
              #
              # @overload delete(role_id, project_id:, group_id:, request_options: {})
              #
              # @param role_id [String] The ID of the project role to remove from the group.
              #
              # @param project_id [String] The ID of the project to modify.
              #
              # @param group_id [String] The ID of the group whose project role assignment should be removed.
              #
              # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
              #
              # @return [OpenAI::Models::Admin::Organization::Projects::Groups::RoleDeleteResponse]
              #
              # @see OpenAI::Models::Admin::Organization::Projects::Groups::RoleDeleteParams
              def delete(role_id, params)
                parsed, options = OpenAI::Admin::Organization::Projects::Groups::RoleDeleteParams.dump_request(params)
                project_id =
                  parsed.delete(:project_id) do
                    raise ArgumentError.new("missing required path argument #{_1}")
                  end
                group_id =
                  parsed.delete(:group_id) do
                    raise ArgumentError.new("missing required path argument #{_1}")
                  end
                @client.request(
                  method: :delete,
                  path: ["projects/%1$s/groups/%2$s/roles/%3$s", project_id, group_id, role_id],
                  model: OpenAI::Models::Admin::Organization::Projects::Groups::RoleDeleteResponse,
                  security: {admin_api_key_auth: true},
                  options: options
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
end
