# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class APIKeys
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
            sig { params(client: OpenAI::Client).returns(T.attached_class) }
            def self.new(client:)
            end
          end
        end
      end
    end
  end
end
