# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class ExternalStorage
          # Register one customer-managed external storage configuration.
          #
          # @overload create(project_id:, provider:, request_options: {})
          #
          # @param project_id [String]
          # @param provider [OpenAI::Models::Admin::Organization::ExternalStorageCreateParams::Provider::Aws, OpenAI::Models::Admin::Organization::ExternalStorageCreateParams::Provider::Azure]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::ExternalStorageConfiguration]
          #
          # @see OpenAI::Models::Admin::Organization::ExternalStorageCreateParams
          def create(params)
            parsed, options = OpenAI::Admin::Organization::ExternalStorageCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/external_storage",
              body: parsed,
              model: OpenAI::Admin::Organization::ExternalStorageConfiguration,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Get one customer-managed external storage configuration.
          #
          # @overload retrieve(external_storage_id, request_options: {})
          #
          # @param external_storage_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::ExternalStorageConfiguration]
          #
          # @see OpenAI::Models::Admin::Organization::ExternalStorageRetrieveParams
          def retrieve(external_storage_id, params = {})
            @client.request(
              method: :get,
              path: ["organization/external_storage/%1$s", external_storage_id],
              model: OpenAI::Admin::Organization::ExternalStorageConfiguration,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # List the organization's customer-managed external storage configurations.
          #
          # @overload list(after: nil, limit: nil, order: nil, project_id: nil, request_options: {})
          #
          # @param after [String, nil]
          #   Return external storage configurations after this ID.
          #
          # @param limit [Integer]
          #
          # @param order [Symbol, OpenAI::Models::Admin::Organization::ExternalStorageListParams::Order]
          #
          # @param project_id [String, nil]
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Admin::Organization::ExternalStorageConfiguration>]
          #
          # @see OpenAI::Models::Admin::Organization::ExternalStorageListParams
          def list(params = {})
            parsed, options = OpenAI::Admin::Organization::ExternalStorageListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/external_storage",
              query: query,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Admin::Organization::ExternalStorageConfiguration,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Disconnect a customer-managed external storage configuration. Removing the
          # project's last configuration restores organization-default retention if
          # customer-managed retention was active. Repeating a deletion also completes any
          # interrupted retention update. Cloud storage is unchanged.
          #
          # @overload delete(external_storage_id, request_options: {})
          #
          # @param external_storage_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::ExternalStorageDeleted]
          #
          # @see OpenAI::Models::Admin::Organization::ExternalStorageDeleteParams
          def delete(external_storage_id, params = {})
            @client.request(
              method: :delete,
              path: ["organization/external_storage/%1$s", external_storage_id],
              model: OpenAI::Admin::Organization::ExternalStorageDeleted,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # Validate one customer-managed external storage configuration.
          #
          # @overload validate(external_storage_id, request_options: {})
          #
          # @param external_storage_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::ExternalStorageConfiguration]
          #
          # @see OpenAI::Models::Admin::Organization::ExternalStorageValidateParams
          def validate(external_storage_id, params = {})
            @client.request(
              method: :post,
              path: ["organization/external_storage/%1$s/validate", external_storage_id],
              model: OpenAI::Admin::Organization::ExternalStorageConfiguration,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
          end
        end
      end
    end
  end
end
