# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Groups
          # @return [OpenAI::Resources::Admin::Organization::Groups::Users]
          attr_reader :users

          # @return [OpenAI::Resources::Admin::Organization::Groups::Roles]
          attr_reader :roles

          # Creates a new group in the organization.
          #
          # @overload create(name:, request_options: {})
          #
          # @param name [String] Human readable name for the group.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::Group]
          #
          # @see OpenAI::Models::Admin::Organization::GroupCreateParams
          def create(params)
            parsed, options = OpenAI::Admin::Organization::GroupCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/groups",
              body: parsed,
              model: OpenAI::Admin::Organization::Group,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Retrieves a group.
          #
          # @overload retrieve(group_id, request_options: {})
          #
          # @param group_id [String] The ID of the group to retrieve.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::Group]
          #
          # @see OpenAI::Models::Admin::Organization::GroupRetrieveParams
          def retrieve(group_id, params = {})
            @client.request(
              method: :get,
              path: ["organization/groups/%1$s", group_id],
              model: OpenAI::Admin::Organization::Group,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # Updates a group's information.
          #
          # @overload update(group_id, name:, request_options: {})
          #
          # @param group_id [String] The ID of the group to update.
          #
          # @param name [String] New display name for the group.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::GroupUpdateResponse]
          #
          # @see OpenAI::Models::Admin::Organization::GroupUpdateParams
          def update(group_id, params)
            parsed, options = OpenAI::Admin::Organization::GroupUpdateParams.dump_request(params)
            @client.request(
              method: :post,
              path: ["organization/groups/%1$s", group_id],
              body: parsed,
              model: OpenAI::Models::Admin::Organization::GroupUpdateResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::GroupListParams} for more details.
          #
          # Lists all groups in the organization.
          #
          # @overload list(after: nil, limit: nil, order: nil, request_options: {})
          #
          # @param after [String] A cursor for use in pagination. `after` is a group ID that defines your place in
          #
          # @param limit [Integer] A limit on the number of groups to be returned. Limit can range between 0 and 10
          #
          # @param order [Symbol, OpenAI::Models::Admin::Organization::GroupListParams::Order] Specifies the sort order of the returned groups.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::NextCursorPage<OpenAI::Models::Admin::Organization::Group>]
          #
          # @see OpenAI::Models::Admin::Organization::GroupListParams
          def list(params = {})
            parsed, options = OpenAI::Admin::Organization::GroupListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/groups",
              query: query,
              page: OpenAI::Internal::NextCursorPage,
              model: OpenAI::Admin::Organization::Group,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Deletes a group from the organization.
          #
          # @overload delete(group_id, request_options: {})
          #
          # @param group_id [String] The ID of the group to delete.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::GroupDeleteResponse]
          #
          # @see OpenAI::Models::Admin::Organization::GroupDeleteParams
          def delete(group_id, params = {})
            @client.request(
              method: :delete,
              path: ["organization/groups/%1$s", group_id],
              model: OpenAI::Models::Admin::Organization::GroupDeleteResponse,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
            @users = OpenAI::Resources::Admin::Organization::Groups::Users.new(client: client)
            @roles = OpenAI::Resources::Admin::Organization::Groups::Roles.new(client: client)
          end
        end
      end
    end
  end
end
