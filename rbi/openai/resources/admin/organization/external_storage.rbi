# typed: strong

module OpenAI
  module Resources

    class Admin

      class Organization

        class ExternalStorage

          # Register one customer-managed external storage configuration.
          sig {
            params(
              project_id: String,
              provider: T.any(
                OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Aws::OrHash,
                OpenAI::Admin::Organization::ExternalStorageCreateParams::Provider::Azure::OrHash
              ),
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Admin::Organization::ExternalStorageConfiguration)
          }
          def create(project_id:, provider:, request_options: {})
          end

          # Get one customer-managed external storage configuration.
          sig {
            params(external_storage_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::ExternalStorageConfiguration
            )
          }
          def retrieve(external_storage_id, request_options: {})
          end

          # List the organization's customer-managed external storage configurations.
          sig {
            params(
              after: T.nilable(String),
              limit: Integer,
              order: OpenAI::Admin::Organization::ExternalStorageListParams::Order::OrSymbol,
              project_id: T.nilable(String),
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Internal::CursorPage[OpenAI::Admin::Organization::ExternalStorageConfiguration])
          }
          def list(
            # Return external storage configurations after this ID.
            after: nil,
            limit: nil,
            order: nil,
            project_id: nil,
            request_options: {}
          )
          end

          # Soft-delete one customer-managed external storage configuration.
          sig {
            params(external_storage_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::ExternalStorageDeleted
            )
          }
          def delete(external_storage_id, request_options: {})
          end

          # Validate one customer-managed external storage configuration.
          sig {
            params(external_storage_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::ExternalStorageConfiguration
            )
          }
          def validate(external_storage_id, request_options: {})
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
