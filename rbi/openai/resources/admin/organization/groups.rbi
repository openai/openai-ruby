# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Groups
          sig { returns(OpenAI::Resources::Admin::Organization::Groups::Users) }
          attr_reader :users

          sig { returns(OpenAI::Resources::Admin::Organization::Groups::Roles) }
          attr_reader :roles

          # Creates a new group in the organization.
          sig do
            params(
              name: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::Group)
          end
          def create(
            # Human readable name for the group.
            name:,
            request_options: {}
          )
          end

          # Updates a group's information.
          sig do
            params(
              group_id: String,
              name: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Models::Admin::Organization::GroupUpdateResponse)
          end
          def update(
            # The ID of the group to update.
            group_id,
            # New display name for the group.
            name:,
            request_options: {}
          )
          end

          # Lists all groups in the organization.
          sig do
            params(
              after: String,
              limit: Integer,
              order:
                OpenAI::Admin::Organization::GroupListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::CursorPage[OpenAI::Admin::Organization::Group]
            )
          end
          def list(
            # A cursor for use in pagination. `after` is a group ID that defines your place in
            # the list. For instance, if you make a list request and receive 100 objects,
            # ending with group_abc, your subsequent call can include `after=group_abc` in
            # order to fetch the next page of the list.
            after: nil,
            # A limit on the number of groups to be returned. Limit can range between 0 and
            # 1000, and the default is 100.
            limit: nil,
            # Specifies the sort order of the returned groups.
            order: nil,
            request_options: {}
          )
          end

          # Deletes a group from the organization.
          sig do
            params(
              group_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Models::Admin::Organization::GroupDeleteResponse)
          end
          def delete(
            # The ID of the group to delete.
            group_id,
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
