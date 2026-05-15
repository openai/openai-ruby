# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Invites
          # Create an invite for a user to the organization. The invite must be accepted by
          # the user before they have access to the organization.
          sig do
            params(
              email: String,
              role:
                OpenAI::Admin::Organization::InviteCreateParams::Role::OrSymbol,
              projects:
                T::Array[
                  OpenAI::Admin::Organization::InviteCreateParams::Project::OrHash
                ],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::Invite)
          end
          def create(
            # Send an email to this address
            email:,
            # `owner` or `reader`
            role:,
            # An array of projects to which membership is granted at the same time the org
            # invite is accepted. If omitted, the user will be invited to the default project
            # for compatibility with legacy behavior. If empty list is passed, the user will
            # not be invited to any projects, including the default one.
            projects: nil,
            request_options: {}
          )
          end

          # Retrieves an invite.
          sig do
            params(
              invite_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::Invite)
          end
          def retrieve(
            # The ID of the invite to retrieve.
            invite_id,
            request_options: {}
          )
          end

          # Returns a list of invites in the organization.
          sig do
            params(
              after: String,
              limit: Integer,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::ConversationCursorPage[
                OpenAI::Admin::Organization::Invite
              ]
            )
          end
          def list(
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

          # Delete an invite. If the invite has already been accepted, it cannot be deleted.
          sig do
            params(
              invite_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Models::Admin::Organization::InviteDeleteResponse)
          end
          def delete(
            # The ID of the invite to delete.
            invite_id,
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
