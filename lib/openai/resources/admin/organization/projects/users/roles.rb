# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class Users
            class Roles
              # Assigns a project role to a user within a project.
              #
              # @overload create(user_id, project_id:, role_id:, request_options: {})
              #
              # @param user_id [String] Path param: The ID of the user that should receive the project role.
              #
              # @param project_id [String] Path param: The ID of the project to update.
              #
              # @param role_id [String] Body param: Identifier of the role to assign.
              #
              # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
              #
              # @return [OpenAI::Models::Admin::Organization::Projects::Users::RoleCreateResponse]
              #
              # @see OpenAI::Models::Admin::Organization::Projects::Users::RoleCreateParams
              def create(user_id, params)
                parsed, options = OpenAI::Admin::Organization::Projects::Users::RoleCreateParams.dump_request(params)
                project_id =
                  parsed.delete(:project_id) do
                    raise ArgumentError.new("missing required path argument #{_1}")
                  end
                @client.request(
                  method: :post,
                  path: ["projects/%1$s/users/%2$s/roles", project_id, user_id],
                  body: parsed,
                  model: OpenAI::Models::Admin::Organization::Projects::Users::RoleCreateResponse,
                  security: {admin_api_key_auth: true},
                  options: options
                )
              end

              # Retrieves a project role assigned to a user.
              #
              # @overload retrieve(role_id, project_id:, user_id:, request_options: {})
              #
              # @param role_id [String] The ID of the project role to retrieve for the user.
              #
              # @param project_id [String] The ID of the project to inspect.
              #
              # @param user_id [String] The ID of the user to inspect.
              #
              # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
              #
              # @return [OpenAI::Models::Admin::Organization::Projects::Users::RoleRetrieveResponse]
              #
              # @see OpenAI::Models::Admin::Organization::Projects::Users::RoleRetrieveParams
              def retrieve(role_id, params)
                parsed, options = OpenAI::Admin::Organization::Projects::Users::RoleRetrieveParams.dump_request(params)
                project_id =
                  parsed.delete(:project_id) do
                    raise ArgumentError.new("missing required path argument #{_1}")
                  end
                user_id =
                  parsed.delete(:user_id) do
                    raise ArgumentError.new("missing required path argument #{_1}")
                  end
                @client.request(
                  method: :get,
                  path: ["projects/%1$s/users/%2$s/roles/%3$s", project_id, user_id, role_id],
                  model: OpenAI::Models::Admin::Organization::Projects::Users::RoleRetrieveResponse,
                  security: {admin_api_key_auth: true},
                  options: options
                )
              end

              # Some parameter documentations has been truncated, see
              # {OpenAI::Models::Admin::Organization::Projects::Users::RoleListParams} for more
              # details.
              #
              # Lists the project roles assigned to a user within a project.
              #
              # @overload list(user_id, project_id:, after: nil, limit: nil, order: nil, request_options: {})
              #
              # @param user_id [String] Path param: The ID of the user to inspect.
              #
              # @param project_id [String] Path param: The ID of the project to inspect.
              #
              # @param after [String] Query param: Cursor for pagination. Provide the value from the previous response
              #
              # @param limit [Integer] Query param: A limit on the number of project role assignments to return.
              #
              # @param order [Symbol, OpenAI::Models::Admin::Organization::Projects::Users::RoleListParams::Order] Query param: Sort order for the returned project roles.
              #
              # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
              #
              # @return [OpenAI::Internal::NextCursorPage<OpenAI::Models::Admin::Organization::Projects::Users::RoleListResponse>]
              #
              # @see OpenAI::Models::Admin::Organization::Projects::Users::RoleListParams
              def list(user_id, params)
                parsed, options = OpenAI::Admin::Organization::Projects::Users::RoleListParams.dump_request(params)
                query = OpenAI::Internal::Util.encode_query_params(parsed)
                project_id =
                  parsed.delete(:project_id) do
                    raise ArgumentError.new("missing required path argument #{_1}")
                  end
                @client.request(
                  method: :get,
                  path: ["projects/%1$s/users/%2$s/roles", project_id, user_id],
                  query: query,
                  page: OpenAI::Internal::NextCursorPage,
                  model: OpenAI::Models::Admin::Organization::Projects::Users::RoleListResponse,
                  security: {admin_api_key_auth: true},
                  options: options
                )
              end

              # Unassigns a project role from a user within a project.
              #
              # @overload delete(role_id, project_id:, user_id:, request_options: {})
              #
              # @param role_id [String] The ID of the project role to remove from the user.
              #
              # @param project_id [String] The ID of the project to modify.
              #
              # @param user_id [String] The ID of the user whose project role assignment should be removed.
              #
              # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
              #
              # @return [OpenAI::Models::Admin::Organization::Projects::Users::RoleDeleteResponse]
              #
              # @see OpenAI::Models::Admin::Organization::Projects::Users::RoleDeleteParams
              def delete(role_id, params)
                parsed, options = OpenAI::Admin::Organization::Projects::Users::RoleDeleteParams.dump_request(params)
                project_id =
                  parsed.delete(:project_id) do
                    raise ArgumentError.new("missing required path argument #{_1}")
                  end
                user_id =
                  parsed.delete(:user_id) do
                    raise ArgumentError.new("missing required path argument #{_1}")
                  end
                @client.request(
                  method: :delete,
                  path: ["projects/%1$s/users/%2$s/roles/%3$s", project_id, user_id, role_id],
                  model: OpenAI::Models::Admin::Organization::Projects::Users::RoleDeleteResponse,
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
