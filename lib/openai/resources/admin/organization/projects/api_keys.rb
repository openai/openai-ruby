# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class APIKeys
            # Retrieves an API key in the project.
            #
            # @overload retrieve(api_key_id, project_id:, request_options: {})
            #
            # @param api_key_id [String]
            #   The ID of the API key.
            #
            # @param project_id [String]
            #   The ID of the project.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::APIKeyRetrieveParams
            def retrieve(api_key_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::APIKeyRetrieveParams.dump_request(params)
              project_id = parsed.delete(:project_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/api_keys/%2$s", project_id, api_key_id],
                model: OpenAI::Admin::Organization::Projects::ProjectAPIKey,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Returns a list of API keys in the project.
            #
            # @overload list(project_id, after: nil, limit: nil, owner_project_access: nil, request_options: {})
            #
            # @param project_id [String]
            #   The ID of the project.
            #
            # @param after [String]
            #   A cursor for use in pagination. `after` is an object ID that defines your place
            #   in the list. For instance, if you make a list request and receive 100 objects,
            #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
            #   fetch the next page of the list.
            #
            # @param limit [Integer]
            #   A limit on the number of objects to be returned. Limit can range between 1 and
            #   100, and the default is 20.
            #
            # @param owner_project_access [Symbol, OpenAI::Models::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess]
            #   Filter API keys by whether the owner currently has effective access to the
            #   project. Use `active` for owners with access, `inactive` for owners without
            #   access, or `any` for all enabled project API keys. If omitted, the endpoint
            #   applies its existing membership-based visibility rules, which may exclude some
            #   enabled keys.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey>]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::APIKeyListParams
            def list(project_id, params = {})
              parsed, options = OpenAI::Admin::Organization::Projects::APIKeyListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/api_keys", project_id],
                query: query,
                page: OpenAI::Internal::ConversationCursorPage,
                model: OpenAI::Admin::Organization::Projects::ProjectAPIKey,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Deletes an API key from the project.
            #
            # Returns confirmation of the key deletion, or an error if the key belonged to a
            # service account.
            #
            # @overload delete(api_key_id, project_id:, request_options: {})
            #
            # @param api_key_id [String]
            #   The ID of the API key.
            #
            # @param project_id [String]
            #   The ID of the project.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::APIKeyDeleteResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::APIKeyDeleteParams
            def delete(api_key_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::APIKeyDeleteParams.dump_request(params)
              project_id = parsed.delete(:project_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :delete,
                path: ["organization/projects/%1$s/api_keys/%2$s", project_id, api_key_id],
                model: OpenAI::Models::Admin::Organization::Projects::APIKeyDeleteResponse,
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
