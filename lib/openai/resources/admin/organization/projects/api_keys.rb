# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class APIKeys
            # Retrieves an API key in the project.
            #
            # @overload retrieve(key_id, project_id:, request_options: {})
            #
            # @param key_id [String] The ID of the API key.
            #
            # @param project_id [String] The ID of the project.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::APIKeyRetrieveParams
            def retrieve(key_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::APIKeyRetrieveParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/api_keys/%2$s", project_id, key_id],
                model: OpenAI::Admin::Organization::Projects::ProjectAPIKey,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Admin::Organization::Projects::APIKeyListParams} for more
            # details.
            #
            # Returns a list of API keys in the project.
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
            # @overload delete(key_id, project_id:, request_options: {})
            #
            # @param key_id [String] The ID of the API key.
            #
            # @param project_id [String] The ID of the project.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::APIKeyDeleteResponse]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::APIKeyDeleteParams
            def delete(key_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::APIKeyDeleteParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :delete,
                path: ["organization/projects/%1$s/api_keys/%2$s", project_id, key_id],
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
