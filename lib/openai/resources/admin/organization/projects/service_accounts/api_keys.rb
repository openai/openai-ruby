# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class ServiceAccounts
            class APIKeys
              # Returns a wrapper that exposes the raw HTTP response for each request.
              #
              # @return [APIKeys::WithRawResponse]
              def with_raw_response
                WithRawResponse.new(
                  resource: APIKeys.new(
                    client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
                  )
                )
              end

              # Creates an API key for a service account in the project.
              #
              # @overload create(service_account_id, project_id:, name: nil, scopes: nil, request_options: {})
              #
              # @param service_account_id [String] Path param: The ID of the service account.
              #
              # @param project_id [String] Path param: The ID of the project.
              #
              # @param name [String] Body param: API key name.
              #
              # @param scopes [Array<String>] Body param: API key scopes.
              #
              # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
              #
              # @return [OpenAI::Models::Admin::Organization::Projects::ServiceAccounts::APIKeyCreateResponse]
              #
              # @see OpenAI::Models::Admin::Organization::Projects::ServiceAccounts::APIKeyCreateParams
              def create(service_account_id, params)
                parsed, options =
                  OpenAI::Admin::Organization::Projects::ServiceAccounts::APIKeyCreateParams.dump_request(params)
                project_id =
                  parsed.delete(:project_id) do
                    raise ArgumentError.new("missing required path argument #{_1}")
                  end
                @client.request(
                  method: :post,
                  path: [
                    "organization/projects/%1$s/service_accounts/%2$s/api_keys",
                    project_id,
                    service_account_id
                  ],
                  body: parsed,
                  model: OpenAI::Models::Admin::Organization::Projects::ServiceAccounts::APIKeyCreateResponse,
                  security: {admin_api_key_auth: true},
                  options: options
                )
              end

              # @api private
              #
              # @param client [OpenAI::Internal::Transport::RequestClient]
              def initialize(client:)
                @client = client
              end

              class WithRawResponse
                def create(service_account_id, params)
                  @resource.create(service_account_id, params)
                end

                # @api private
                #
                # @param resource [APIKeys]
                def initialize(resource:)
                  @resource = resource
                end
              end
            end
          end
        end
      end
    end
  end
end
