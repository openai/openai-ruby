# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class ServiceAccounts
            class APIKeys
              # Creates an API key for a service account in the project.
              sig do
                params(
                  service_account_id: String,
                  project_id: String,
                  name: String,
                  scopes: T::Array[String],
                  request_options: OpenAI::RequestOptions::OrHash
                ).returns(
                  OpenAI::Models::Admin::Organization::Projects::ServiceAccounts::APIKeyCreateResponse
                )
              end
              def create(
                # Path param: The ID of the service account.
                service_account_id,
                # Path param: The ID of the project.
                project_id:,
                # Body param: API key name.
                name: nil,
                # Body param: API key scopes.
                scopes: nil,
                request_options: {}
              )
              end

              # @api private
              sig { params(client: OpenAI::Client).returns(T.attached_class) }
              def self.new(client:)
              end
            end
          end
        end
      end
    end
  end
end
