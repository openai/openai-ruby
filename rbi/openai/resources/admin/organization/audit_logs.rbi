# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        # List user actions and configuration changes within this organization.
        class AuditLogs
          # List user actions and configuration changes within this organization.
          sig do
            params(
              actor_emails: T::Array[String],
              actor_ids: T::Array[String],
              after: String,
              before: String,
              effective_at:
                OpenAI::Admin::Organization::AuditLogListParams::EffectiveAt::OrHash,
              event_types:
                T::Array[
                  OpenAI::Admin::Organization::AuditLogListParams::EventType::OrSymbol
                ],
              limit: Integer,
              project_ids: T::Array[String],
              resource_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::ConversationCursorPage[
                OpenAI::Models::Admin::Organization::AuditLogListResponse
              ]
            )
          end
          def list(
            # Return only events performed by users with these emails.
            actor_emails: nil,
            # Return only events performed by these actors. Can be a user ID, a service
            # account ID, or an api key tracking ID.
            actor_ids: nil,
            # A cursor for use in pagination. `after` is an object ID that defines your place
            # in the list. For instance, if you make a list request and receive 100 objects,
            # ending with obj_foo, your subsequent call can include after=obj_foo in order to
            # fetch the next page of the list.
            after: nil,
            # A cursor for use in pagination. `before` is an object ID that defines your place
            # in the list. For instance, if you make a list request and receive 100 objects,
            # starting with obj_foo, your subsequent call can include before=obj_foo in order
            # to fetch the previous page of the list.
            before: nil,
            # Return only events whose `effective_at` (Unix seconds) is in this range.
            effective_at: nil,
            # Return only events with a `type` in one of these values. For example,
            # `project.created`. For all options, see the documentation for the
            # [audit log object](https://platform.openai.com/docs/api-reference/audit-logs/object).
            event_types: nil,
            # A limit on the number of objects to be returned. Limit can range between 1 and
            # 100, and the default is 20.
            limit: nil,
            # Return only events for these projects.
            project_ids: nil,
            # Return only events performed on these targets. For example, a project ID
            # updated.
            resource_ids: nil,
            request_options: {}
          )
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
