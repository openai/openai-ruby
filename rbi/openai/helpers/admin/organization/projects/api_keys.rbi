# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class APIKeys
            sig do
              params(
                api_key_id: String,
                project_id: String,
                scopes: T::Array[String],
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Admin::Organization::Projects::ProjectAPIKey)
            end
            def update_scopes(api_key_id, project_id:, scopes:, request_options: {})
            end
          end
        end
      end
    end
  end
end
