# frozen_string_literal: true

require_relative "../../../../resources/admin/organization/projects/api_keys"

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class APIKeys
            # Replace an API key's scope restrictions without changing its expiration.
            # Requires permission to write project API keys; expired keys cannot be updated.
            # An empty array removes key restrictions (All permissions), subject to the
            # owner's effective access. This does not change roles or grant admin permissions.
            # Changes follow the same authentication-cache propagation as dashboard edits.
            #
            # @param api_key_id [String]
            # @param project_id [String]
            # @param scopes [Array<String>] Use ["api.all.read"] for read-only access.
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectAPIKey]
            def update_scopes(api_key_id, project_id:, scopes:, request_options: {})
              parsed, options = OpenAI::Admin::Organization::Projects::APIKeyUpdateScopesParams.dump_request(
                {scopes: scopes, request_options: request_options}
              )
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/api_keys/%2$s", project_id, api_key_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Projects::ProjectAPIKey,
                security: {admin_api_key_auth: true},
                options: options
              )
            end
          end
        end
      end
    end
  end
end
