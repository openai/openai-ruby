# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class Users
            sig do
              returns(
                OpenAI::Resources::Admin::Organization::Projects::Users::Roles
              )
            end
            attr_reader :roles

            # Adds a user to the project. Users must already be members of the organization to
            # be added to a project.
            sig do
              params(
                project_id: String,
                role: String,
                email: T.nilable(String),
                user_id: T.nilable(String),
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(OpenAI::Admin::Organization::Projects::ProjectUser)
            end
            def create(
              # The ID of the project.
              project_id,
              # `owner` or `member`
              role:,
              # Email of the user to add.
              email: nil,
              # The ID of the user.
              user_id: nil,
              request_options: {}
            )
            end

            # Retrieves a user in the project.
            sig do
              params(
                user_id: String,
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(OpenAI::Admin::Organization::Projects::ProjectUser)
            end
            def retrieve(
              # The ID of the user.
              user_id,
              # The ID of the project.
              project_id:,
              request_options: {}
            )
            end

            # Modifies a user's role in the project.
            sig do
              params(
                user_id: String,
                project_id: String,
                role: T.nilable(String),
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(OpenAI::Admin::Organization::Projects::ProjectUser)
            end
            def update(
              # Path param: The ID of the user.
              user_id,
              # Path param: The ID of the project.
              project_id:,
              # Body param: `owner` or `member`
              role: nil,
              request_options: {}
            )
            end

            # Returns a list of users in the project.
            sig do
              params(
                project_id: String,
                after: String,
                limit: Integer,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Internal::ConversationCursorPage[
                  OpenAI::Admin::Organization::Projects::ProjectUser
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

            # Deletes a user from the project.
            #
            # Returns confirmation of project user deletion, or an error if the project is
            # archived (archived projects have no users).
            sig do
              params(
                user_id: String,
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Models::Admin::Organization::Projects::UserDeleteResponse
              )
            end
            def delete(
              # The ID of the user.
              user_id,
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
