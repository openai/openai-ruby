# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Roles
          # Creates a custom role for the organization.
          #
          # @overload create(permissions:, role_name:, description: nil, request_options: {})
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
          # @see OpenAI::Models::Admin::Organization::RoleCreateParams
          def create(params)
            parsed, options = OpenAI::Admin::Organization::RoleCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/roles",
              body: parsed,
              model: OpenAI::Admin::Organization::Role,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Retrieves an organization role.
          #
          # @overload retrieve(role_id, request_options: {})
          #
          # @param role_id [String] The ID of the role to retrieve.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::Role]
          #
          # @see OpenAI::Models::Admin::Organization::RoleRetrieveParams
          def retrieve(role_id, params = {})
            @client.request(
              method: :get,
              path: ["organization/roles/%1$s", role_id],
              model: OpenAI::Admin::Organization::Role,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # Updates an existing organization role.
          #
          # @overload update(role_id, description: nil, permissions: nil, role_name: nil, request_options: {})
          #
          # @param role_id [String] The ID of the role to update.
          #
          # @param description [String, nil] New description for the role.
          #
          # @param permissions [Array<String>, nil] Updated set of permissions for the role.
          #
          # @param role_name [String, nil] New name for the role.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::Role]
          #
          # @see OpenAI::Models::Admin::Organization::RoleUpdateParams
          def update(role_id, params = {})
            parsed, options = OpenAI::Admin::Organization::RoleUpdateParams.dump_request(params)
            @client.request(
              method: :post,
              path: ["organization/roles/%1$s", role_id],
              body: parsed,
              model: OpenAI::Admin::Organization::Role,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::RoleListParams} for more details.
          #
          # Lists the roles configured for the organization.
          #
          # @overload list(after: nil, limit: nil, order: nil, request_options: {})
          #
          # @param after [String] Cursor for pagination. Provide the value from the previous response's `next` fie
          #
          # @param limit [Integer] A limit on the number of roles to return. Defaults to 1000.
          #
          # @param order [Symbol, OpenAI::Models::Admin::Organization::RoleListParams::Order] Sort order for the returned roles.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::NextCursorPage<OpenAI::Models::Admin::Organization::Role>]
          #
          # @see OpenAI::Models::Admin::Organization::RoleListParams
          def list(params = {})
            parsed, options = OpenAI::Admin::Organization::RoleListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/roles",
              query: query,
              page: OpenAI::Internal::NextCursorPage,
              model: OpenAI::Admin::Organization::Role,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Deletes a custom role from the organization.
          #
          # @overload delete(role_id, request_options: {})
          #
          # @param role_id [String] The ID of the role to delete.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::RoleDeleteResponse]
          #
          # @see OpenAI::Models::Admin::Organization::RoleDeleteParams
          def delete(role_id, params = {})
            @client.request(
              method: :delete,
              path: ["organization/roles/%1$s", role_id],
              model: OpenAI::Models::Admin::Organization::RoleDeleteResponse,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
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
