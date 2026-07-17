# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class ServiceAccounts
            sig do
              returns(
                OpenAI::Resources::Admin::Organization::Projects::ServiceAccounts::APIKeys
              )
            end
            attr_reader :api_keys

            # Creates a new service account in the project. By default, this also returns an
            # unredacted API key for the service account.
            sig do
              params(
                project_id: String,
                name: String,
                create_service_account_only: T.nilable(T::Boolean),
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse
              )
            end
            def create(
              # The ID of the project.
              project_id,
              # The name of the service account being created.
              name:,
              # Create the service account without default roles or an API key.
              create_service_account_only: nil,
              request_options: {}
            )
            end

            # Retrieves a service account in the project.
            sig do
              params(
                service_account_id: String,
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectServiceAccount
              )
            end
            def retrieve(
              # The ID of the service account.
              service_account_id,
              # The ID of the project.
              project_id:,
              request_options: {}
            )
            end

            # Updates a service account in the project.
            sig do
              params(
                service_account_id: String,
                project_id: String,
                name: String,
                role:
                  OpenAI::Admin::Organization::Projects::ServiceAccountUpdateParams::Role::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Admin::Organization::Projects::ProjectServiceAccount
              )
            end
            def update(
              # Path param: The ID of the service account.
              service_account_id,
              # Path param: The ID of the project.
              project_id:,
              # Body param: The updated service account name.
              name: nil,
              # Body param: The updated service account role.
              role: nil,
              request_options: {}
            )
            end

            # Returns a list of service accounts in the project.
            sig do
              params(
                project_id: String,
                after: String,
                limit: Integer,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Internal::ConversationCursorPage[
                  OpenAI::Admin::Organization::Projects::ProjectServiceAccount
                ]
              )
            end
            def list(
              # The ID of the project.
              project_id,
              # A cursor for use in pagination. `after` is an object ID that defines your place
              # in the list. For instance, if you make a list request and receive 100 objects,
              # ending with obj_foo, your subsequent call can include after=obj_foo in order to
              # fetch the next page of the list.
              after: nil,
              # A limit on the number of objects to be returned. Limit can range between 1 and
              # 100, and the default is 20.
              limit: nil,
              request_options: {}
            )
            end

            # Deletes a service account from the project.
            #
            # Returns confirmation of service account deletion, or an error if the project is
            # archived (archived projects have no service accounts).
            sig do
              params(
                service_account_id: String,
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Models::Admin::Organization::Projects::ServiceAccountDeleteResponse
              )
            end
            def delete(
              # The ID of the service account.
              service_account_id,
              # The ID of the project.
              project_id:,
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
