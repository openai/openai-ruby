# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Users
          sig { returns(OpenAI::Resources::Admin::Organization::Users::Roles) }
          attr_reader :roles

          # Retrieves a user by their identifier.
          sig do
            params(
              user_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::OrganizationUser)
          end
          def retrieve(
            # The ID of the user.
            user_id,
            request_options: {}
          )
          end

          # Modifies a user's role in the organization.
          sig do
            params(
              user_id: String,
              role:
                OpenAI::Admin::Organization::UserUpdateParams::Role::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::OrganizationUser)
          end
          def update(
            # The ID of the user.
            user_id,
            # `owner` or `reader`
            role: nil,
            request_options: {}
          )
          end

          # Lists all of the users in the organization.
          sig do
            params(
              after: String,
              emails: T::Array[String],
              limit: Integer,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::ConversationCursorPage[
                OpenAI::Admin::Organization::OrganizationUser
              ]
            )
          end
          def list(
            # A cursor for use in pagination. `after` is an object ID that defines your place
            # in the list. For instance, if you make a list request and receive 100 objects,
            # ending with obj_foo, your subsequent call can include after=obj_foo in order to
            # fetch the next page of the list.
            after: nil,
            # Filter by the email address of users.
            emails: nil,
            # A limit on the number of objects to be returned. Limit can range between 1 and
            # 100, and the default is 20.
            limit: nil,
            request_options: {}
          )
          end

          # Deletes a user from the organization.
          sig do
            params(
              user_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Models::Admin::Organization::UserDeleteResponse)
          end
          def delete(
            # The ID of the user.
            user_id,
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
