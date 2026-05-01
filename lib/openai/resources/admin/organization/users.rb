# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Users
          # @return [OpenAI::Resources::Admin::Organization::Users::Roles]
          attr_reader :roles

          # Retrieves a user by their identifier.
          #
          # @overload retrieve(user_id, request_options: {})
          #
          # @param user_id [String] The ID of the user.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::OrganizationUser]
          #
          # @see OpenAI::Models::Admin::Organization::UserRetrieveParams
          def retrieve(user_id, params = {})
            @client.request(
              method: :get,
              path: ["organization/users/%1$s", user_id],
              model: OpenAI::Admin::Organization::OrganizationUser,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # Modifies a user's role in the organization.
          #
          # @overload update(user_id, role: nil, request_options: {})
          #
          # @param user_id [String] The ID of the user.
          #
          # @param role [Symbol, OpenAI::Models::Admin::Organization::UserUpdateParams::Role] `owner` or `reader`
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::OrganizationUser]
          #
          # @see OpenAI::Models::Admin::Organization::UserUpdateParams
          def update(user_id, params = {})
            parsed, options = OpenAI::Admin::Organization::UserUpdateParams.dump_request(params)
            @client.request(
              method: :post,
              path: ["organization/users/%1$s", user_id],
              body: parsed,
              model: OpenAI::Admin::Organization::OrganizationUser,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::UserListParams} for more details.
          #
          # Lists all of the users in the organization.
          #
          # @overload list(after: nil, emails: nil, limit: nil, request_options: {})
          #
          # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
          #
          # @param emails [Array<String>] Filter by the email address of users.
          #
          # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Admin::Organization::OrganizationUser>]
          #
          # @see OpenAI::Models::Admin::Organization::UserListParams
          def list(params = {})
            parsed, options = OpenAI::Admin::Organization::UserListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/users",
              query: query,
              page: OpenAI::Internal::ConversationCursorPage,
              model: OpenAI::Admin::Organization::OrganizationUser,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Deletes a user from the organization.
          #
          # @overload delete(user_id, request_options: {})
          #
          # @param user_id [String] The ID of the user.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::UserDeleteResponse]
          #
          # @see OpenAI::Models::Admin::Organization::UserDeleteParams
          def delete(user_id, params = {})
            @client.request(
              method: :delete,
              path: ["organization/users/%1$s", user_id],
              model: OpenAI::Models::Admin::Organization::UserDeleteResponse,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
            @roles = OpenAI::Resources::Admin::Organization::Users::Roles.new(client: client)
          end
        end
      end
    end
  end
end
