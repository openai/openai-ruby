# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class ExternalKeys
          # Add an external key config for an organization
          #
          # @overload create(body:, request_options: {})
          #
          # @param body [OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Aws, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Gcp, OpenAI::Models::Admin::Organization::ExternalKeyCreateParams::Body::Azure]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::ExternalKey]
          #
          # @see OpenAI::Models::Admin::Organization::ExternalKeyCreateParams
          def create(params)
            parsed, options = OpenAI::Admin::Organization::ExternalKeyCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/external_keys",
              body: parsed[:body],
              model: OpenAI::Admin::Organization::ExternalKey,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Retrieve a stored external key registration for the user's organization.
          #
          # @overload retrieve(external_key_id, request_options: {})
          #
          # @param external_key_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::ExternalKey]
          #
          # @see OpenAI::Models::Admin::Organization::ExternalKeyRetrieveParams
          def retrieve(external_key_id, params = {})
            @client.request(
              method: :get,
              path: ["organization/external_keys/%1$s", external_key_id],
              model: OpenAI::Admin::Organization::ExternalKey,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # List the external key configs registered on the user's organization
          #
          # @overload list(after: nil, limit: nil, order: nil, purpose: nil, request_options: {})
          #
          # @param after [String, nil]
          #
          # @param limit [Integer]
          #
          # @param order [Symbol, OpenAI::Models::Admin::Organization::ExternalKeyListParams::Order]
          #
          # @param purpose [Symbol, OpenAI::Models::Admin::Organization::ExternalKeyListParams::Purpose]
          #   Filter by key purpose. When omitted, returns keys of all purposes.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Admin::Organization::ExternalKey>]
          #
          # @see OpenAI::Models::Admin::Organization::ExternalKeyListParams
          def list(params = {})
            parsed, options = OpenAI::Admin::Organization::ExternalKeyListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/external_keys",
              query: query,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Admin::Organization::ExternalKey,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Delete an external key config for the user's organization
          #
          # @overload delete(external_key_id, request_options: {})
          #
          # @param external_key_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::ExternalKey]
          #
          # @see OpenAI::Models::Admin::Organization::ExternalKeyDeleteParams
          def delete(external_key_id, params = {})
            @client.request(
              method: :delete,
              path: ["organization/external_keys/%1$s", external_key_id],
              model: OpenAI::Admin::Organization::ExternalKey,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # Validate an external key config for the user's organization
          #
          # @overload validate(external_key_id, request_options: {})
          #
          # @param external_key_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::ExternalKeyValidateResponse]
          #
          # @see OpenAI::Models::Admin::Organization::ExternalKeyValidateParams
          def validate(external_key_id, params = {})
            @client.request(
              method: :post,
              path: ["organization/external_keys/%1$s/validate", external_key_id],
              model: OpenAI::Models::Admin::Organization::ExternalKeyValidateResponse,
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
