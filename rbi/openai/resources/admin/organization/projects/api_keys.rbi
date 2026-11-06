# typed: strong

module OpenAI
  module Resources

    class Admin

      class Organization

        class Projects

          class APIKeys

            # Retrieves an API key in the project.
            sig {
              params(api_key_id: String, project_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                OpenAI::Admin::Organization::Projects::ProjectAPIKey
              )
            }
            def retrieve(
              # The ID of the API key.
              api_key_id,
              # The ID of the project.
              project_id:,
              request_options: {}
            )
            end

            # Updates the scopes and/or expiration of an existing API key in the project,
            # including a service-account-owned key. Requires permission to write project API
            # keys.
            #
            # Provide at least one of `scopes` or `expires_in_seconds`. Omitted fields stay
            # unchanged; neither field accepts `null`. Both changes are saved together.
            #
            # `scopes` replaces the key's scope restrictions using the same scope identifiers
            # as the dashboard. An empty array means All permissions, subject to the owner's
            # effective access; it does not mean no access. Use `["api.all.read"]` for
            # read-only access or specific scopes such as `["api.files.read"]` for restricted
            # access. This does not change user or service-account roles or grant admin
            # permissions. Scope changes follow the same authentication-cache propagation as
            # dashboard edits.
            #
            # Provide `expires_in_seconds` to set the expiration relative to this request. The
            # value must satisfy the organization's and project's expiry policies. Expired
            # keys cannot be updated. Retrying resets the expiration relative to the new
            # request. The response contains only the redacted key, not its secret.
            sig {
              params(
                api_key_id: String,
                project_id: String,
                expires_in_seconds: Integer,
                scopes: T::Array[String],
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Admin::Organization::Projects::ProjectAPIKey)
            }
            def update(
              # Path param: The ID of the API key.
              api_key_id,
              # Path param: The ID of the project.
              project_id:,
              # Body param: Number of seconds from this request until the API key expires. Must
              # comply with the organization and project expiry policies. Expired keys cannot be
              # updated. Retrying resets the expiry relative to the new request. Omit to keep
              # the current expiration.
              expires_in_seconds: nil,
              # Body param: Replace the API key scope restrictions. Omit to leave scopes
              # unchanged. An empty array removes key restrictions (All permissions), subject to
              # the owner's effective permissions. Use ["api.all.read"] for read-only access.
              # Scopes do not change the owner's roles or grant administrative permissions.
              scopes: nil,
              request_options: {}
            )
            end

            # Returns a list of API keys in the project.
            sig {
              params(
                project_id: String,
                after: String,
                limit: Integer,
                owner_project_access: OpenAI::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Internal::ConversationCursorPage[OpenAI::Admin::Organization::Projects::ProjectAPIKey])
            }
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

            # Deletes an API key from the project, including keys owned by service accounts.
            #
            # Requires permission to write project API keys. Deleting a service-account key
            # does not delete the service account or its other keys.
            #
            # Returns confirmation of the key deletion.
            sig {
              params(api_key_id: String, project_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                OpenAI::Models::Admin::Organization::Projects::APIKeyDeleteResponse
              )
            }
            def delete(
              # The ID of the API key.
              api_key_id,
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
