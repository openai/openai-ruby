# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Groups
          class Users
            sig { returns(Users::WithRawResponse) }
            def with_raw_response
            end

            # Adds a user to a group.
            sig do
              params(
                group_id: String,
                user_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Models::Admin::Organization::Groups::UserCreateResponse
              )
            end
            def create(
              # The ID of the group to update.
              group_id,
              # Identifier of the user to add to the group.
              user_id:,
              request_options: {}
            )
            end

            # Retrieves a user in a group.
            sig do
              params(
                user_id: String,
                group_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse
              )
            end
            def retrieve(
              # The ID of the user to retrieve from the group.
              user_id,
              # The ID of the group to inspect.
              group_id:,
              request_options: {}
            )
            end

            # Lists the users assigned to a group.
            sig do
              params(
                group_id: String,
                after: String,
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::Groups::UserListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Internal::NextCursorPage[
                  OpenAI::Admin::Organization::Groups::OrganizationGroupUser
                ]
              )
            end
            def list(
              # The ID of the group to inspect.
              group_id,
              # A cursor for use in pagination. Provide the ID of the last user from the
              # previous list response to retrieve the next page.
              after: nil,
              # A limit on the number of users to be returned. Limit can range between 0 and
              # 1000, and the default is 100.
              limit: nil,
              # Specifies the sort order of users in the list.
              order: nil,
              request_options: {}
            )
            end

            # Removes a user from a group.
            sig do
              params(
                user_id: String,
                group_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Models::Admin::Organization::Groups::UserDeleteResponse
              )
            end
            def delete(
              # The ID of the user to remove from the group.
              user_id,
              # The ID of the group to update.
              group_id:,
              request_options: {}
            )
            end

            # @api private
            sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
            def self.new(client:)
            end

            class WithRawResponse
              sig { params(group_id: String, user_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Models::Admin::Organization::Groups::UserCreateResponse]) }
              def create(
                # The ID of the group to update.
                group_id,
                # Identifier of the user to add to the group.
                user_id:,
                request_options: {}
              )
              end

              sig { params(user_id: String, group_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse]) }
              def retrieve(
                # The ID of the user to retrieve from the group.
                user_id,
                # The ID of the group to inspect.
                group_id:,
                request_options: {}
              )
              end

              sig { params(group_id: String, after: String, limit: Integer, order: OpenAI::Admin::Organization::Groups::UserListParams::Order::OrSymbol, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Internal::NextCursorPage[OpenAI::Admin::Organization::Groups::OrganizationGroupUser]]) }
              def list(
                # The ID of the group to inspect.
                group_id,
                # A cursor for use in pagination. Provide the ID of the last user from the
                # previous list response to retrieve the next page.
                after: nil,
                # A limit on the number of users to be returned. Limit can range between 0 and
                # 1000, and the default is 100.
                limit: nil,
                # Specifies the sort order of users in the list.
                order: nil,
                request_options: {}
              )
              end

              sig { params(user_id: String, group_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Models::Admin::Organization::Groups::UserDeleteResponse]) }
              def delete(
                # The ID of the user to remove from the group.
                user_id,
                # The ID of the group to update.
                group_id:,
                request_options: {}
              )
              end

              # @api private
              sig { params(resource: Users).returns(T.attached_class) }
              def self.new(resource:)
              end
            end
          end
        end
      end
    end
  end
end
