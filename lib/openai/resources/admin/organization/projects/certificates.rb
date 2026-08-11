# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class Certificates
            # Returns a wrapper that exposes the raw HTTP response for each request.
            #
            # @return [Certificates::WithRawResponse]
            def with_raw_response
              WithRawResponse.new(
                resource: Certificates.new(
                  client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
                )
              )
            end

            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Admin::Organization::Projects::CertificateListParams} for more
            # details.
            #
            # List certificates for this project.
            #
            # @overload list(project_id, after: nil, limit: nil, order: nil, request_options: {})
            #
            # @param project_id [String] The ID of the project.
            #
            # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
            #
            # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
            #
            # @param order [Symbol, OpenAI::Models::Admin::Organization::Projects::CertificateListParams::Order] Sort order by the `created_at` timestamp of the objects. `asc` for ascending ord
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Admin::Organization::Projects::CertificateListResponse>]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::CertificateListParams
            def list(project_id, params = {})
              parsed, options = OpenAI::Admin::Organization::Projects::CertificateListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/certificates", project_id],
                query: query,
                page: OpenAI::Internal::ConversationCursorPage,
                model: OpenAI::Models::Admin::Organization::Projects::CertificateListResponse,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Activate certificates at the project level.
            #
            # You can atomically and idempotently activate up to 10 certificates at a time.
            #
            # @overload activate(project_id, certificate_ids:, request_options: {})
            #
            # @param project_id [String] The ID of the project.
            #
            # @param certificate_ids [Array<String>]
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::Page<OpenAI::Models::Admin::Organization::Projects::CertificateActivateResponse>]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::CertificateActivateParams
            def activate(project_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::CertificateActivateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/certificates/activate", project_id],
                body: parsed,
                page: OpenAI::Internal::Page,
                model: OpenAI::Models::Admin::Organization::Projects::CertificateActivateResponse,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Deactivate certificates at the project level. You can atomically and
            # idempotently deactivate up to 10 certificates at a time.
            #
            # @overload deactivate(project_id, certificate_ids:, request_options: {})
            #
            # @param project_id [String] The ID of the project.
            #
            # @param certificate_ids [Array<String>]
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::Page<OpenAI::Models::Admin::Organization::Projects::CertificateDeactivateResponse>]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::CertificateDeactivateParams
            def deactivate(project_id, params)
              parsed, options = OpenAI::Admin::Organization::Projects::CertificateDeactivateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/certificates/deactivate", project_id],
                body: parsed,
                page: OpenAI::Internal::Page,
                model: OpenAI::Models::Admin::Organization::Projects::CertificateDeactivateResponse,
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
              def list(project_id, params = {})
                @resource.list(project_id, params)
              end

              def activate(project_id, params)
                @resource.activate(project_id, params)
              end

              def deactivate(project_id, params)
                @resource.deactivate(project_id, params)
              end

              # @api private
              #
              # @param resource [Certificates]
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
