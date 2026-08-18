# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Certificates
          # Upload a certificate to the organization. This does **not** automatically
          # activate the certificate.
          #
          # Organizations can upload up to 50 certificates.
          #
          # @overload create(certificate:, name: nil, request_options: {})
          #
          # @param certificate [String] The certificate content in PEM format
          #
          # @param name [String] An optional name for the certificate
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::Certificate]
          #
          # @see OpenAI::Models::Admin::Organization::CertificateCreateParams
          def create(params)
            parsed, options = OpenAI::Admin::Organization::CertificateCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/certificates",
              body: parsed,
              model: OpenAI::Admin::Organization::Certificate,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::CertificateRetrieveParams} for more
          # details.
          #
          # Get a certificate that has been uploaded to the organization.
          #
          # You can get a certificate regardless of whether it is active or not.
          #
          # @overload retrieve(certificate_id, include: nil, request_options: {})
          #
          # @param certificate_id [String] Unique ID of the certificate to retrieve.
          #
          # @param include [Array<Symbol, OpenAI::Models::Admin::Organization::CertificateRetrieveParams::Include>] A list of additional fields to include in the response. Currently the only suppo
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::Certificate]
          #
          # @see OpenAI::Models::Admin::Organization::CertificateRetrieveParams
          def retrieve(certificate_id, params = {})
            parsed, options = OpenAI::Admin::Organization::CertificateRetrieveParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: ["organization/certificates/%1$s", certificate_id],
              query: query,
              model: OpenAI::Admin::Organization::Certificate,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Modify a certificate. Note that only the name can be modified.
          #
          # @overload update(certificate_id, name: nil, request_options: {})
          #
          # @param certificate_id [String] Unique ID of the certificate to modify.
          #
          # @param name [String] The updated name for the certificate
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::Certificate]
          #
          # @see OpenAI::Models::Admin::Organization::CertificateUpdateParams
          def update(certificate_id, params = {})
            parsed, options = OpenAI::Admin::Organization::CertificateUpdateParams.dump_request(params)
            @client.request(
              method: :post,
              path: ["organization/certificates/%1$s", certificate_id],
              body: parsed,
              model: OpenAI::Admin::Organization::Certificate,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::CertificateListParams} for more details.
          #
          # List uploaded certificates for this organization.
          #
          # @overload list(after: nil, limit: nil, order: nil, request_options: {})
          #
          # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
          #
          # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
          #
          # @param order [Symbol, OpenAI::Models::Admin::Organization::CertificateListParams::Order] Sort order by the `created_at` timestamp of the objects. `asc` for ascending ord
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Admin::Organization::CertificateListResponse>]
          #
          # @see OpenAI::Models::Admin::Organization::CertificateListParams
          def list(params = {})
            parsed, options = OpenAI::Admin::Organization::CertificateListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/certificates",
              query: query,
              page: OpenAI::Internal::ConversationCursorPage,
              model: OpenAI::Models::Admin::Organization::CertificateListResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Delete a certificate from the organization.
          #
          # The certificate must be inactive for the organization and all projects.
          #
          # @overload delete(certificate_id, request_options: {})
          #
          # @param certificate_id [String] Unique ID of the certificate to delete.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::CertificateDeleteResponse]
          #
          # @see OpenAI::Models::Admin::Organization::CertificateDeleteParams
          def delete(certificate_id, params = {})
            @client.request(
              method: :delete,
              path: ["organization/certificates/%1$s", certificate_id],
              model: OpenAI::Models::Admin::Organization::CertificateDeleteResponse,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # Activate certificates at the organization level.
          #
          # You can atomically and idempotently activate up to 10 certificates at a time.
          #
          # @overload activate(certificate_ids:, request_options: {})
          #
          # @param certificate_ids [Array<String>]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::Page<OpenAI::Models::Admin::Organization::CertificateActivateResponse>]
          #
          # @see OpenAI::Models::Admin::Organization::CertificateActivateParams
          def activate(params)
            parsed, options = OpenAI::Admin::Organization::CertificateActivateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/certificates/activate",
              body: parsed,
              page: OpenAI::Internal::Page,
              model: OpenAI::Models::Admin::Organization::CertificateActivateResponse,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Deactivate certificates at the organization level.
          #
          # You can atomically and idempotently deactivate up to 10 certificates at a time.
          #
          # @overload deactivate(certificate_ids:, request_options: {})
          #
          # @param certificate_ids [Array<String>]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::Page<OpenAI::Models::Admin::Organization::CertificateDeactivateResponse>]
          #
          # @see OpenAI::Models::Admin::Organization::CertificateDeactivateParams
          def deactivate(params)
            parsed, options = OpenAI::Admin::Organization::CertificateDeactivateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/certificates/deactivate",
              body: parsed,
              page: OpenAI::Internal::Page,
              model: OpenAI::Models::Admin::Organization::CertificateDeactivateResponse,
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
