# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class APIKeys
            sig { returns(APIKeys::WithRawResponse) }
            def with_raw_response
            end

            # Retrieves an API key in the project.
            sig do
              params(
                api_key_id: String,
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(OpenAI::Admin::Organization::Projects::ProjectAPIKey)
            end
            def retrieve(
              # The ID of the API key.
              api_key_id,
              # The ID of the project.
              project_id:,
              request_options: {}
            )
            end

            # Returns a list of API keys in the project.
            sig do
              params(
                project_id: String,
                after: String,
                limit: Integer,
                owner_project_access:
                  OpenAI::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Internal::ConversationCursorPage[
                  OpenAI::Admin::Organization::Projects::ProjectAPIKey
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
              # Filter API keys by whether the owner currently has effective access to the
              # project. Use `active` for owners with access, `inactive` for owners without
              # access, or `any` for all enabled project API keys. If omitted, the endpoint
              # applies its existing membership-based visibility rules, which may exclude some
              # enabled keys.
              owner_project_access: nil,
              request_options: {}
            )
            end

            # Deletes an API key from the project.
            #
            # Returns confirmation of the key deletion, or an error if the key belonged to a
            # service account.
            sig do
              params(
                api_key_id: String,
                project_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Models::Admin::Organization::Projects::APIKeyDeleteResponse
              )
            end
            def delete(
              # The ID of the API key.
              api_key_id,
              # The ID of the project.
              project_id:,
              request_options: {}
            )
            end

            # @api private
            sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
            def self.new(client:)
            end

            class WithRawResponse
              sig { params(api_key_id: String, project_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Admin::Organization::Projects::ProjectAPIKey]) }
              def retrieve(
                # The ID of the API key.
                api_key_id,
                # The ID of the project.
                project_id:,
                request_options: {}
              )
              end

              sig { params(project_id: String, after: String, limit: Integer, owner_project_access: OpenAI::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess::OrSymbol, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Internal::ConversationCursorPage[OpenAI::Admin::Organization::Projects::ProjectAPIKey]]) }
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
                # Filter API keys by whether the owner currently has effective access to the
                # project. Use `active` for owners with access, `inactive` for owners without
                # access, or `any` for all enabled project API keys. If omitted, the endpoint
                # applies its existing membership-based visibility rules, which may exclude some
                # enabled keys.
                owner_project_access: nil,
                request_options: {}
              )
              end

              sig { params(api_key_id: String, project_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Models::Admin::Organization::Projects::APIKeyDeleteResponse]) }
              def delete(
                # The ID of the API key.
                api_key_id,
                # The ID of the project.
                project_id:,
                request_options: {}
              )
              end

              # @api private
              sig { params(resource: APIKeys).returns(T.attached_class) }
              def self.new(resource:)
              end
            end
          end
        end
      end
    end
  end
end
