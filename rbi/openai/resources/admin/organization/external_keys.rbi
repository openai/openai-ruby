# typed: strong

module OpenAI
  module Resources

    class Admin

      class Organization

        class ExternalKeys

          # Add an external key config for an organization
          sig {
            params(
              body: T.any(
                OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Aws::OrHash,
                OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Gcp::OrHash,
                OpenAI::Admin::Organization::ExternalKeyCreateParams::Body::Azure::OrHash
              ),
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Admin::Organization::ExternalKey)
          }
          def create(body:, request_options: {})
          end

          # Retrieve a stored external key registration for the user's organization.
          sig {
            params(external_key_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::ExternalKey
            )
          }
          def retrieve(external_key_id, request_options: {})
          end

          # List the external key configs registered on the user's organization
          sig {
            params(
              after: T.nilable(String),
              limit: Integer,
              order: OpenAI::Admin::Organization::ExternalKeyListParams::Order::OrSymbol,
              purpose: OpenAI::Admin::Organization::ExternalKeyListParams::Purpose::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Internal::CursorPage[OpenAI::Admin::Organization::ExternalKey])
          }
          def list(
            after: nil,
            limit: nil,
            order: nil,
            # Filter by key purpose. When omitted, returns keys of all purposes.
            purpose: nil,
            request_options: {}
          )
          end

          # Delete an external key config for the user's organization
          sig {
            params(external_key_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::ExternalKey
            )
          }
          def delete(external_key_id, request_options: {})
          end

          # Validate an external key config for the user's organization
          sig {
            params(external_key_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Models::Admin::Organization::ExternalKeyValidateResponse
            )
          }
          def validate(external_key_id, request_options: {})
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
