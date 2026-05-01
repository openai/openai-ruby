# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Users
          class Roles
            # Assigns an organization role to a user within the organization.
            #
            # @overload create(user_id, role_id:, request_options: {})
            #
            # @param user_id [String] The ID of the user that should receive the organization role.
            #
            # @param role_id [String] Identifier of the role to assign.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Users::RoleCreateResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Users::RoleCreateParams
            def create(user_id, params)
              parsed, options = OpenAI::Admin::Organization::Users::RoleCreateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["organization/users/%1$s/roles", user_id],
                body: parsed,
                model: OpenAI::Models::Admin::Organization::Users::RoleCreateResponse,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Admin::Organization::Users::RoleListParams} for more details.
            #
            # Lists the organization roles assigned to a user within the organization.
            #
            # @overload list(user_id, after: nil, limit: nil, order: nil, request_options: {})
            #
            # @param user_id [String] The ID of the user to inspect.
            #
            # @param after [String] Cursor for pagination. Provide the value from the previous response's `next` fie
            #
            # @param limit [Integer] A limit on the number of organization role assignments to return.
            #
            # @param order [Symbol, OpenAI::Models::Admin::Organization::Users::RoleListParams::Order] Sort order for the returned organization roles.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::NextCursorPage<OpenAI::Models::Admin::Organization::Users::RoleListResponse>]
            #
            # @see OpenAI::Models::Admin::Organization::Users::RoleListParams
            def list(user_id, params = {})
              parsed, options = OpenAI::Admin::Organization::Users::RoleListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["organization/users/%1$s/roles", user_id],
                query: query,
                page: OpenAI::Internal::NextCursorPage,
                model: OpenAI::Models::Admin::Organization::Users::RoleListResponse,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Unassigns an organization role from a user within the organization.
            #
            # @overload delete(role_id, user_id:, request_options: {})
            #
            # @param role_id [String] The ID of the organization role to remove from the user.
            #
            # @param user_id [String] The ID of the user to modify.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Users::RoleDeleteResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Users::RoleDeleteParams
            def delete(role_id, params)
              parsed, options = OpenAI::Admin::Organization::Users::RoleDeleteParams.dump_request(params)
              user_id =
                parsed.delete(:user_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :delete,
                path: ["organization/users/%1$s/roles/%2$s", user_id, role_id],
                model: OpenAI::Models::Admin::Organization::Users::RoleDeleteResponse,
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
