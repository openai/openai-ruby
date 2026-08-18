# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Groups
          class Roles
            # Assigns an organization role to a group within the organization.
            #
            # @overload create(group_id, role_id:, request_options: {})
            #
            # @param group_id [String] The ID of the group that should receive the organization role.
            #
            # @param role_id [String] Identifier of the role to assign.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Groups::RoleCreateResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Groups::RoleCreateParams
            def create(group_id, params)
              parsed, options = OpenAI::Admin::Organization::Groups::RoleCreateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["organization/groups/%1$s/roles", group_id],
                body: parsed,
                model: OpenAI::Models::Admin::Organization::Groups::RoleCreateResponse,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Retrieves an organization role assigned to a group.
            #
            # @overload retrieve(role_id, group_id:, request_options: {})
            #
            # @param role_id [String] The ID of the organization role to retrieve for the group.
            #
            # @param group_id [String] The ID of the group to inspect.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Groups::RoleRetrieveResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Groups::RoleRetrieveParams
            def retrieve(role_id, params)
              parsed, options = OpenAI::Admin::Organization::Groups::RoleRetrieveParams.dump_request(params)
              group_id =
                parsed.delete(:group_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :get,
                path: ["organization/groups/%1$s/roles/%2$s", group_id, role_id],
                model: OpenAI::Models::Admin::Organization::Groups::RoleRetrieveResponse,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Admin::Organization::Groups::RoleListParams} for more details.
            #
            # Lists the organization roles assigned to a group within the organization.
            #
            # @overload list(group_id, after: nil, limit: nil, order: nil, request_options: {})
            #
            # @param group_id [String] The ID of the group whose organization role assignments you want to list.
            #
            # @param after [String] Cursor for pagination. Provide the value from the previous response's `next` fie
            #
            # @param limit [Integer] A limit on the number of organization role assignments to return.
            #
            # @param order [Symbol, OpenAI::Models::Admin::Organization::Groups::RoleListParams::Order] Sort order for the returned organization roles.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::NextCursorPage<OpenAI::Models::Admin::Organization::Groups::RoleListResponse>]
            #
            # @see OpenAI::Models::Admin::Organization::Groups::RoleListParams
            def list(group_id, params = {})
              parsed, options = OpenAI::Admin::Organization::Groups::RoleListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["organization/groups/%1$s/roles", group_id],
                query: query,
                page: OpenAI::Internal::NextCursorPage,
                model: OpenAI::Models::Admin::Organization::Groups::RoleListResponse,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Unassigns an organization role from a group within the organization.
            #
            # @overload delete(role_id, group_id:, request_options: {})
            #
            # @param role_id [String] The ID of the organization role to remove from the group.
            #
            # @param group_id [String] The ID of the group to modify.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Groups::RoleDeleteResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Groups::RoleDeleteParams
            def delete(role_id, params)
              parsed, options = OpenAI::Admin::Organization::Groups::RoleDeleteParams.dump_request(params)
              group_id =
                parsed.delete(:group_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :delete,
                path: ["organization/groups/%1$s/roles/%2$s", group_id, role_id],
                model: OpenAI::Models::Admin::Organization::Groups::RoleDeleteResponse,
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
