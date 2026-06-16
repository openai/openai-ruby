# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class AdminAPIKeys
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::AdminAPIKeyCreateParams} for more details.
          #
          # Create an organization admin API key
          #
          # @overload create(name:, expires_in_seconds: nil, request_options: {})
          #
          # @param name [String]
          #
          # @param expires_in_seconds [Integer] The number of seconds until the API key expires. Omit this field for a key that
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::AdminAPIKeyCreateResponse]
          #
          # @see OpenAI::Models::Admin::Organization::AdminAPIKeyCreateParams
          def create(params)
            parsed, options = OpenAI::Admin::Organization::AdminAPIKeyCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/admin_api_keys",
              body: parsed,
              model: OpenAI::Models::Admin::Organization::AdminAPIKeyCreateResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Retrieve a single organization API key
          #
          # @overload retrieve(key_id, request_options: {})
          #
          # @param key_id [String] The ID of the API key.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::AdminAPIKey]
          #
          # @see OpenAI::Models::Admin::Organization::AdminAPIKeyRetrieveParams
          def retrieve(key_id, params = {})
            @client.request(
              method: :get,
              path: ["organization/admin_api_keys/%1$s", key_id],
              model: OpenAI::Admin::Organization::AdminAPIKey,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # List organization API keys
          #
          # @overload list(after: nil, limit: nil, order: nil, request_options: {})
          #
          # @param after [String, nil] Return keys with IDs that come after this ID in the pagination order.
          #
          # @param limit [Integer] Maximum number of keys to return.
          #
          # @param order [Symbol, OpenAI::Models::Admin::Organization::AdminAPIKeyListParams::Order] Order results by creation time, ascending or descending.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Admin::Organization::AdminAPIKey>]
          #
          # @see OpenAI::Models::Admin::Organization::AdminAPIKeyListParams
          def list(params = {})
            parsed, options = OpenAI::Admin::Organization::AdminAPIKeyListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/admin_api_keys",
              query: query,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Admin::Organization::AdminAPIKey,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Delete an organization admin API key
          #
          # @overload delete(key_id, request_options: {})
          #
          # @param key_id [String] The ID of the API key to be deleted.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::AdminAPIKeyDeleteResponse]
          #
          # @see OpenAI::Models::Admin::Organization::AdminAPIKeyDeleteParams
          def delete(key_id, params = {})
            @client.request(
              method: :delete,
              path: ["organization/admin_api_keys/%1$s", key_id],
              model: OpenAI::Models::Admin::Organization::AdminAPIKeyDeleteResponse,
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
