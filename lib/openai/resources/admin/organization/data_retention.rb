# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class DataRetention
          # Returns a wrapper that exposes the raw HTTP response for each request.
          #
          # @return [DataRetention::WithRawResponse]
          def with_raw_response
            WithRawResponse.new(
              resource: DataRetention.new(
                client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
              )
            )
          end

          # Retrieves organization data retention controls.
          #
          # @overload retrieve(request_options: {})
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::OrganizationDataRetention]
          #
          # @see OpenAI::Models::Admin::Organization::DataRetentionRetrieveParams
          def retrieve(params = {})
            @client.request(
              method: :get,
              path: "organization/data_retention",
              model: OpenAI::Admin::Organization::OrganizationDataRetention,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # Updates organization data retention controls.
          #
          # @overload update(retention_type:, request_options: {})
          #
          # @param retention_type [Symbol, OpenAI::Models::Admin::Organization::DataRetentionUpdateParams::RetentionType] The desired organization data retention type.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::OrganizationDataRetention]
          #
          # @see OpenAI::Models::Admin::Organization::DataRetentionUpdateParams
          def update(params)
            parsed, options = OpenAI::Admin::Organization::DataRetentionUpdateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/data_retention",
              body: parsed,
              model: OpenAI::Admin::Organization::OrganizationDataRetention,
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
            def retrieve(params = {})
              @resource.retrieve(params)
            end

            def update(params)
              @resource.update(params)
            end

            # @api private
            #
            # @param resource [DataRetention]
            def initialize(resource:)
              @resource = resource
            end
          end
        end
      end
    end
  end
end
