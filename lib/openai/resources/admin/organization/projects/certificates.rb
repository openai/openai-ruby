# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class Certificates
            # List certificates for this project.
            #
            # @overload list(project_id, after: nil, limit: nil, order: nil, request_options: {})
            #
            # @param project_id [String]
            #   The ID of the project.
            #
            # @param after [String]
            #   A cursor for use in pagination. `after` is an object ID that defines your place
            #   in the list. For instance, if you make a list request and receive 100 objects,
            #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
            #   fetch the next page of the list.
            #
            # @param limit [Integer]
            #   A limit on the number of objects to be returned. Limit can range between 1 and
            #   100, and the default is 20.
            #
            # @param order [Symbol, OpenAI::Models::Admin::Organization::Projects::CertificateListParams::Order]
            #   Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            #   order and `desc` for descending order.
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
            # @param project_id [String]
            #   The ID of the project.
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
            # @param project_id [String]
            #   The ID of the project.
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
            # @param client [OpenAI::Client]
            def initialize(client:)
              @client = client
            end
          end
        end
      end
    end
  end
end
