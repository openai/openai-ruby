# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class AuditLogListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::AuditLogListParams,
                OpenAI::Internal::AnyHash
              )
            end

          # Return only events performed by users with these emails.
          sig { returns(T.nilable(T::Array[String])) }
          attr_reader :actor_emails

          sig { params(actor_emails: T::Array[String]).void }
          attr_writer :actor_emails

          # Return only events performed by these actors. Can be a user ID, a service
          # account ID, or an api key tracking ID.
          sig { returns(T.nilable(T::Array[String])) }
          attr_reader :actor_ids

          sig { params(actor_ids: T::Array[String]).void }
          attr_writer :actor_ids

          # A cursor for use in pagination. `after` is an object ID that defines your place
          # in the list. For instance, if you make a list request and receive 100 objects,
          # ending with obj_foo, your subsequent call can include after=obj_foo in order to
          # fetch the next page of the list.
          sig { returns(T.nilable(String)) }
          attr_reader :after

          sig { params(after: String).void }
          attr_writer :after

          # A cursor for use in pagination. `before` is an object ID that defines your place
          # in the list. For instance, if you make a list request and receive 100 objects,
          # starting with obj_foo, your subsequent call can include before=obj_foo in order
          # to fetch the previous page of the list.
          sig { returns(T.nilable(String)) }
          attr_reader :before

          sig { params(before: String).void }
          attr_writer :before

          # Return only events whose `effective_at` (Unix seconds) is in this range.
          sig do
            returns(
              T.nilable(
                OpenAI::Admin::Organization::AuditLogListParams::EffectiveAt
              )
            )
          end
          attr_reader :effective_at

          sig do
            params(
              effective_at:
                OpenAI::Admin::Organization::AuditLogListParams::EffectiveAt::OrHash
            ).void
          end
          attr_writer :effective_at

          # Return only events with a `type` in one of these values. For example,
          # `project.created`. For all options, see the documentation for the
          # [audit log object](https://platform.openai.com/docs/api-reference/audit-logs/object).
          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Admin::Organization::AuditLogListParams::EventType::OrSymbol
                ]
              )
            )
          end
          attr_reader :event_types

          sig do
            params(
              event_types:
                T::Array[
                  OpenAI::Admin::Organization::AuditLogListParams::EventType::OrSymbol
                ]
            ).void
          end
          attr_writer :event_types

          # A limit on the number of objects to be returned. Limit can range between 1 and
          # 100, and the default is 20.
          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          # Return only events for these projects.
          sig { returns(T.nilable(T::Array[String])) }
          attr_reader :project_ids

          sig { params(project_ids: T::Array[String]).void }
          attr_writer :project_ids

          # Return only events performed on these targets. For example, a project ID
          # updated. For ChatGPT connector role events, use the workspace connector resource
          # ID shown in `details.id`, such as `<workspace_id>__<connector_id>`.
          sig { returns(T.nilable(T::Array[String])) }
          attr_reader :resource_ids

          sig { params(resource_ids: T::Array[String]).void }
          attr_writer :resource_ids

          # Return only tenant-scoped events associated with this organization. Required for
          # tenant-scoped events such as `role.bound_to_resource` and
          # `role.unbound_from_resource`. When `true`, all supplied event types must be
          # tenant-scoped.
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :tenant_only

          sig { params(tenant_only: T::Boolean).void }
          attr_writer :tenant_only

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
              tenant_only: T::Boolean,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
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
            # updated. For ChatGPT connector role events, use the workspace connector resource
            # ID shown in `details.id`, such as `<workspace_id>__<connector_id>`.
            resource_ids: nil,
            # Return only tenant-scoped events associated with this organization. Required for
            # tenant-scoped events such as `role.bound_to_resource` and
            # `role.unbound_from_resource`. When `true`, all supplied event types must be
            # tenant-scoped.
            tenant_only: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                actor_emails: T::Array[String],
                actor_ids: T::Array[String],
                after: String,
                before: String,
                effective_at:
                  OpenAI::Admin::Organization::AuditLogListParams::EffectiveAt,
                event_types:
                  T::Array[
                    OpenAI::Admin::Organization::AuditLogListParams::EventType::OrSymbol
                  ],
                limit: Integer,
                project_ids: T::Array[String],
                resource_ids: T::Array[String],
                tenant_only: T::Boolean,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          class EffectiveAt < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::AuditLogListParams::EffectiveAt,
                  OpenAI::Internal::AnyHash
                )
              end

            # Return only events whose `effective_at` (Unix seconds) is greater than this
            # value.
            sig { returns(T.nilable(Integer)) }
            attr_reader :gt

            sig { params(gt: Integer).void }
            attr_writer :gt

            # Return only events whose `effective_at` (Unix seconds) is greater than or equal
            # to this value.
            sig { returns(T.nilable(Integer)) }
            attr_reader :gte

            sig { params(gte: Integer).void }
            attr_writer :gte

            # Return only events whose `effective_at` (Unix seconds) is less than this value.
            sig { returns(T.nilable(Integer)) }
            attr_reader :lt

            sig { params(lt: Integer).void }
            attr_writer :lt

            # Return only events whose `effective_at` (Unix seconds) is less than or equal to
            # this value.
            sig { returns(T.nilable(Integer)) }
            attr_reader :lte

            sig { params(lte: Integer).void }
            attr_writer :lte

            # Return only events whose `effective_at` (Unix seconds) is in this range.
            sig do
              params(
                gt: Integer,
                gte: Integer,
                lt: Integer,
                lte: Integer
              ).returns(T.attached_class)
            end
            def self.new(
              # Return only events whose `effective_at` (Unix seconds) is greater than this
              # value.
              gt: nil,
              # Return only events whose `effective_at` (Unix seconds) is greater than or equal
              # to this value.
              gte: nil,
              # Return only events whose `effective_at` (Unix seconds) is less than this value.
              lt: nil,
              # Return only events whose `effective_at` (Unix seconds) is less than or equal to
              # this value.
              lte: nil
            )
            end

            sig do
              override.returns(
                { gt: Integer, gte: Integer, lt: Integer, lte: Integer }
              )
            end
            def to_hash
            end
          end

          # The event type.
          module EventType
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::AuditLogListParams::EventType
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            API_KEY_CREATED =
              T.let(
                :"api_key.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            API_KEY_UPDATED =
              T.let(
                :"api_key.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            API_KEY_DELETED =
              T.let(
                :"api_key.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            CERTIFICATE_CREATED =
              T.let(
                :"certificate.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            CERTIFICATE_UPDATED =
              T.let(
                :"certificate.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            CERTIFICATE_DELETED =
              T.let(
                :"certificate.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            CERTIFICATES_ACTIVATED =
              T.let(
                :"certificates.activated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            CERTIFICATES_DEACTIVATED =
              T.let(
                :"certificates.deactivated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            CHECKPOINT_PERMISSION_CREATED =
              T.let(
                :"checkpoint.permission.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            CHECKPOINT_PERMISSION_DELETED =
              T.let(
                :"checkpoint.permission.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            EXTERNAL_KEY_REGISTERED =
              T.let(
                :"external_key.registered",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            EXTERNAL_KEY_REMOVED =
              T.let(
                :"external_key.removed",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            GROUP_CREATED =
              T.let(
                :"group.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            GROUP_UPDATED =
              T.let(
                :"group.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            GROUP_DELETED =
              T.let(
                :"group.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            INVITE_SENT =
              T.let(
                :"invite.sent",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            INVITE_ACCEPTED =
              T.let(
                :"invite.accepted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            INVITE_DELETED =
              T.let(
                :"invite.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            IP_ALLOWLIST_CREATED =
              T.let(
                :"ip_allowlist.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            IP_ALLOWLIST_UPDATED =
              T.let(
                :"ip_allowlist.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            IP_ALLOWLIST_DELETED =
              T.let(
                :"ip_allowlist.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            IP_ALLOWLIST_CONFIG_ACTIVATED =
              T.let(
                :"ip_allowlist.config.activated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            IP_ALLOWLIST_CONFIG_DEACTIVATED =
              T.let(
                :"ip_allowlist.config.deactivated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            LOGIN_SUCCEEDED =
              T.let(
                :"login.succeeded",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            LOGIN_FAILED =
              T.let(
                :"login.failed",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            LOGOUT_SUCCEEDED =
              T.let(
                :"logout.succeeded",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            LOGOUT_FAILED =
              T.let(
                :"logout.failed",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            ORGANIZATION_UPDATED =
              T.let(
                :"organization.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            PROJECT_CREATED =
              T.let(
                :"project.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            PROJECT_UPDATED =
              T.let(
                :"project.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            PROJECT_ARCHIVED =
              T.let(
                :"project.archived",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            PROJECT_DELETED =
              T.let(
                :"project.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            RATE_LIMIT_UPDATED =
              T.let(
                :"rate_limit.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            RATE_LIMIT_DELETED =
              T.let(
                :"rate_limit.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            RESOURCE_DELETED =
              T.let(
                :"resource.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TUNNEL_CREATED =
              T.let(
                :"tunnel.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TUNNEL_UPDATED =
              T.let(
                :"tunnel.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TUNNEL_DELETED =
              T.let(
                :"tunnel.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            WORKLOAD_IDENTITY_PROVIDER_CREATED =
              T.let(
                :"workload_identity_provider.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            WORKLOAD_IDENTITY_PROVIDER_UPDATED =
              T.let(
                :"workload_identity_provider.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            WORKLOAD_IDENTITY_PROVIDER_DELETED =
              T.let(
                :"workload_identity_provider.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            WORKLOAD_IDENTITY_PROVIDER_MAPPING_CREATED =
              T.let(
                :"workload_identity_provider_mapping.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            WORKLOAD_IDENTITY_PROVIDER_MAPPING_UPDATED =
              T.let(
                :"workload_identity_provider_mapping.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            WORKLOAD_IDENTITY_PROVIDER_MAPPING_DELETED =
              T.let(
                :"workload_identity_provider_mapping.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            ROLE_CREATED =
              T.let(
                :"role.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            ROLE_UPDATED =
              T.let(
                :"role.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            ROLE_DELETED =
              T.let(
                :"role.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            ROLE_ASSIGNMENT_CREATED =
              T.let(
                :"role.assignment.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            ROLE_ASSIGNMENT_DELETED =
              T.let(
                :"role.assignment.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            ROLE_BOUND_TO_RESOURCE =
              T.let(
                :"role.bound_to_resource",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            ROLE_UNBOUND_FROM_RESOURCE =
              T.let(
                :"role.unbound_from_resource",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            SCIM_ENABLED =
              T.let(
                :"scim.enabled",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            SCIM_DISABLED =
              T.let(
                :"scim.disabled",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            SERVICE_ACCOUNT_CREATED =
              T.let(
                :"service_account.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            SERVICE_ACCOUNT_UPDATED =
              T.let(
                :"service_account.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            SERVICE_ACCOUNT_DELETED =
              T.let(
                :"service_account.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            USER_ADDED =
              T.let(
                :"user.added",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            USER_UPDATED =
              T.let(
                :"user.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            USER_DELETED =
              T.let(
                :"user.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_METADATA_UPDATED =
              T.let(
                :"tenant.metadata.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_MICROSOFT_ENTRA_MAPPING_UPSERTED =
              T.let(
                :"tenant.microsoft_entra_mapping.upserted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_MICROSOFT_ENTRA_MAPPING_DELETED =
              T.let(
                :"tenant.microsoft_entra_mapping.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_WORKLOAD_IDENTITY_PROVIDER_CREATED =
              T.let(
                :"tenant.workload_identity.provider.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_WORKLOAD_IDENTITY_PROVIDER_UPDATED =
              T.let(
                :"tenant.workload_identity.provider.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_WORKLOAD_IDENTITY_PROVIDER_ARCHIVED =
              T.let(
                :"tenant.workload_identity.provider.archived",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_WORKLOAD_IDENTITY_MAPPING_CREATED =
              T.let(
                :"tenant.workload_identity.mapping.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_WORKLOAD_IDENTITY_MAPPING_UPDATED =
              T.let(
                :"tenant.workload_identity.mapping.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_WORKLOAD_IDENTITY_MAPPING_ARCHIVED =
              T.let(
                :"tenant.workload_identity.mapping.archived",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_WORKLOAD_IDENTITY_BINDING_CREATED =
              T.let(
                :"tenant.workload_identity.binding.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_WORKLOAD_IDENTITY_PRINCIPAL_PROVISIONED =
              T.let(
                :"tenant.workload_identity.principal.provisioned",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_ADMIN_API_KEY_CREATED =
              T.let(
                :"tenant.admin_api_key.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_ADMIN_API_KEY_UPDATED =
              T.let(
                :"tenant.admin_api_key.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_ADMIN_API_KEY_DELETED =
              T.let(
                :"tenant.admin_api_key.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_PROJECT_API_KEY_CREATED =
              T.let(
                :"tenant.project_api_key.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_CHATGPT_ACCESS_TOKEN_REVOKED =
              T.let(
                :"tenant.chatgpt_access_token.revoked",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_MIGRATION_COMPLETED =
              T.let(
                :"tenant.migration.completed",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SSO_MIGRATED =
              T.let(
                :"tenant.sso.migrated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_DOMAINS_MIGRATED =
              T.let(
                :"tenant.domains.migrated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SSO_CONNECTION_CREATED =
              T.let(
                :"tenant.sso_connection.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SSO_CONNECTION_UPDATED =
              T.let(
                :"tenant.sso_connection.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SSO_CONNECTION_DELETED =
              T.let(
                :"tenant.sso_connection.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SSO_CONNECTION_SETUP_STARTED =
              T.let(
                :"tenant.sso_connection.setup.started",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_POLICY_CREATED =
              T.let(
                :"tenant.policy.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_POLICY_UPDATED =
              T.let(
                :"tenant.policy.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_POLICY_DELETED =
              T.let(
                :"tenant.policy.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_POLICY_ATTACHED =
              T.let(
                :"tenant.policy.attached",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_POLICY_DETACHED =
              T.let(
                :"tenant.policy.detached",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_PRINCIPAL_AUTHENTICATION_POLICY_RESOLVED =
              T.let(
                :"tenant.principal_authentication_policy.resolved",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SCIM_SETUP_STARTED =
              T.let(
                :"tenant.scim.setup.started",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SCIM_DELETION_REQUESTED =
              T.let(
                :"tenant.scim.deletion.requested",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SCIM_DIRECTORY_CREATED =
              T.let(
                :"tenant.scim.directory.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_PRODUCT_ACCESS_POLICY_UPDATED =
              T.let(
                :"tenant.product_access_policy.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_RESOURCE_SHARE_GRANT_CREATED =
              T.let(
                :"tenant.resource_share_grant.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_RESOURCE_SHARE_GRANT_UPDATED =
              T.let(
                :"tenant.resource_share_grant.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_RESOURCE_SHARE_GRANT_ACCEPTED =
              T.let(
                :"tenant.resource_share_grant.accepted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_RESOURCE_SHARE_GRANT_DECLINED =
              T.let(
                :"tenant.resource_share_grant.declined",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_RESOURCE_SHARE_GRANT_REVOKED =
              T.let(
                :"tenant.resource_share_grant.revoked",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_RESOURCE_SHARE_GRANT_DELETED =
              T.let(
                :"tenant.resource_share_grant.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SERVICE_ACCOUNT_UPDATED =
              T.let(
                :"tenant.service_account.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SERVICE_ACCOUNT_DELETED =
              T.let(
                :"tenant.service_account.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SERVICE_ACCOUNT_TOKEN_REVOKED =
              T.let(
                :"tenant.service_account.token.revoked",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_BILLING_OVERAGE_LIMIT_UPDATED =
              T.let(
                :"tenant.billing.overage_limit.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_BILLING_ALERTS_UPDATED =
              T.let(
                :"tenant.billing.alerts.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_BILLING_INFO_UPDATED =
              T.let(
                :"tenant.billing.info.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_USAGE_LIMIT_WORKSPACE_UPDATED =
              T.let(
                :"tenant.usage_limit.workspace.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_USAGE_LIMIT_GROUP_UPDATED =
              T.let(
                :"tenant.usage_limit.group.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_USAGE_LIMIT_USER_UPDATED =
              T.let(
                :"tenant.usage_limit.user.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_USAGE_LIMIT_INCREASE_REQUEST_UPDATED =
              T.let(
                :"tenant.usage_limit.increase_request.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_USAGE_LIMIT_INCREASE_REQUEST_RESOLVED =
              T.let(
                :"tenant.usage_limit.increase_request.resolved",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_GROUP_CREATED =
              T.let(
                :"tenant.group.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_GROUP_UPDATED =
              T.let(
                :"tenant.group.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_GROUP_DELETED =
              T.let(
                :"tenant.group.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_GROUP_MEMBER_ADDED =
              T.let(
                :"tenant.group.member.added",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_GROUP_MEMBER_REMOVED =
              T.let(
                :"tenant.group.member.removed",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_MIGRATION_ROLLOUT_STATUS_UPDATED =
              T.let(
                :"tenant.migration_rollout.status.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_MIGRATION_ROLLOUT_TIER_UPDATED =
              T.let(
                :"tenant.migration_rollout.tier.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_ROLE_METADATA_UPDATED =
              T.let(
                :"tenant.role.metadata.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_CUSTOM_ROLE_CREATED =
              T.let(
                :"tenant.custom_role.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_CUSTOM_ROLE_UPDATED =
              T.let(
                :"tenant.custom_role.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_CUSTOM_ROLE_DELETED =
              T.let(
                :"tenant.custom_role.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_ROLE_ASSIGNMENT_CREATED =
              T.let(
                :"tenant.role_assignment.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_ROLE_ASSIGNMENT_DELETED =
              T.let(
                :"tenant.role_assignment.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_RESOURCE_ROLE_ASSIGNMENT_CREATED =
              T.let(
                :"tenant.resource_role_assignment.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_RESOURCE_ROLE_ASSIGNMENT_DELETED =
              T.let(
                :"tenant.resource_role_assignment.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_RESOURCE_ACCESS_UPDATED =
              T.let(
                :"tenant.resource_access.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_RESOURCE_ACCESS_DELETED =
              T.let(
                :"tenant.resource_access.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SESSION_POLICY_CREATED =
              T.let(
                :"tenant.session_policy.created",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SESSION_POLICY_UPDATED =
              T.let(
                :"tenant.session_policy.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SESSION_POLICY_DELETED =
              T.let(
                :"tenant.session_policy.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_SESSION_REVOCATION_STARTED =
              T.let(
                :"tenant.session_revocation.started",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_THIRD_PARTY_APP_POLICY_UPDATED =
              T.let(
                :"tenant.third_party_app_policy.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_USER_ADDED =
              T.let(
                :"tenant.user.added",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_USER_UPDATED =
              T.let(
                :"tenant.user.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_USER_REMOVED =
              T.let(
                :"tenant.user.removed",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_USER_LOOKED_UP =
              T.let(
                :"tenant.user.looked_up",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_USER_INVITED =
              T.let(
                :"tenant.user.invited",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_MEMBERSHIP_REVOKED =
              T.let(
                :"tenant.membership.revoked",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_API_ORGANIZATION_INVITE_UPSERTED =
              T.let(
                :"tenant.api_organization_invite.upserted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_API_ORGANIZATION_INVITE_DELETED =
              T.let(
                :"tenant.api_organization_invite.deleted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_CHATGPT_WORKSPACE_INVITE_UPSERTED =
              T.let(
                :"tenant.chatgpt_workspace_invite.upserted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_MEMBERSHIP_ACCEPTED =
              T.let(
                :"tenant.membership.accepted",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_MEMBERSHIP_DECLINED =
              T.let(
                :"tenant.membership.declined",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )
            TENANT_WORKSPACE_INVITE_EMAIL_SETTINGS_UPDATED =
              T.let(
                :"tenant.workspace_invite_email_settings.updated",
                OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::AuditLogListParams::EventType::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
