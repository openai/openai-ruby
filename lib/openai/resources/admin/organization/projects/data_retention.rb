# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
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

            # Retrieves project data retention controls.
            #
            # @overload retrieve(project_id, request_options: {})
            #
            # @param project_id [String] The ID of the project to inspect.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectDataRetention]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::DataRetentionRetrieveParams
            def retrieve(project_id, params = {})
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/data_retention", project_id],
                model: OpenAI::Admin::Organization::Projects::ProjectDataRetention,
                security: {admin_api_key_auth: true},
                options: params[:request_options]
              )
            end

            # Updates project data retention controls.
            #
            # @overload update(project_id, retention_type:, request_options: {})
            #
            # @param project_id [String] The ID of the project to update.
            #
            # @param retention_type [Symbol, OpenAI::Models::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType] The desired project data retention type.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectDataRetention]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::DataRetentionUpdateParams
            def update(project_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/data_retention", project_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Projects::ProjectDataRetention,
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
              def retrieve(project_id, params = {})
                @resource.retrieve(project_id, params)
              end

              def update(project_id, params)
                @resource.update(project_id, params)
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
end
