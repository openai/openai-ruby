# typed: strong

module OpenAI
  module Resources

    class Admin

      class Organization

        class Projects

          class ServiceAccounts

            class APIKeys

              # Creates an API key for a service account in the project.
              sig {
                params(
                  service_account_id: String,
                  project_id: String,
                  expires_in_seconds: T.nilable(Integer),
                  name: String,
                  scopes: T::Array[String],
                  request_options: OpenAI::RequestOptions::OrHash
                )
                  .returns(OpenAI::Models::Admin::Organization::Projects::ServiceAccounts::APIKeyCreateResponse)
              }
              def create(
                # Path param: The ID of the service account.
                service_account_id,
                # Path param: The ID of the project.
                project_id:,
                # Body param: Number of seconds until the API key expires.
                expires_in_seconds: nil,
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
