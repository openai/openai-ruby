# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Certificates
          # Upload a certificate to the organization. This does **not** automatically
          # activate the certificate.
          #
          # Organizations can upload up to 50 certificates.
          sig do
            params(
              content: String,
              name: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::Certificate)
          end
          def create(
            # The certificate content in PEM format
            content:,
            # An optional name for the certificate
            name: nil,
            request_options: {}
          )
          end

          # Get a certificate that has been uploaded to the organization.
          #
          # You can get a certificate regardless of whether it is active or not.
          sig do
            params(
              certificate_id: String,
              include:
                T::Array[
                  OpenAI::Admin::Organization::CertificateRetrieveParams::Include::OrSymbol
                ],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::Certificate)
          end
          def retrieve(
            # Unique ID of the certificate to retrieve.
            certificate_id,
            # A list of additional fields to include in the response. Currently the only
            # supported value is `content` to fetch the PEM content of the certificate.
            include: nil,
            request_options: {}
          )
          end

          # Modify a certificate. Note that only the name can be modified.
          sig do
            params(
              certificate_id: String,
              name: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::Certificate)
          end
          def update(
            # Unique ID of the certificate to modify.
            certificate_id,
            # The updated name for the certificate
            name:,
            request_options: {}
          )
          end

          # List uploaded certificates for this organization.
          sig do
            params(
              after: String,
              limit: Integer,
              order:
                OpenAI::Admin::Organization::CertificateListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::ConversationCursorPage[
                OpenAI::Admin::Organization::Certificate
              ]
            )
          end
          def list(
            # A cursor for use in pagination. `after` is an object ID that defines your place
            # in the list. For instance, if you make a list request and receive 100 objects,
            # ending with obj_foo, your subsequent call can include after=obj_foo in order to
            # fetch the next page of the list.
            after: nil,
            # A limit on the number of objects to be returned. Limit can range between 1 and
            # 100, and the default is 20.
            limit: nil,
            # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            # order and `desc` for descending order.
            order: nil,
            request_options: {}
          )
          end

          # Delete a certificate from the organization.
          #
          # The certificate must be inactive for the organization and all projects.
          sig do
            params(
              certificate_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Models::Admin::Organization::CertificateDeleteResponse
            )
          end
          def delete(
            # Unique ID of the certificate to delete.
            certificate_id,
            request_options: {}
          )
          end

          # Activate certificates at the organization level.
          #
          # You can atomically and idempotently activate up to 10 certificates at a time.
          sig do
            params(
              certificate_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::Page[OpenAI::Admin::Organization::Certificate]
            )
          end
          def activate(certificate_ids:, request_options: {})
          end

          # Deactivate certificates at the organization level.
          #
          # You can atomically and idempotently deactivate up to 10 certificates at a time.
          sig do
            params(
              certificate_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::Page[OpenAI::Admin::Organization::Certificate]
            )
          end
          def deactivate(certificate_ids:, request_options: {})
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
