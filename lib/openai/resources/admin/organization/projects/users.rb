# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class Users
            # @return [OpenAI::Resources::Admin::Organization::Projects::Users::Roles]
            attr_reader :roles

            # Adds a user to the project. Users must already be members of the organization to
            # be added to a project.
            #
            # @overload create(project_id, role:, email: nil, user_id: nil, request_options: {})
            #
            # @param project_id [String] The ID of the project.
            #
            # @param role [String] `owner` or `member`
            #
            # @param email [String, nil] Email of the user to add.
            #
            # @param user_id [String, nil] The ID of the user.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectUser]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::UserCreateParams
            def create(project_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::UserCreateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/users", project_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Projects::ProjectUser,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Retrieves a user in the project.
            #
            # @overload retrieve(user_id, project_id:, request_options: {})
            #
            # @param user_id [String] The ID of the user.
            #
            # @param project_id [String] The ID of the project.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectUser]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::UserRetrieveParams
            def retrieve(user_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::UserRetrieveParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/users/%2$s", project_id, user_id],
                model: OpenAI::Admin::Organization::Projects::ProjectUser,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Modifies a user's role in the project.
            #
            # @overload update(user_id, project_id:, role: nil, request_options: {})
            #
            # @param user_id [String] Path param: The ID of the user.
            #
            # @param project_id [String] Path param: The ID of the project.
            #
            # @param role [String, nil] Body param: `owner` or `member`
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectUser]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::UserUpdateParams
            def update(user_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::UserUpdateParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/users/%2$s", project_id, user_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Projects::ProjectUser,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Admin::Organization::Projects::UserListParams} for more
            # details.
            #
            # Returns a list of users in the project.
            #
            # @overload list(project_id, after: nil, limit: nil, request_options: {})
            #
            # @param project_id [String] The ID of the project.
            #
            # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
            #
            # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Admin::Organization::Projects::ProjectUser>]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::UserListParams
            def list(project_id, params = {})
              parsed, options = OpenAI::Admin::Organization::Projects::UserListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/users", project_id],
                query: query,
                page: OpenAI::Internal::ConversationCursorPage,
                model: OpenAI::Admin::Organization::Projects::ProjectUser,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Deletes a user from the project.
            #
            # Returns confirmation of project user deletion, or an error if the project is
            # archived (archived projects have no users).
            #
            # @overload delete(user_id, project_id:, request_options: {})
            #
            # @param user_id [String] The ID of the user.
            #
            # @param project_id [String] The ID of the project.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::UserDeleteResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::UserDeleteParams
            def delete(user_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::UserDeleteParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :delete,
                path: ["organization/projects/%1$s/users/%2$s", project_id, user_id],
                model: OpenAI::Models::Admin::Organization::Projects::UserDeleteResponse,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # @api private
            #
            # @param client [OpenAI::Client]
            def initialize(client:)
              @client = client
              @roles = OpenAI::Resources::Admin::Organization::Projects::Users::Roles.new(client: client)
            end
          end
        end
      end
    end
  end
end
