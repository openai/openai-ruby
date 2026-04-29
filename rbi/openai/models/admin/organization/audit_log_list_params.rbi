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
          # updated.
          sig { returns(T.nilable(T::Array[String])) }
          attr_reader :resource_ids

          sig { params(resource_ids: T::Array[String]).void }
          attr_writer :resource_ids

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
            # updated.
            resource_ids: nil,
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
