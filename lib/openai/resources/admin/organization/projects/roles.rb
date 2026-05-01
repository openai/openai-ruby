# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class Roles
            # Creates a custom role for a project.
            #
            # @overload create(project_id, permissions:, role_name:, description: nil, request_options: {})
            #
            # @param project_id [String] The ID of the project to update.
            #
            # @param permissions [Array<String>] Permissions to grant to the role.
            #
            # @param role_name [String] Unique name for the role.
            #
            # @param description [String, nil] Optional description of the role.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Role]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::RoleCreateParams
            def create(project_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::RoleCreateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["projects/%1$s/roles", project_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Role,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Updates an existing project role.
            #
            # @overload update(role_id, project_id:, description: nil, permissions: nil, role_name: nil, request_options: {})
            #
            # @param role_id [String] Path param: The ID of the role to update.
            #
            # @param project_id [String] Path param: The ID of the project to update.
            #
            # @param description [String, nil] Body param: New description for the role.
            #
            # @param permissions [Array<String>, nil] Body param: Updated set of permissions for the role.
            #
            # @param role_name [String, nil] Body param: New name for the role.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Role]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::RoleUpdateParams
            def update(role_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::RoleUpdateParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :post,
                path: ["projects/%1$s/roles/%2$s", project_id, role_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Role,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Admin::Organization::Projects::RoleListParams} for more
            # details.
            #
            # Lists the roles configured for a project.
            #
            # @overload list(project_id, after: nil, limit: nil, order: nil, request_options: {})
            #
            # @param project_id [String] The ID of the project to inspect.
            #
            # @param after [String] Cursor for pagination. Provide the value from the previous response's `next` fie
            #
            # @param limit [Integer] A limit on the number of roles to return. Defaults to 1000.
            #
            # @param order [Symbol, OpenAI::Models::Admin::Organization::Projects::RoleListParams::Order] Sort order for the returned roles.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::NextCursorPage<OpenAI::Models::Admin::Organization::Role>]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::RoleListParams
            def list(project_id, params = {})
              parsed, options = OpenAI::Admin::Organization::Projects::RoleListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["projects/%1$s/roles", project_id],
                query: query,
                page: OpenAI::Internal::NextCursorPage,
                model: OpenAI::Admin::Organization::Role,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Deletes a custom role from a project.
            #
            # @overload delete(role_id, project_id:, request_options: {})
            #
            # @param role_id [String] The ID of the role to delete.
            #
            # @param project_id [String] The ID of the project to update.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::RoleDeleteResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::RoleDeleteParams
            def delete(role_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::RoleDeleteParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :delete,
                path: ["projects/%1$s/roles/%2$s", project_id, role_id],
                model: OpenAI::Models::Admin::Organization::Projects::RoleDeleteResponse,
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
