# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class ServiceAccounts
            # Creates a new service account in the project. This also returns an unredacted
            # API key for the service account.
            #
            # @overload create(project_id, name:, request_options: {})
            #
            # @param project_id [String] The ID of the project.
            #
            # @param name [String] The name of the service account being created.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateParams
            def create(project_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::ServiceAccountCreateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/service_accounts", project_id],
                body: parsed,
                model: OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Retrieves a service account in the project.
            #
            # @overload retrieve(service_account_id, project_id:, request_options: {})
            #
            # @param service_account_id [String] The ID of the service account.
            #
            # @param project_id [String] The ID of the project.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectServiceAccount]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ServiceAccountRetrieveParams
            def retrieve(service_account_id, params)
              parsed, options =
                OpenAI::Admin::Organization::Projects::ServiceAccountRetrieveParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/service_accounts/%2$s", project_id, service_account_id],
                model: OpenAI::Admin::Organization::Projects::ProjectServiceAccount,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Updates a service account in the project.
            #
            # @overload update(service_account_id, project_id:, name: nil, role: nil, request_options: {})
            #
            # @param service_account_id [String] Path param: The ID of the service account.
            #
            # @param project_id [String] Path param: The ID of the project.
            #
            # @param name [String] Body param: The updated service account name.
            #
            # @param role [Symbol, OpenAI::Models::Admin::Organization::Projects::ServiceAccountUpdateParams::Role] Body param: The updated service account role.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectServiceAccount]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ServiceAccountUpdateParams
            def update(service_account_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::ServiceAccountUpdateParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/service_accounts/%2$s", project_id, service_account_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Projects::ProjectServiceAccount,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Admin::Organization::Projects::ServiceAccountListParams} for
            # more details.
            #
            # Returns a list of service accounts in the project.
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
            # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Admin::Organization::Projects::ProjectServiceAccount>]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ServiceAccountListParams
            def list(project_id, params = {})
              parsed, options = OpenAI::Admin::Organization::Projects::ServiceAccountListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/service_accounts", project_id],
                query: query,
                page: OpenAI::Internal::ConversationCursorPage,
                model: OpenAI::Admin::Organization::Projects::ProjectServiceAccount,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Deletes a service account from the project.
            #
            # Returns confirmation of service account deletion, or an error if the project is
            # archived (archived projects have no service accounts).
            #
            # @overload delete(service_account_id, project_id:, request_options: {})
            #
            # @param service_account_id [String] The ID of the service account.
            #
            # @param project_id [String] The ID of the project.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ServiceAccountDeleteResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ServiceAccountDeleteParams
            def delete(service_account_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::ServiceAccountDeleteParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :delete,
                path: ["organization/projects/%1$s/service_accounts/%2$s", project_id, service_account_id],
                model: OpenAI::Models::Admin::Organization::Projects::ServiceAccountDeleteResponse,
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
