# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Groups
          class Users
            # Adds a user to a group.
            #
            # @overload create(group_id, user_id:, request_options: {})
            #
            # @param group_id [String] The ID of the group to update.
            #
            # @param user_id [String] Identifier of the user to add to the group.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Groups::UserCreateResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Groups::UserCreateParams
            def create(group_id, params)
              parsed, options = OpenAI::Admin::Organization::Groups::UserCreateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["organization/groups/%1$s/users", group_id],
                body: parsed,
                model: OpenAI::Models::Admin::Organization::Groups::UserCreateResponse,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Admin::Organization::Groups::UserListParams} for more details.
            #
            # Lists the users assigned to a group.
            #
            # @overload list(group_id, after: nil, limit: nil, order: nil, request_options: {})
            #
            # @param group_id [String] The ID of the group to inspect.
            #
            # @param after [String] A cursor for use in pagination. Provide the ID of the last user from the previou
            #
            # @param limit [Integer] A limit on the number of users to be returned. Limit can range between 0 and 100
            #
            # @param order [Symbol, OpenAI::Models::Admin::Organization::Groups::UserListParams::Order] Specifies the sort order of users in the list.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::NextCursorPage<OpenAI::Models::Admin::Organization::Groups::OrganizationGroupUser>]
            #
            # @see OpenAI::Models::Admin::Organization::Groups::UserListParams
            def list(group_id, params = {})
              parsed, options = OpenAI::Admin::Organization::Groups::UserListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["organization/groups/%1$s/users", group_id],
                query: query,
                page: OpenAI::Internal::NextCursorPage,
                model: OpenAI::Admin::Organization::Groups::OrganizationGroupUser,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Removes a user from a group.
            #
            # @overload delete(user_id, group_id:, request_options: {})
            #
            # @param user_id [String] The ID of the user to remove from the group.
            #
            # @param group_id [String] The ID of the group to update.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Groups::UserDeleteResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Groups::UserDeleteParams
            def delete(user_id, params)
              parsed, options = OpenAI::Admin::Organization::Groups::UserDeleteParams.dump_request(params)
              group_id =
                parsed.delete(:group_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :delete,
                path: ["organization/groups/%1$s/users/%2$s", group_id, user_id],
                model: OpenAI::Models::Admin::Organization::Groups::UserDeleteResponse,
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
