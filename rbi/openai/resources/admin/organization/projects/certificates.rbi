# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class Certificates
            sig { returns(Certificates::WithRawResponse) }
            def with_raw_response
            end

            # List certificates for this project.
            sig do
              params(
                project_id: String,
                after: String,
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::Projects::CertificateListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Internal::ConversationCursorPage[
                  OpenAI::Models::Admin::Organization::Projects::CertificateListResponse
                ]
              )
            end
            def list(
              # The ID of the project.
              project_id,
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

            # Activate certificates at the project level.
            #
            # You can atomically and idempotently activate up to 10 certificates at a time.
            sig do
              params(
                project_id: String,
                certificate_ids: T::Array[String],
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Internal::Page[
                  OpenAI::Models::Admin::Organization::Projects::CertificateActivateResponse
                ]
              )
            end
            def activate(
              # The ID of the project.
              project_id,
              certificate_ids:,
              request_options: {}
            )
            end

            # Deactivate certificates at the project level. You can atomically and
            # idempotently deactivate up to 10 certificates at a time.
            sig do
              params(
                project_id: String,
                certificate_ids: T::Array[String],
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Internal::Page[
                  OpenAI::Models::Admin::Organization::Projects::CertificateDeactivateResponse
                ]
              )
            end
            def deactivate(
              # The ID of the project.
              project_id,
              certificate_ids:,
              request_options: {}
            )
            end

            # @api private
            sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
            def self.new(client:)
            end

            class WithRawResponse
              sig { params(project_id: String, after: String, limit: Integer, order: OpenAI::Admin::Organization::Projects::CertificateListParams::Order::OrSymbol, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Internal::ConversationCursorPage[OpenAI::Models::Admin::Organization::Projects::CertificateListResponse]]) }
              def list(
                # The ID of the project.
                project_id,
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

              sig { params(project_id: String, certificate_ids: T::Array[String], request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Internal::Page[OpenAI::Models::Admin::Organization::Projects::CertificateActivateResponse]]) }
              def activate(
                # The ID of the project.
                project_id,
                certificate_ids:,
                request_options: {}
              )
              end

              sig { params(project_id: String, certificate_ids: T::Array[String], request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Internal::Page[OpenAI::Models::Admin::Organization::Projects::CertificateDeactivateResponse]]) }
              def deactivate(
                # The ID of the project.
                project_id,
                certificate_ids:,
                request_options: {}
              )
              end

              # @api private
              sig { params(resource: Certificates).returns(T.attached_class) }
              def self.new(resource:)
              end
            end
          end
        end
      end
    end
  end
end
