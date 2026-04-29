# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::AuditLogs#list
        class AuditLogListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute actor_emails
          #   Return only events performed by users with these emails.
          #
          #   @return [Array<String>, nil]
          optional :actor_emails, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute actor_ids
          #   Return only events performed by these actors. Can be a user ID, a service
          #   account ID, or an api key tracking ID.
          #
          #   @return [Array<String>, nil]
          optional :actor_ids, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute after
          #   A cursor for use in pagination. `after` is an object ID that defines your place
          #   in the list. For instance, if you make a list request and receive 100 objects,
          #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
          #   fetch the next page of the list.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute before
          #   A cursor for use in pagination. `before` is an object ID that defines your place
          #   in the list. For instance, if you make a list request and receive 100 objects,
          #   starting with obj_foo, your subsequent call can include before=obj_foo in order
          #   to fetch the previous page of the list.
          #
          #   @return [String, nil]
          optional :before, String

          # @!attribute effective_at
          #   Return only events whose `effective_at` (Unix seconds) is in this range.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListParams::EffectiveAt, nil]
          optional :effective_at, -> { OpenAI::Admin::Organization::AuditLogListParams::EffectiveAt }

          # @!attribute event_types
          #   Return only events with a `type` in one of these values. For example,
          #   `project.created`. For all options, see the documentation for the
          #   [audit log object](https://platform.openai.com/docs/api-reference/audit-logs/object).
          #
          #   @return [Array<Symbol, OpenAI::Models::Admin::Organization::AuditLogListParams::EventType>, nil]
          optional :event_types,
                   -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Admin::Organization::AuditLogListParams::EventType] }

          # @!attribute limit
          #   A limit on the number of objects to be returned. Limit can range between 1 and
          #   100, and the default is 20.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute project_ids
          #   Return only events for these projects.
          #
          #   @return [Array<String>, nil]
          optional :project_ids, OpenAI::Internal::Type::ArrayOf[String]

          # @!attribute resource_ids
          #   Return only events performed on these targets. For example, a project ID
          #   updated.
          #
          #   @return [Array<String>, nil]
          optional :resource_ids, OpenAI::Internal::Type::ArrayOf[String]

          # @!method initialize(actor_emails: nil, actor_ids: nil, after: nil, before: nil, effective_at: nil, event_types: nil, limit: nil, project_ids: nil, resource_ids: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::AuditLogListParams} for more details.
          #
          #   @param actor_emails [Array<String>] Return only events performed by users with these emails.
          #
          #   @param actor_ids [Array<String>] Return only events performed by these actors. Can be a user ID, a service accoun
          #
          #   @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
          #
          #   @param before [String] A cursor for use in pagination. `before` is an object ID that defines your place
          #
          #   @param effective_at [OpenAI::Models::Admin::Organization::AuditLogListParams::EffectiveAt] Return only events whose `effective_at` (Unix seconds) is in this range.
          #
          #   @param event_types [Array<Symbol, OpenAI::Models::Admin::Organization::AuditLogListParams::EventType>] Return only events with a `type` in one of these values. For example, `project.c
          #
          #   @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
          #
          #   @param project_ids [Array<String>] Return only events for these projects.
          #
          #   @param resource_ids [Array<String>] Return only events performed on these targets. For example, a project ID updated
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          class EffectiveAt < OpenAI::Internal::Type::BaseModel
            # @!attribute gt
            #   Return only events whose `effective_at` (Unix seconds) is greater than this
            #   value.
            #
            #   @return [Integer, nil]
            optional :gt, Integer

            # @!attribute gte
            #   Return only events whose `effective_at` (Unix seconds) is greater than or equal
            #   to this value.
            #
            #   @return [Integer, nil]
            optional :gte, Integer

            # @!attribute lt
            #   Return only events whose `effective_at` (Unix seconds) is less than this value.
            #
            #   @return [Integer, nil]
            optional :lt, Integer

            # @!attribute lte
            #   Return only events whose `effective_at` (Unix seconds) is less than or equal to
            #   this value.
            #
            #   @return [Integer, nil]
            optional :lte, Integer

            # @!method initialize(gt: nil, gte: nil, lt: nil, lte: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Admin::Organization::AuditLogListParams::EffectiveAt} for more
            #   details.
            #
            #   Return only events whose `effective_at` (Unix seconds) is in this range.
            #
            #   @param gt [Integer] Return only events whose `effective_at` (Unix seconds) is greater than this valu
            #
            #   @param gte [Integer] Return only events whose `effective_at` (Unix seconds) is greater than or equal
            #
            #   @param lt [Integer] Return only events whose `effective_at` (Unix seconds) is less than this value.
            #
            #   @param lte [Integer] Return only events whose `effective_at` (Unix seconds) is less than or equal to
          end

          # The event type.
          module EventType
            extend OpenAI::Internal::Type::Enum

            API_KEY_CREATED = :"api_key.created"
            API_KEY_UPDATED = :"api_key.updated"
            API_KEY_DELETED = :"api_key.deleted"
            CERTIFICATE_CREATED = :"certificate.created"
            CERTIFICATE_UPDATED = :"certificate.updated"
            CERTIFICATE_DELETED = :"certificate.deleted"
            CERTIFICATES_ACTIVATED = :"certificates.activated"
            CERTIFICATES_DEACTIVATED = :"certificates.deactivated"
            CHECKPOINT_PERMISSION_CREATED = :"checkpoint.permission.created"
            CHECKPOINT_PERMISSION_DELETED = :"checkpoint.permission.deleted"
            EXTERNAL_KEY_REGISTERED = :"external_key.registered"
            EXTERNAL_KEY_REMOVED = :"external_key.removed"
            GROUP_CREATED = :"group.created"
            GROUP_UPDATED = :"group.updated"
            GROUP_DELETED = :"group.deleted"
            INVITE_SENT = :"invite.sent"
            INVITE_ACCEPTED = :"invite.accepted"
            INVITE_DELETED = :"invite.deleted"
            IP_ALLOWLIST_CREATED = :"ip_allowlist.created"
            IP_ALLOWLIST_UPDATED = :"ip_allowlist.updated"
            IP_ALLOWLIST_DELETED = :"ip_allowlist.deleted"
            IP_ALLOWLIST_CONFIG_ACTIVATED = :"ip_allowlist.config.activated"
            IP_ALLOWLIST_CONFIG_DEACTIVATED = :"ip_allowlist.config.deactivated"
            LOGIN_SUCCEEDED = :"login.succeeded"
            LOGIN_FAILED = :"login.failed"
            LOGOUT_SUCCEEDED = :"logout.succeeded"
            LOGOUT_FAILED = :"logout.failed"
            ORGANIZATION_UPDATED = :"organization.updated"
            PROJECT_CREATED = :"project.created"
            PROJECT_UPDATED = :"project.updated"
            PROJECT_ARCHIVED = :"project.archived"
            PROJECT_DELETED = :"project.deleted"
            RATE_LIMIT_UPDATED = :"rate_limit.updated"
            RATE_LIMIT_DELETED = :"rate_limit.deleted"
            RESOURCE_DELETED = :"resource.deleted"
            TUNNEL_CREATED = :"tunnel.created"
            TUNNEL_UPDATED = :"tunnel.updated"
            TUNNEL_DELETED = :"tunnel.deleted"
            ROLE_CREATED = :"role.created"
            ROLE_UPDATED = :"role.updated"
            ROLE_DELETED = :"role.deleted"
            ROLE_ASSIGNMENT_CREATED = :"role.assignment.created"
            ROLE_ASSIGNMENT_DELETED = :"role.assignment.deleted"
            SCIM_ENABLED = :"scim.enabled"
            SCIM_DISABLED = :"scim.disabled"
            SERVICE_ACCOUNT_CREATED = :"service_account.created"
            SERVICE_ACCOUNT_UPDATED = :"service_account.updated"
            SERVICE_ACCOUNT_DELETED = :"service_account.deleted"
            USER_ADDED = :"user.added"
            USER_UPDATED = :"user.updated"
            USER_DELETED = :"user.deleted"

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
