# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class AdminAPIKeys
          # Create an organization admin API key
          sig do
            params(
              name: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::AdminAPIKey)
          end
          def create(name:, request_options: {})
          end

          # Retrieve a single organization API key
          sig do
            params(
              key_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::AdminAPIKey)
          end
          def retrieve(
            # The ID of the API key.
            key_id,
            request_options: {}
          )
          end

          # List organization API keys
          sig do
            params(
              after: T.nilable(String),
              limit: Integer,
              order:
                OpenAI::Admin::Organization::AdminAPIKeyListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::CursorPage[
                OpenAI::Admin::Organization::AdminAPIKey
              ]
            )
          end
          def list(
            # Return keys with IDs that come after this ID in the pagination order.
            after: nil,
            # Maximum number of keys to return.
            limit: nil,
            # Order results by creation time, ascending or descending.
            order: nil,
            request_options: {}
          )
          end

          # Delete an organization admin API key
          sig do
            params(
              key_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Models::Admin::Organization::AdminAPIKeyDeleteResponse
            )
          end
          def delete(
            # The ID of the API key to be deleted.
            key_id,
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
