# typed: strong

module OpenAI
  module Resources

    class Admin

      class Organization

        class AdminAPIKeys

          # Create an organization admin API key
          sig {
            params(name: String, expires_in_seconds: Integer, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Models::Admin::Organization::AdminAPIKeyCreateResponse
            )
          }
          def create(
            name:,
            # The number of seconds until the API key expires. Omit this field for a key that
            # does not expire.
            expires_in_seconds: nil,
            request_options: {}
          )
          end

          # Retrieve a single organization API key
          sig {
            params(key_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::AdminAPIKey
            )
          }
          def retrieve(
            # The ID of the API key.
            key_id,
            request_options: {}
          )
          end

          # List organization API keys
          sig {
            params(
              after: T.nilable(String),
              limit: Integer,
              order: OpenAI::Admin::Organization::AdminAPIKeyListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Internal::CursorPage[OpenAI::Admin::Organization::AdminAPIKey])
          }
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
          sig {
            params(key_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Models::Admin::Organization::AdminAPIKeyDeleteResponse
            )
          }
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
