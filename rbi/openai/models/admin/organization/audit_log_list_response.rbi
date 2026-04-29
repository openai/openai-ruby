# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class AuditLogListResponse < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Admin::Organization::AuditLogListResponse,
                OpenAI::Internal::AnyHash
              )
            end

          # The ID of this log.
          sig { returns(String) }
          attr_accessor :id

          # The actor who performed the audit logged action.
          sig do
            returns(
              OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor
            )
          end
          attr_reader :actor

          sig do
            params(
              actor:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::OrHash
            ).void
          end
          attr_writer :actor

          # The Unix timestamp (in seconds) of the event.
          sig { returns(Integer) }
          attr_accessor :effective_at

          # The event type.
          sig do
            returns(
              OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
            )
          end
          attr_accessor :type

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated
              )
            )
          end
          attr_reader :api_key_created

          sig do
            params(
              api_key_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated::OrHash
            ).void
          end
          attr_writer :api_key_created

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyDeleted
              )
            )
          end
          attr_reader :api_key_deleted

          sig do
            params(
              api_key_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyDeleted::OrHash
            ).void
          end
          attr_writer :api_key_deleted

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated
              )
            )
          end
          attr_reader :api_key_updated

          sig do
            params(
              api_key_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated::OrHash
            ).void
          end
          attr_writer :api_key_updated

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateCreated
              )
            )
          end
          attr_reader :certificate_created

          sig do
            params(
              certificate_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateCreated::OrHash
            ).void
          end
          attr_writer :certificate_created

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateDeleted
              )
            )
          end
          attr_reader :certificate_deleted

          sig do
            params(
              certificate_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateDeleted::OrHash
            ).void
          end
          attr_writer :certificate_deleted

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateUpdated
              )
            )
          end
          attr_reader :certificate_updated

          sig do
            params(
              certificate_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateUpdated::OrHash
            ).void
          end
          attr_writer :certificate_updated

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated
              )
            )
          end
          attr_reader :certificates_activated

          sig do
            params(
              certificates_activated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated::OrHash
            ).void
          end
          attr_writer :certificates_activated

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated
              )
            )
          end
          attr_reader :certificates_deactivated

          sig do
            params(
              certificates_deactivated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated::OrHash
            ).void
          end
          attr_writer :certificates_deactivated

          # The project and fine-tuned model checkpoint that the checkpoint permission was
          # created for.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated
              )
            )
          end
          attr_reader :checkpoint_permission_created

          sig do
            params(
              checkpoint_permission_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated::OrHash
            ).void
          end
          attr_writer :checkpoint_permission_created

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionDeleted
              )
            )
          end
          attr_reader :checkpoint_permission_deleted

          sig do
            params(
              checkpoint_permission_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionDeleted::OrHash
            ).void
          end
          attr_writer :checkpoint_permission_deleted

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRegistered
              )
            )
          end
          attr_reader :external_key_registered

          sig do
            params(
              external_key_registered:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRegistered::OrHash
            ).void
          end
          attr_writer :external_key_registered

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRemoved
              )
            )
          end
          attr_reader :external_key_removed

          sig do
            params(
              external_key_removed:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRemoved::OrHash
            ).void
          end
          attr_writer :external_key_removed

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated
              )
            )
          end
          attr_reader :group_created

          sig do
            params(
              group_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated::OrHash
            ).void
          end
          attr_writer :group_created

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupDeleted
              )
            )
          end
          attr_reader :group_deleted

          sig do
            params(
              group_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupDeleted::OrHash
            ).void
          end
          attr_writer :group_deleted

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated
              )
            )
          end
          attr_reader :group_updated

          sig do
            params(
              group_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated::OrHash
            ).void
          end
          attr_writer :group_updated

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteAccepted
              )
            )
          end
          attr_reader :invite_accepted

          sig do
            params(
              invite_accepted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteAccepted::OrHash
            ).void
          end
          attr_writer :invite_accepted

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteDeleted
              )
            )
          end
          attr_reader :invite_deleted

          sig do
            params(
              invite_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteDeleted::OrHash
            ).void
          end
          attr_writer :invite_deleted

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent
              )
            )
          end
          attr_reader :invite_sent

          sig do
            params(
              invite_sent:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent::OrHash
            ).void
          end
          attr_writer :invite_sent

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated
              )
            )
          end
          attr_reader :ip_allowlist_config_activated

          sig do
            params(
              ip_allowlist_config_activated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated::OrHash
            ).void
          end
          attr_writer :ip_allowlist_config_activated

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated
              )
            )
          end
          attr_reader :ip_allowlist_config_deactivated

          sig do
            params(
              ip_allowlist_config_deactivated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated::OrHash
            ).void
          end
          attr_writer :ip_allowlist_config_deactivated

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistCreated
              )
            )
          end
          attr_reader :ip_allowlist_created

          sig do
            params(
              ip_allowlist_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistCreated::OrHash
            ).void
          end
          attr_writer :ip_allowlist_created

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistDeleted
              )
            )
          end
          attr_reader :ip_allowlist_deleted

          sig do
            params(
              ip_allowlist_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistDeleted::OrHash
            ).void
          end
          attr_writer :ip_allowlist_deleted

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistUpdated
              )
            )
          end
          attr_reader :ip_allowlist_updated

          sig do
            params(
              ip_allowlist_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistUpdated::OrHash
            ).void
          end
          attr_writer :ip_allowlist_updated

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::LoginFailed
              )
            )
          end
          attr_reader :login_failed

          sig do
            params(
              login_failed:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::LoginFailed::OrHash
            ).void
          end
          attr_writer :login_failed

          # This event has no additional fields beyond the standard audit log attributes.
          sig { returns(T.nilable(T.anything)) }
          attr_reader :login_succeeded

          sig { params(login_succeeded: T.anything).void }
          attr_writer :login_succeeded

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::LogoutFailed
              )
            )
          end
          attr_reader :logout_failed

          sig do
            params(
              logout_failed:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::LogoutFailed::OrHash
            ).void
          end
          attr_writer :logout_failed

          # This event has no additional fields beyond the standard audit log attributes.
          sig { returns(T.nilable(T.anything)) }
          attr_reader :logout_succeeded

          sig { params(logout_succeeded: T.anything).void }
          attr_writer :logout_succeeded

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated
              )
            )
          end
          attr_reader :organization_updated

          sig do
            params(
              organization_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated::OrHash
            ).void
          end
          attr_writer :organization_updated

          # The project that the action was scoped to. Absent for actions not scoped to
          # projects. Note that any admin actions taken via Admin API keys are associated
          # with the default project.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Project
              )
            )
          end
          attr_reader :project

          sig do
            params(
              project:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Project::OrHash
            ).void
          end
          attr_writer :project

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectArchived
              )
            )
          end
          attr_reader :project_archived

          sig do
            params(
              project_archived:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectArchived::OrHash
            ).void
          end
          attr_writer :project_archived

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated
              )
            )
          end
          attr_reader :project_created

          sig do
            params(
              project_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated::OrHash
            ).void
          end
          attr_writer :project_created

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectDeleted
              )
            )
          end
          attr_reader :project_deleted

          sig do
            params(
              project_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectDeleted::OrHash
            ).void
          end
          attr_writer :project_deleted

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated
              )
            )
          end
          attr_reader :project_updated

          sig do
            params(
              project_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated::OrHash
            ).void
          end
          attr_writer :project_updated

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitDeleted
              )
            )
          end
          attr_reader :rate_limit_deleted

          sig do
            params(
              rate_limit_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitDeleted::OrHash
            ).void
          end
          attr_writer :rate_limit_deleted

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated
              )
            )
          end
          attr_reader :rate_limit_updated

          sig do
            params(
              rate_limit_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated::OrHash
            ).void
          end
          attr_writer :rate_limit_updated

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentCreated
              )
            )
          end
          attr_reader :role_assignment_created

          sig do
            params(
              role_assignment_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentCreated::OrHash
            ).void
          end
          attr_writer :role_assignment_created

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentDeleted
              )
            )
          end
          attr_reader :role_assignment_deleted

          sig do
            params(
              role_assignment_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentDeleted::OrHash
            ).void
          end
          attr_writer :role_assignment_deleted

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleCreated
              )
            )
          end
          attr_reader :role_created

          sig do
            params(
              role_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleCreated::OrHash
            ).void
          end
          attr_writer :role_created

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleDeleted
              )
            )
          end
          attr_reader :role_deleted

          sig do
            params(
              role_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleDeleted::OrHash
            ).void
          end
          attr_writer :role_deleted

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated
              )
            )
          end
          attr_reader :role_updated

          sig do
            params(
              role_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated::OrHash
            ).void
          end
          attr_writer :role_updated

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimDisabled
              )
            )
          end
          attr_reader :scim_disabled

          sig do
            params(
              scim_disabled:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimDisabled::OrHash
            ).void
          end
          attr_writer :scim_disabled

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimEnabled
              )
            )
          end
          attr_reader :scim_enabled

          sig do
            params(
              scim_enabled:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimEnabled::OrHash
            ).void
          end
          attr_writer :scim_enabled

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated
              )
            )
          end
          attr_reader :service_account_created

          sig do
            params(
              service_account_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated::OrHash
            ).void
          end
          attr_writer :service_account_created

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountDeleted
              )
            )
          end
          attr_reader :service_account_deleted

          sig do
            params(
              service_account_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountDeleted::OrHash
            ).void
          end
          attr_writer :service_account_deleted

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated
              )
            )
          end
          attr_reader :service_account_updated

          sig do
            params(
              service_account_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated::OrHash
            ).void
          end
          attr_writer :service_account_updated

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded
              )
            )
          end
          attr_reader :user_added

          sig do
            params(
              user_added:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded::OrHash
            ).void
          end
          attr_writer :user_added

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::UserDeleted
              )
            )
          end
          attr_reader :user_deleted

          sig do
            params(
              user_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::UserDeleted::OrHash
            ).void
          end
          attr_writer :user_deleted

          # The details for events with this `type`.
          sig do
            returns(
              T.nilable(
                OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated
              )
            )
          end
          attr_reader :user_updated

          sig do
            params(
              user_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated::OrHash
            ).void
          end
          attr_writer :user_updated

          # A log of a user action or configuration change within this organization.
          sig do
            params(
              id: String,
              actor:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::OrHash,
              effective_at: Integer,
              type:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::OrSymbol,
              api_key_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated::OrHash,
              api_key_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyDeleted::OrHash,
              api_key_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated::OrHash,
              certificate_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateCreated::OrHash,
              certificate_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateDeleted::OrHash,
              certificate_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateUpdated::OrHash,
              certificates_activated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated::OrHash,
              certificates_deactivated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated::OrHash,
              checkpoint_permission_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated::OrHash,
              checkpoint_permission_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionDeleted::OrHash,
              external_key_registered:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRegistered::OrHash,
              external_key_removed:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRemoved::OrHash,
              group_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated::OrHash,
              group_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupDeleted::OrHash,
              group_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated::OrHash,
              invite_accepted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteAccepted::OrHash,
              invite_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteDeleted::OrHash,
              invite_sent:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent::OrHash,
              ip_allowlist_config_activated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated::OrHash,
              ip_allowlist_config_deactivated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated::OrHash,
              ip_allowlist_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistCreated::OrHash,
              ip_allowlist_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistDeleted::OrHash,
              ip_allowlist_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistUpdated::OrHash,
              login_failed:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::LoginFailed::OrHash,
              login_succeeded: T.anything,
              logout_failed:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::LogoutFailed::OrHash,
              logout_succeeded: T.anything,
              organization_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated::OrHash,
              project:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Project::OrHash,
              project_archived:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectArchived::OrHash,
              project_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated::OrHash,
              project_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectDeleted::OrHash,
              project_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated::OrHash,
              rate_limit_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitDeleted::OrHash,
              rate_limit_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated::OrHash,
              role_assignment_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentCreated::OrHash,
              role_assignment_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentDeleted::OrHash,
              role_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleCreated::OrHash,
              role_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleDeleted::OrHash,
              role_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated::OrHash,
              scim_disabled:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimDisabled::OrHash,
              scim_enabled:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimEnabled::OrHash,
              service_account_created:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated::OrHash,
              service_account_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountDeleted::OrHash,
              service_account_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated::OrHash,
              user_added:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded::OrHash,
              user_deleted:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::UserDeleted::OrHash,
              user_updated:
                OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of this log.
            id:,
            # The actor who performed the audit logged action.
            actor:,
            # The Unix timestamp (in seconds) of the event.
            effective_at:,
            # The event type.
            type:,
            # The details for events with this `type`.
            api_key_created: nil,
            # The details for events with this `type`.
            api_key_deleted: nil,
            # The details for events with this `type`.
            api_key_updated: nil,
            # The details for events with this `type`.
            certificate_created: nil,
            # The details for events with this `type`.
            certificate_deleted: nil,
            # The details for events with this `type`.
            certificate_updated: nil,
            # The details for events with this `type`.
            certificates_activated: nil,
            # The details for events with this `type`.
            certificates_deactivated: nil,
            # The project and fine-tuned model checkpoint that the checkpoint permission was
            # created for.
            checkpoint_permission_created: nil,
            # The details for events with this `type`.
            checkpoint_permission_deleted: nil,
            # The details for events with this `type`.
            external_key_registered: nil,
            # The details for events with this `type`.
            external_key_removed: nil,
            # The details for events with this `type`.
            group_created: nil,
            # The details for events with this `type`.
            group_deleted: nil,
            # The details for events with this `type`.
            group_updated: nil,
            # The details for events with this `type`.
            invite_accepted: nil,
            # The details for events with this `type`.
            invite_deleted: nil,
            # The details for events with this `type`.
            invite_sent: nil,
            # The details for events with this `type`.
            ip_allowlist_config_activated: nil,
            # The details for events with this `type`.
            ip_allowlist_config_deactivated: nil,
            # The details for events with this `type`.
            ip_allowlist_created: nil,
            # The details for events with this `type`.
            ip_allowlist_deleted: nil,
            # The details for events with this `type`.
            ip_allowlist_updated: nil,
            # The details for events with this `type`.
            login_failed: nil,
            # This event has no additional fields beyond the standard audit log attributes.
            login_succeeded: nil,
            # The details for events with this `type`.
            logout_failed: nil,
            # This event has no additional fields beyond the standard audit log attributes.
            logout_succeeded: nil,
            # The details for events with this `type`.
            organization_updated: nil,
            # The project that the action was scoped to. Absent for actions not scoped to
            # projects. Note that any admin actions taken via Admin API keys are associated
            # with the default project.
            project: nil,
            # The details for events with this `type`.
            project_archived: nil,
            # The details for events with this `type`.
            project_created: nil,
            # The details for events with this `type`.
            project_deleted: nil,
            # The details for events with this `type`.
            project_updated: nil,
            # The details for events with this `type`.
            rate_limit_deleted: nil,
            # The details for events with this `type`.
            rate_limit_updated: nil,
            # The details for events with this `type`.
            role_assignment_created: nil,
            # The details for events with this `type`.
            role_assignment_deleted: nil,
            # The details for events with this `type`.
            role_created: nil,
            # The details for events with this `type`.
            role_deleted: nil,
            # The details for events with this `type`.
            role_updated: nil,
            # The details for events with this `type`.
            scim_disabled: nil,
            # The details for events with this `type`.
            scim_enabled: nil,
            # The details for events with this `type`.
            service_account_created: nil,
            # The details for events with this `type`.
            service_account_deleted: nil,
            # The details for events with this `type`.
            service_account_updated: nil,
            # The details for events with this `type`.
            user_added: nil,
            # The details for events with this `type`.
            user_deleted: nil,
            # The details for events with this `type`.
            user_updated: nil
          )
          end

          sig do
            override.returns(
              {
                id: String,
                actor:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor,
                effective_at: Integer,
                type:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol,
                api_key_created:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated,
                api_key_deleted:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyDeleted,
                api_key_updated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated,
                certificate_created:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateCreated,
                certificate_deleted:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateDeleted,
                certificate_updated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateUpdated,
                certificates_activated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated,
                certificates_deactivated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated,
                checkpoint_permission_created:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated,
                checkpoint_permission_deleted:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionDeleted,
                external_key_registered:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRegistered,
                external_key_removed:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRemoved,
                group_created:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated,
                group_deleted:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupDeleted,
                group_updated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated,
                invite_accepted:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteAccepted,
                invite_deleted:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteDeleted,
                invite_sent:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent,
                ip_allowlist_config_activated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated,
                ip_allowlist_config_deactivated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated,
                ip_allowlist_created:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistCreated,
                ip_allowlist_deleted:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistDeleted,
                ip_allowlist_updated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistUpdated,
                login_failed:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::LoginFailed,
                login_succeeded: T.anything,
                logout_failed:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::LogoutFailed,
                logout_succeeded: T.anything,
                organization_updated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated,
                project:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Project,
                project_archived:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectArchived,
                project_created:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated,
                project_deleted:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectDeleted,
                project_updated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated,
                rate_limit_deleted:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitDeleted,
                rate_limit_updated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated,
                role_assignment_created:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentCreated,
                role_assignment_deleted:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentDeleted,
                role_created:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleCreated,
                role_deleted:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleDeleted,
                role_updated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated,
                scim_disabled:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimDisabled,
                scim_enabled:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimEnabled,
                service_account_created:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated,
                service_account_deleted:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountDeleted,
                service_account_updated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated,
                user_added:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded,
                user_deleted:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::UserDeleted,
                user_updated:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated
              }
            )
          end
          def to_hash
          end

          class Actor < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor,
                  OpenAI::Internal::AnyHash
                )
              end

            # The API Key used to perform the audit logged action.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey
                )
              )
            end
            attr_reader :api_key

            sig do
              params(
                api_key:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::OrHash
              ).void
            end
            attr_writer :api_key

            # The session in which the audit logged action was performed.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session
                )
              )
            end
            attr_reader :session

            sig do
              params(
                session:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session::OrHash
              ).void
            end
            attr_writer :session

            # The type of actor. Is either `session` or `api_key`.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Type::TaggedSymbol
                )
              )
            end
            attr_reader :type

            sig do
              params(
                type:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Type::OrSymbol
              ).void
            end
            attr_writer :type

            # The actor who performed the audit logged action.
            sig do
              params(
                api_key:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::OrHash,
                session:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session::OrHash,
                type:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Type::OrSymbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The API Key used to perform the audit logged action.
              api_key: nil,
              # The session in which the audit logged action was performed.
              session: nil,
              # The type of actor. Is either `session` or `api_key`.
              type: nil
            )
            end

            sig do
              override.returns(
                {
                  api_key:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey,
                  session:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session,
                  type:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Type::TaggedSymbol
                }
              )
            end
            def to_hash
            end

            class APIKey < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The tracking id of the API key.
              sig { returns(T.nilable(String)) }
              attr_reader :id

              sig { params(id: String).void }
              attr_writer :id

              # The service account that performed the audit logged action.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::ServiceAccount
                  )
                )
              end
              attr_reader :service_account

              sig do
                params(
                  service_account:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::ServiceAccount::OrHash
                ).void
              end
              attr_writer :service_account

              # The type of API key. Can be either `user` or `service_account`.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::Type::TaggedSymbol
                  )
                )
              end
              attr_reader :type

              sig do
                params(
                  type:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::Type::OrSymbol
                ).void
              end
              attr_writer :type

              # The user who performed the audit logged action.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::User
                  )
                )
              end
              attr_reader :user

              sig do
                params(
                  user:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::User::OrHash
                ).void
              end
              attr_writer :user

              # The API Key used to perform the audit logged action.
              sig do
                params(
                  id: String,
                  service_account:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::ServiceAccount::OrHash,
                  type:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::Type::OrSymbol,
                  user:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::User::OrHash
                ).returns(T.attached_class)
              end
              def self.new(
                # The tracking id of the API key.
                id: nil,
                # The service account that performed the audit logged action.
                service_account: nil,
                # The type of API key. Can be either `user` or `service_account`.
                type: nil,
                # The user who performed the audit logged action.
                user: nil
              )
              end

              sig do
                override.returns(
                  {
                    id: String,
                    service_account:
                      OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::ServiceAccount,
                    type:
                      OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::Type::TaggedSymbol,
                    user:
                      OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::User
                  }
                )
              end
              def to_hash
              end

              class ServiceAccount < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::ServiceAccount,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The service account id.
                sig { returns(T.nilable(String)) }
                attr_reader :id

                sig { params(id: String).void }
                attr_writer :id

                # The service account that performed the audit logged action.
                sig { params(id: String).returns(T.attached_class) }
                def self.new(
                  # The service account id.
                  id: nil
                )
                end

                sig { override.returns({ id: String }) }
                def to_hash
                end
              end

              # The type of API key. Can be either `user` or `service_account`.
              module Type
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::Type
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                USER =
                  T.let(
                    :user,
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::Type::TaggedSymbol
                  )
                SERVICE_ACCOUNT =
                  T.let(
                    :service_account,
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::Type::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::Type::TaggedSymbol
                    ]
                  )
                end
                def self.values
                end
              end

              class User < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::User,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The user id.
                sig { returns(T.nilable(String)) }
                attr_reader :id

                sig { params(id: String).void }
                attr_writer :id

                # The user email.
                sig { returns(T.nilable(String)) }
                attr_reader :email

                sig { params(email: String).void }
                attr_writer :email

                # The user who performed the audit logged action.
                sig do
                  params(id: String, email: String).returns(T.attached_class)
                end
                def self.new(
                  # The user id.
                  id: nil,
                  # The user email.
                  email: nil
                )
                end

                sig { override.returns({ id: String, email: String }) }
                def to_hash
                end
              end
            end

            class Session < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The IP address from which the action was performed.
              sig { returns(T.nilable(String)) }
              attr_reader :ip_address

              sig { params(ip_address: String).void }
              attr_writer :ip_address

              # The user who performed the audit logged action.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session::User
                  )
                )
              end
              attr_reader :user

              sig do
                params(
                  user:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session::User::OrHash
                ).void
              end
              attr_writer :user

              # The session in which the audit logged action was performed.
              sig do
                params(
                  ip_address: String,
                  user:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session::User::OrHash
                ).returns(T.attached_class)
              end
              def self.new(
                # The IP address from which the action was performed.
                ip_address: nil,
                # The user who performed the audit logged action.
                user: nil
              )
              end

              sig do
                override.returns(
                  {
                    ip_address: String,
                    user:
                      OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session::User
                  }
                )
              end
              def to_hash
              end

              class User < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session::User,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The user id.
                sig { returns(T.nilable(String)) }
                attr_reader :id

                sig { params(id: String).void }
                attr_writer :id

                # The user email.
                sig { returns(T.nilable(String)) }
                attr_reader :email

                sig { params(email: String).void }
                attr_writer :email

                # The user who performed the audit logged action.
                sig do
                  params(id: String, email: String).returns(T.attached_class)
                end
                def self.new(
                  # The user id.
                  id: nil,
                  # The user email.
                  email: nil
                )
                end

                sig { override.returns({ id: String, email: String }) }
                def to_hash
                end
              end
            end

            # The type of actor. Is either `session` or `api_key`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Type
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              SESSION =
                T.let(
                  :session,
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Type::TaggedSymbol
                )
              API_KEY =
                T.let(
                  :api_key,
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Type::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end

          # The event type.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            API_KEY_CREATED =
              T.let(
                :"api_key.created",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            API_KEY_UPDATED =
              T.let(
                :"api_key.updated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            API_KEY_DELETED =
              T.let(
                :"api_key.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            CERTIFICATE_CREATED =
              T.let(
                :"certificate.created",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            CERTIFICATE_UPDATED =
              T.let(
                :"certificate.updated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            CERTIFICATE_DELETED =
              T.let(
                :"certificate.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            CERTIFICATES_ACTIVATED =
              T.let(
                :"certificates.activated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            CERTIFICATES_DEACTIVATED =
              T.let(
                :"certificates.deactivated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            CHECKPOINT_PERMISSION_CREATED =
              T.let(
                :"checkpoint.permission.created",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            CHECKPOINT_PERMISSION_DELETED =
              T.let(
                :"checkpoint.permission.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            EXTERNAL_KEY_REGISTERED =
              T.let(
                :"external_key.registered",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            EXTERNAL_KEY_REMOVED =
              T.let(
                :"external_key.removed",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            GROUP_CREATED =
              T.let(
                :"group.created",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            GROUP_UPDATED =
              T.let(
                :"group.updated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            GROUP_DELETED =
              T.let(
                :"group.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            INVITE_SENT =
              T.let(
                :"invite.sent",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            INVITE_ACCEPTED =
              T.let(
                :"invite.accepted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            INVITE_DELETED =
              T.let(
                :"invite.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            IP_ALLOWLIST_CREATED =
              T.let(
                :"ip_allowlist.created",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            IP_ALLOWLIST_UPDATED =
              T.let(
                :"ip_allowlist.updated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            IP_ALLOWLIST_DELETED =
              T.let(
                :"ip_allowlist.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            IP_ALLOWLIST_CONFIG_ACTIVATED =
              T.let(
                :"ip_allowlist.config.activated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            IP_ALLOWLIST_CONFIG_DEACTIVATED =
              T.let(
                :"ip_allowlist.config.deactivated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            LOGIN_SUCCEEDED =
              T.let(
                :"login.succeeded",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            LOGIN_FAILED =
              T.let(
                :"login.failed",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            LOGOUT_SUCCEEDED =
              T.let(
                :"logout.succeeded",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            LOGOUT_FAILED =
              T.let(
                :"logout.failed",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            ORGANIZATION_UPDATED =
              T.let(
                :"organization.updated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            PROJECT_CREATED =
              T.let(
                :"project.created",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            PROJECT_UPDATED =
              T.let(
                :"project.updated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            PROJECT_ARCHIVED =
              T.let(
                :"project.archived",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            PROJECT_DELETED =
              T.let(
                :"project.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            RATE_LIMIT_UPDATED =
              T.let(
                :"rate_limit.updated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            RATE_LIMIT_DELETED =
              T.let(
                :"rate_limit.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            RESOURCE_DELETED =
              T.let(
                :"resource.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            TUNNEL_CREATED =
              T.let(
                :"tunnel.created",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            TUNNEL_UPDATED =
              T.let(
                :"tunnel.updated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            TUNNEL_DELETED =
              T.let(
                :"tunnel.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            ROLE_CREATED =
              T.let(
                :"role.created",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            ROLE_UPDATED =
              T.let(
                :"role.updated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            ROLE_DELETED =
              T.let(
                :"role.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            ROLE_ASSIGNMENT_CREATED =
              T.let(
                :"role.assignment.created",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            ROLE_ASSIGNMENT_DELETED =
              T.let(
                :"role.assignment.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            SCIM_ENABLED =
              T.let(
                :"scim.enabled",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            SCIM_DISABLED =
              T.let(
                :"scim.disabled",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            SERVICE_ACCOUNT_CREATED =
              T.let(
                :"service_account.created",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            SERVICE_ACCOUNT_UPDATED =
              T.let(
                :"service_account.updated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            SERVICE_ACCOUNT_DELETED =
              T.let(
                :"service_account.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            USER_ADDED =
              T.let(
                :"user.added",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            USER_UPDATED =
              T.let(
                :"user.updated",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )
            USER_DELETED =
              T.let(
                :"user.deleted",
                OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class APIKeyCreated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The tracking ID of the API key.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to create the API key.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated::Data
                )
              )
            end
            attr_reader :data

            sig do
              params(
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated::Data::OrHash
              ).void
            end
            attr_writer :data

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated::Data::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The tracking ID of the API key.
              id: nil,
              # The payload used to create the API key.
              data: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  data:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated::Data
                }
              )
            end
            def to_hash
            end

            class Data < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated::Data,
                    OpenAI::Internal::AnyHash
                  )
                end

              # A list of scopes allowed for the API key, e.g. `["api.model.request"]`
              sig { returns(T.nilable(T::Array[String])) }
              attr_reader :scopes

              sig { params(scopes: T::Array[String]).void }
              attr_writer :scopes

              # The payload used to create the API key.
              sig { params(scopes: T::Array[String]).returns(T.attached_class) }
              def self.new(
                # A list of scopes allowed for the API key, e.g. `["api.model.request"]`
                scopes: nil
              )
              end

              sig { override.returns({ scopes: T::Array[String] }) }
              def to_hash
              end
            end
          end

          class APIKeyDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The tracking ID of the API key.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The tracking ID of the API key.
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class APIKeyUpdated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The tracking ID of the API key.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to update the API key.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated::ChangesRequested
                )
              )
            end
            attr_reader :changes_requested

            sig do
              params(
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated::ChangesRequested::OrHash
              ).void
            end
            attr_writer :changes_requested

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated::ChangesRequested::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The tracking ID of the API key.
              id: nil,
              # The payload used to update the API key.
              changes_requested: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  changes_requested:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated::ChangesRequested
                }
              )
            end
            def to_hash
            end

            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated::ChangesRequested,
                    OpenAI::Internal::AnyHash
                  )
                end

              # A list of scopes allowed for the API key, e.g. `["api.model.request"]`
              sig { returns(T.nilable(T::Array[String])) }
              attr_reader :scopes

              sig { params(scopes: T::Array[String]).void }
              attr_writer :scopes

              # The payload used to update the API key.
              sig { params(scopes: T::Array[String]).returns(T.attached_class) }
              def self.new(
                # A list of scopes allowed for the API key, e.g. `["api.model.request"]`
                scopes: nil
              )
              end

              sig { override.returns({ scopes: T::Array[String] }) }
              def to_hash
              end
            end
          end

          class CertificateCreated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateCreated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The certificate ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The name of the certificate.
            sig { returns(T.nilable(String)) }
            attr_reader :name

            sig { params(name: String).void }
            attr_writer :name

            # The details for events with this `type`.
            sig { params(id: String, name: String).returns(T.attached_class) }
            def self.new(
              # The certificate ID.
              id: nil,
              # The name of the certificate.
              name: nil
            )
            end

            sig { override.returns({ id: String, name: String }) }
            def to_hash
            end
          end

          class CertificateDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The certificate ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The certificate content in PEM format.
            sig { returns(T.nilable(String)) }
            attr_reader :certificate

            sig { params(certificate: String).void }
            attr_writer :certificate

            # The name of the certificate.
            sig { returns(T.nilable(String)) }
            attr_reader :name

            sig { params(name: String).void }
            attr_writer :name

            # The details for events with this `type`.
            sig do
              params(id: String, certificate: String, name: String).returns(
                T.attached_class
              )
            end
            def self.new(
              # The certificate ID.
              id: nil,
              # The certificate content in PEM format.
              certificate: nil,
              # The name of the certificate.
              name: nil
            )
            end

            sig do
              override.returns(
                { id: String, certificate: String, name: String }
              )
            end
            def to_hash
            end
          end

          class CertificateUpdated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateUpdated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The certificate ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The name of the certificate.
            sig { returns(T.nilable(String)) }
            attr_reader :name

            sig { params(name: String).void }
            attr_writer :name

            # The details for events with this `type`.
            sig { params(id: String, name: String).returns(T.attached_class) }
            def self.new(
              # The certificate ID.
              id: nil,
              # The name of the certificate.
              name: nil
            )
            end

            sig { override.returns({ id: String, name: String }) }
            def to_hash
            end
          end

          class CertificatesActivated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated,
                  OpenAI::Internal::AnyHash
                )
              end

            sig do
              returns(
                T.nilable(
                  T::Array[
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated::Certificate
                  ]
                )
              )
            end
            attr_reader :certificates

            sig do
              params(
                certificates:
                  T::Array[
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated::Certificate::OrHash
                  ]
              ).void
            end
            attr_writer :certificates

            # The details for events with this `type`.
            sig do
              params(
                certificates:
                  T::Array[
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated::Certificate::OrHash
                  ]
              ).returns(T.attached_class)
            end
            def self.new(certificates: nil)
            end

            sig do
              override.returns(
                {
                  certificates:
                    T::Array[
                      OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated::Certificate
                    ]
                }
              )
            end
            def to_hash
            end

            class Certificate < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated::Certificate,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The certificate ID.
              sig { returns(T.nilable(String)) }
              attr_reader :id

              sig { params(id: String).void }
              attr_writer :id

              # The name of the certificate.
              sig { returns(T.nilable(String)) }
              attr_reader :name

              sig { params(name: String).void }
              attr_writer :name

              sig { params(id: String, name: String).returns(T.attached_class) }
              def self.new(
                # The certificate ID.
                id: nil,
                # The name of the certificate.
                name: nil
              )
              end

              sig { override.returns({ id: String, name: String }) }
              def to_hash
              end
            end
          end

          class CertificatesDeactivated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated,
                  OpenAI::Internal::AnyHash
                )
              end

            sig do
              returns(
                T.nilable(
                  T::Array[
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated::Certificate
                  ]
                )
              )
            end
            attr_reader :certificates

            sig do
              params(
                certificates:
                  T::Array[
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated::Certificate::OrHash
                  ]
              ).void
            end
            attr_writer :certificates

            # The details for events with this `type`.
            sig do
              params(
                certificates:
                  T::Array[
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated::Certificate::OrHash
                  ]
              ).returns(T.attached_class)
            end
            def self.new(certificates: nil)
            end

            sig do
              override.returns(
                {
                  certificates:
                    T::Array[
                      OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated::Certificate
                    ]
                }
              )
            end
            def to_hash
            end

            class Certificate < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated::Certificate,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The certificate ID.
              sig { returns(T.nilable(String)) }
              attr_reader :id

              sig { params(id: String).void }
              attr_writer :id

              # The name of the certificate.
              sig { returns(T.nilable(String)) }
              attr_reader :name

              sig { params(name: String).void }
              attr_writer :name

              sig { params(id: String, name: String).returns(T.attached_class) }
              def self.new(
                # The certificate ID.
                id: nil,
                # The name of the certificate.
                name: nil
              )
              end

              sig { override.returns({ id: String, name: String }) }
              def to_hash
              end
            end
          end

          class CheckpointPermissionCreated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the checkpoint permission.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to create the checkpoint permission.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated::Data
                )
              )
            end
            attr_reader :data

            sig do
              params(
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated::Data::OrHash
              ).void
            end
            attr_writer :data

            # The project and fine-tuned model checkpoint that the checkpoint permission was
            # created for.
            sig do
              params(
                id: String,
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated::Data::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The ID of the checkpoint permission.
              id: nil,
              # The payload used to create the checkpoint permission.
              data: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  data:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated::Data
                }
              )
            end
            def to_hash
            end

            class Data < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated::Data,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The ID of the fine-tuned model checkpoint.
              sig { returns(T.nilable(String)) }
              attr_reader :fine_tuned_model_checkpoint

              sig { params(fine_tuned_model_checkpoint: String).void }
              attr_writer :fine_tuned_model_checkpoint

              # The ID of the project that the checkpoint permission was created for.
              sig { returns(T.nilable(String)) }
              attr_reader :project_id

              sig { params(project_id: String).void }
              attr_writer :project_id

              # The payload used to create the checkpoint permission.
              sig do
                params(
                  fine_tuned_model_checkpoint: String,
                  project_id: String
                ).returns(T.attached_class)
              end
              def self.new(
                # The ID of the fine-tuned model checkpoint.
                fine_tuned_model_checkpoint: nil,
                # The ID of the project that the checkpoint permission was created for.
                project_id: nil
              )
              end

              sig do
                override.returns(
                  { fine_tuned_model_checkpoint: String, project_id: String }
                )
              end
              def to_hash
              end
            end
          end

          class CheckpointPermissionDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the checkpoint permission.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The ID of the checkpoint permission.
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class ExternalKeyRegistered < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRegistered,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the external key configuration.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The configuration for the external key.
            sig { returns(T.nilable(T.anything)) }
            attr_reader :data

            sig { params(data: T.anything).void }
            attr_writer :data

            # The details for events with this `type`.
            sig do
              params(id: String, data: T.anything).returns(T.attached_class)
            end
            def self.new(
              # The ID of the external key configuration.
              id: nil,
              # The configuration for the external key.
              data: nil
            )
            end

            sig { override.returns({ id: String, data: T.anything }) }
            def to_hash
            end
          end

          class ExternalKeyRemoved < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRemoved,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the external key configuration.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The ID of the external key configuration.
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class GroupCreated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the group.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # Information about the created group.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated::Data
                )
              )
            end
            attr_reader :data

            sig do
              params(
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated::Data::OrHash
              ).void
            end
            attr_writer :data

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated::Data::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The ID of the group.
              id: nil,
              # Information about the created group.
              data: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  data:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated::Data
                }
              )
            end
            def to_hash
            end

            class Data < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated::Data,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The group name.
              sig { returns(T.nilable(String)) }
              attr_reader :group_name

              sig { params(group_name: String).void }
              attr_writer :group_name

              # Information about the created group.
              sig { params(group_name: String).returns(T.attached_class) }
              def self.new(
                # The group name.
                group_name: nil
              )
              end

              sig { override.returns({ group_name: String }) }
              def to_hash
              end
            end
          end

          class GroupDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the group.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The ID of the group.
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class GroupUpdated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the group.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to update the group.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated::ChangesRequested
                )
              )
            end
            attr_reader :changes_requested

            sig do
              params(
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated::ChangesRequested::OrHash
              ).void
            end
            attr_writer :changes_requested

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated::ChangesRequested::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The ID of the group.
              id: nil,
              # The payload used to update the group.
              changes_requested: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  changes_requested:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated::ChangesRequested
                }
              )
            end
            def to_hash
            end

            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated::ChangesRequested,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The updated group name.
              sig { returns(T.nilable(String)) }
              attr_reader :group_name

              sig { params(group_name: String).void }
              attr_writer :group_name

              # The payload used to update the group.
              sig { params(group_name: String).returns(T.attached_class) }
              def self.new(
                # The updated group name.
                group_name: nil
              )
              end

              sig { override.returns({ group_name: String }) }
              def to_hash
              end
            end
          end

          class InviteAccepted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteAccepted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the invite.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The ID of the invite.
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class InviteDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the invite.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The ID of the invite.
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class InviteSent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the invite.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to create the invite.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent::Data
                )
              )
            end
            attr_reader :data

            sig do
              params(
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent::Data::OrHash
              ).void
            end
            attr_writer :data

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent::Data::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The ID of the invite.
              id: nil,
              # The payload used to create the invite.
              data: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  data:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent::Data
                }
              )
            end
            def to_hash
            end

            class Data < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent::Data,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The email invited to the organization.
              sig { returns(T.nilable(String)) }
              attr_reader :email

              sig { params(email: String).void }
              attr_writer :email

              # The role the email was invited to be. Is either `owner` or `member`.
              sig { returns(T.nilable(String)) }
              attr_reader :role

              sig { params(role: String).void }
              attr_writer :role

              # The payload used to create the invite.
              sig do
                params(email: String, role: String).returns(T.attached_class)
              end
              def self.new(
                # The email invited to the organization.
                email: nil,
                # The role the email was invited to be. Is either `owner` or `member`.
                role: nil
              )
              end

              sig { override.returns({ email: String, role: String }) }
              def to_hash
              end
            end
          end

          class IPAllowlistConfigActivated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The configurations that were activated.
            sig do
              returns(
                T.nilable(
                  T::Array[
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated::Config
                  ]
                )
              )
            end
            attr_reader :configs

            sig do
              params(
                configs:
                  T::Array[
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated::Config::OrHash
                  ]
              ).void
            end
            attr_writer :configs

            # The details for events with this `type`.
            sig do
              params(
                configs:
                  T::Array[
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated::Config::OrHash
                  ]
              ).returns(T.attached_class)
            end
            def self.new(
              # The configurations that were activated.
              configs: nil
            )
            end

            sig do
              override.returns(
                {
                  configs:
                    T::Array[
                      OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated::Config
                    ]
                }
              )
            end
            def to_hash
            end

            class Config < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated::Config,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The ID of the IP allowlist configuration.
              sig { returns(T.nilable(String)) }
              attr_reader :id

              sig { params(id: String).void }
              attr_writer :id

              # The name of the IP allowlist configuration.
              sig { returns(T.nilable(String)) }
              attr_reader :name

              sig { params(name: String).void }
              attr_writer :name

              sig { params(id: String, name: String).returns(T.attached_class) }
              def self.new(
                # The ID of the IP allowlist configuration.
                id: nil,
                # The name of the IP allowlist configuration.
                name: nil
              )
              end

              sig { override.returns({ id: String, name: String }) }
              def to_hash
              end
            end
          end

          class IPAllowlistConfigDeactivated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The configurations that were deactivated.
            sig do
              returns(
                T.nilable(
                  T::Array[
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated::Config
                  ]
                )
              )
            end
            attr_reader :configs

            sig do
              params(
                configs:
                  T::Array[
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated::Config::OrHash
                  ]
              ).void
            end
            attr_writer :configs

            # The details for events with this `type`.
            sig do
              params(
                configs:
                  T::Array[
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated::Config::OrHash
                  ]
              ).returns(T.attached_class)
            end
            def self.new(
              # The configurations that were deactivated.
              configs: nil
            )
            end

            sig do
              override.returns(
                {
                  configs:
                    T::Array[
                      OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated::Config
                    ]
                }
              )
            end
            def to_hash
            end

            class Config < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated::Config,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The ID of the IP allowlist configuration.
              sig { returns(T.nilable(String)) }
              attr_reader :id

              sig { params(id: String).void }
              attr_writer :id

              # The name of the IP allowlist configuration.
              sig { returns(T.nilable(String)) }
              attr_reader :name

              sig { params(name: String).void }
              attr_writer :name

              sig { params(id: String, name: String).returns(T.attached_class) }
              def self.new(
                # The ID of the IP allowlist configuration.
                id: nil,
                # The name of the IP allowlist configuration.
                name: nil
              )
              end

              sig { override.returns({ id: String, name: String }) }
              def to_hash
              end
            end
          end

          class IPAllowlistCreated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistCreated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the IP allowlist configuration.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The IP addresses or CIDR ranges included in the configuration.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :allowed_ips

            sig { params(allowed_ips: T::Array[String]).void }
            attr_writer :allowed_ips

            # The name of the IP allowlist configuration.
            sig { returns(T.nilable(String)) }
            attr_reader :name

            sig { params(name: String).void }
            attr_writer :name

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                allowed_ips: T::Array[String],
                name: String
              ).returns(T.attached_class)
            end
            def self.new(
              # The ID of the IP allowlist configuration.
              id: nil,
              # The IP addresses or CIDR ranges included in the configuration.
              allowed_ips: nil,
              # The name of the IP allowlist configuration.
              name: nil
            )
            end

            sig do
              override.returns(
                { id: String, allowed_ips: T::Array[String], name: String }
              )
            end
            def to_hash
            end
          end

          class IPAllowlistDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the IP allowlist configuration.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The IP addresses or CIDR ranges that were in the configuration.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :allowed_ips

            sig { params(allowed_ips: T::Array[String]).void }
            attr_writer :allowed_ips

            # The name of the IP allowlist configuration.
            sig { returns(T.nilable(String)) }
            attr_reader :name

            sig { params(name: String).void }
            attr_writer :name

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                allowed_ips: T::Array[String],
                name: String
              ).returns(T.attached_class)
            end
            def self.new(
              # The ID of the IP allowlist configuration.
              id: nil,
              # The IP addresses or CIDR ranges that were in the configuration.
              allowed_ips: nil,
              # The name of the IP allowlist configuration.
              name: nil
            )
            end

            sig do
              override.returns(
                { id: String, allowed_ips: T::Array[String], name: String }
              )
            end
            def to_hash
            end
          end

          class IPAllowlistUpdated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistUpdated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the IP allowlist configuration.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The updated set of IP addresses or CIDR ranges in the configuration.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :allowed_ips

            sig { params(allowed_ips: T::Array[String]).void }
            attr_writer :allowed_ips

            # The details for events with this `type`.
            sig do
              params(id: String, allowed_ips: T::Array[String]).returns(
                T.attached_class
              )
            end
            def self.new(
              # The ID of the IP allowlist configuration.
              id: nil,
              # The updated set of IP addresses or CIDR ranges in the configuration.
              allowed_ips: nil
            )
            end

            sig do
              override.returns({ id: String, allowed_ips: T::Array[String] })
            end
            def to_hash
            end
          end

          class LoginFailed < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::LoginFailed,
                  OpenAI::Internal::AnyHash
                )
              end

            # The error code of the failure.
            sig { returns(T.nilable(String)) }
            attr_reader :error_code

            sig { params(error_code: String).void }
            attr_writer :error_code

            # The error message of the failure.
            sig { returns(T.nilable(String)) }
            attr_reader :error_message

            sig { params(error_message: String).void }
            attr_writer :error_message

            # The details for events with this `type`.
            sig do
              params(error_code: String, error_message: String).returns(
                T.attached_class
              )
            end
            def self.new(
              # The error code of the failure.
              error_code: nil,
              # The error message of the failure.
              error_message: nil
            )
            end

            sig do
              override.returns({ error_code: String, error_message: String })
            end
            def to_hash
            end
          end

          class LogoutFailed < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::LogoutFailed,
                  OpenAI::Internal::AnyHash
                )
              end

            # The error code of the failure.
            sig { returns(T.nilable(String)) }
            attr_reader :error_code

            sig { params(error_code: String).void }
            attr_writer :error_code

            # The error message of the failure.
            sig { returns(T.nilable(String)) }
            attr_reader :error_message

            sig { params(error_message: String).void }
            attr_writer :error_message

            # The details for events with this `type`.
            sig do
              params(error_code: String, error_message: String).returns(
                T.attached_class
              )
            end
            def self.new(
              # The error code of the failure.
              error_code: nil,
              # The error message of the failure.
              error_message: nil
            )
            end

            sig do
              override.returns({ error_code: String, error_message: String })
            end
            def to_hash
            end
          end

          class OrganizationUpdated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The organization ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to update the organization settings.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated::ChangesRequested
                )
              )
            end
            attr_reader :changes_requested

            sig do
              params(
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated::ChangesRequested::OrHash
              ).void
            end
            attr_writer :changes_requested

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated::ChangesRequested::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The organization ID.
              id: nil,
              # The payload used to update the organization settings.
              changes_requested: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  changes_requested:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated::ChangesRequested
                }
              )
            end
            def to_hash
            end

            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated::ChangesRequested,
                    OpenAI::Internal::AnyHash
                  )
                end

              # How your organization logs data from supported API calls. One of `disabled`,
              # `enabled_per_call`, `enabled_for_all_projects`, or
              # `enabled_for_selected_projects`
              sig { returns(T.nilable(String)) }
              attr_reader :api_call_logging

              sig { params(api_call_logging: String).void }
              attr_writer :api_call_logging

              # The list of project ids if api_call_logging is set to
              # `enabled_for_selected_projects`
              sig { returns(T.nilable(String)) }
              attr_reader :api_call_logging_project_ids

              sig { params(api_call_logging_project_ids: String).void }
              attr_writer :api_call_logging_project_ids

              # The organization description.
              sig { returns(T.nilable(String)) }
              attr_reader :description

              sig { params(description: String).void }
              attr_writer :description

              # The organization name.
              sig { returns(T.nilable(String)) }
              attr_reader :name

              sig { params(name: String).void }
              attr_writer :name

              # Visibility of the threads page which shows messages created with the Assistants
              # API and Playground. One of `ANY_ROLE`, `OWNERS`, or `NONE`.
              sig { returns(T.nilable(String)) }
              attr_reader :threads_ui_visibility

              sig { params(threads_ui_visibility: String).void }
              attr_writer :threads_ui_visibility

              # The organization title.
              sig { returns(T.nilable(String)) }
              attr_reader :title

              sig { params(title: String).void }
              attr_writer :title

              # Visibility of the usage dashboard which shows activity and costs for your
              # organization. One of `ANY_ROLE` or `OWNERS`.
              sig { returns(T.nilable(String)) }
              attr_reader :usage_dashboard_visibility

              sig { params(usage_dashboard_visibility: String).void }
              attr_writer :usage_dashboard_visibility

              # The payload used to update the organization settings.
              sig do
                params(
                  api_call_logging: String,
                  api_call_logging_project_ids: String,
                  description: String,
                  name: String,
                  threads_ui_visibility: String,
                  title: String,
                  usage_dashboard_visibility: String
                ).returns(T.attached_class)
              end
              def self.new(
                # How your organization logs data from supported API calls. One of `disabled`,
                # `enabled_per_call`, `enabled_for_all_projects`, or
                # `enabled_for_selected_projects`
                api_call_logging: nil,
                # The list of project ids if api_call_logging is set to
                # `enabled_for_selected_projects`
                api_call_logging_project_ids: nil,
                # The organization description.
                description: nil,
                # The organization name.
                name: nil,
                # Visibility of the threads page which shows messages created with the Assistants
                # API and Playground. One of `ANY_ROLE`, `OWNERS`, or `NONE`.
                threads_ui_visibility: nil,
                # The organization title.
                title: nil,
                # Visibility of the usage dashboard which shows activity and costs for your
                # organization. One of `ANY_ROLE` or `OWNERS`.
                usage_dashboard_visibility: nil
              )
              end

              sig do
                override.returns(
                  {
                    api_call_logging: String,
                    api_call_logging_project_ids: String,
                    description: String,
                    name: String,
                    threads_ui_visibility: String,
                    title: String,
                    usage_dashboard_visibility: String
                  }
                )
              end
              def to_hash
              end
            end
          end

          class Project < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::Project,
                  OpenAI::Internal::AnyHash
                )
              end

            # The project ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The project title.
            sig { returns(T.nilable(String)) }
            attr_reader :name

            sig { params(name: String).void }
            attr_writer :name

            # The project that the action was scoped to. Absent for actions not scoped to
            # projects. Note that any admin actions taken via Admin API keys are associated
            # with the default project.
            sig { params(id: String, name: String).returns(T.attached_class) }
            def self.new(
              # The project ID.
              id: nil,
              # The project title.
              name: nil
            )
            end

            sig { override.returns({ id: String, name: String }) }
            def to_hash
            end
          end

          class ProjectArchived < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectArchived,
                  OpenAI::Internal::AnyHash
                )
              end

            # The project ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The project ID.
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class ProjectCreated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The project ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to create the project.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated::Data
                )
              )
            end
            attr_reader :data

            sig do
              params(
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated::Data::OrHash
              ).void
            end
            attr_writer :data

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated::Data::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The project ID.
              id: nil,
              # The payload used to create the project.
              data: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  data:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated::Data
                }
              )
            end
            def to_hash
            end

            class Data < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated::Data,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The project name.
              sig { returns(T.nilable(String)) }
              attr_reader :name

              sig { params(name: String).void }
              attr_writer :name

              # The title of the project as seen on the dashboard.
              sig { returns(T.nilable(String)) }
              attr_reader :title

              sig { params(title: String).void }
              attr_writer :title

              # The payload used to create the project.
              sig do
                params(name: String, title: String).returns(T.attached_class)
              end
              def self.new(
                # The project name.
                name: nil,
                # The title of the project as seen on the dashboard.
                title: nil
              )
              end

              sig { override.returns({ name: String, title: String }) }
              def to_hash
              end
            end
          end

          class ProjectDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The project ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The project ID.
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class ProjectUpdated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The project ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to update the project.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated::ChangesRequested
                )
              )
            end
            attr_reader :changes_requested

            sig do
              params(
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated::ChangesRequested::OrHash
              ).void
            end
            attr_writer :changes_requested

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated::ChangesRequested::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The project ID.
              id: nil,
              # The payload used to update the project.
              changes_requested: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  changes_requested:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated::ChangesRequested
                }
              )
            end
            def to_hash
            end

            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated::ChangesRequested,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The title of the project as seen on the dashboard.
              sig { returns(T.nilable(String)) }
              attr_reader :title

              sig { params(title: String).void }
              attr_writer :title

              # The payload used to update the project.
              sig { params(title: String).returns(T.attached_class) }
              def self.new(
                # The title of the project as seen on the dashboard.
                title: nil
              )
              end

              sig { override.returns({ title: String }) }
              def to_hash
              end
            end
          end

          class RateLimitDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The rate limit ID
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The rate limit ID
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class RateLimitUpdated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The rate limit ID
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to update the rate limits.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated::ChangesRequested
                )
              )
            end
            attr_reader :changes_requested

            sig do
              params(
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated::ChangesRequested::OrHash
              ).void
            end
            attr_writer :changes_requested

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated::ChangesRequested::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The rate limit ID
              id: nil,
              # The payload used to update the rate limits.
              changes_requested: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  changes_requested:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated::ChangesRequested
                }
              )
            end
            def to_hash
            end

            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated::ChangesRequested,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The maximum batch input tokens per day. Only relevant for certain models.
              sig { returns(T.nilable(Integer)) }
              attr_reader :batch_1_day_max_input_tokens

              sig { params(batch_1_day_max_input_tokens: Integer).void }
              attr_writer :batch_1_day_max_input_tokens

              # The maximum audio megabytes per minute. Only relevant for certain models.
              sig { returns(T.nilable(Integer)) }
              attr_reader :max_audio_megabytes_per_1_minute

              sig { params(max_audio_megabytes_per_1_minute: Integer).void }
              attr_writer :max_audio_megabytes_per_1_minute

              # The maximum images per minute. Only relevant for certain models.
              sig { returns(T.nilable(Integer)) }
              attr_reader :max_images_per_1_minute

              sig { params(max_images_per_1_minute: Integer).void }
              attr_writer :max_images_per_1_minute

              # The maximum requests per day. Only relevant for certain models.
              sig { returns(T.nilable(Integer)) }
              attr_reader :max_requests_per_1_day

              sig { params(max_requests_per_1_day: Integer).void }
              attr_writer :max_requests_per_1_day

              # The maximum requests per minute.
              sig { returns(T.nilable(Integer)) }
              attr_reader :max_requests_per_1_minute

              sig { params(max_requests_per_1_minute: Integer).void }
              attr_writer :max_requests_per_1_minute

              # The maximum tokens per minute.
              sig { returns(T.nilable(Integer)) }
              attr_reader :max_tokens_per_1_minute

              sig { params(max_tokens_per_1_minute: Integer).void }
              attr_writer :max_tokens_per_1_minute

              # The payload used to update the rate limits.
              sig do
                params(
                  batch_1_day_max_input_tokens: Integer,
                  max_audio_megabytes_per_1_minute: Integer,
                  max_images_per_1_minute: Integer,
                  max_requests_per_1_day: Integer,
                  max_requests_per_1_minute: Integer,
                  max_tokens_per_1_minute: Integer
                ).returns(T.attached_class)
              end
              def self.new(
                # The maximum batch input tokens per day. Only relevant for certain models.
                batch_1_day_max_input_tokens: nil,
                # The maximum audio megabytes per minute. Only relevant for certain models.
                max_audio_megabytes_per_1_minute: nil,
                # The maximum images per minute. Only relevant for certain models.
                max_images_per_1_minute: nil,
                # The maximum requests per day. Only relevant for certain models.
                max_requests_per_1_day: nil,
                # The maximum requests per minute.
                max_requests_per_1_minute: nil,
                # The maximum tokens per minute.
                max_tokens_per_1_minute: nil
              )
              end

              sig do
                override.returns(
                  {
                    batch_1_day_max_input_tokens: Integer,
                    max_audio_megabytes_per_1_minute: Integer,
                    max_images_per_1_minute: Integer,
                    max_requests_per_1_day: Integer,
                    max_requests_per_1_minute: Integer,
                    max_tokens_per_1_minute: Integer
                  }
                )
              end
              def to_hash
              end
            end
          end

          class RoleAssignmentCreated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentCreated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The identifier of the role assignment.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The principal (user or group) that received the role.
            sig { returns(T.nilable(String)) }
            attr_reader :principal_id

            sig { params(principal_id: String).void }
            attr_writer :principal_id

            # The type of principal (user or group) that received the role.
            sig { returns(T.nilable(String)) }
            attr_reader :principal_type

            sig { params(principal_type: String).void }
            attr_writer :principal_type

            # The resource the role assignment is scoped to.
            sig { returns(T.nilable(String)) }
            attr_reader :resource_id

            sig { params(resource_id: String).void }
            attr_writer :resource_id

            # The type of resource the role assignment is scoped to.
            sig { returns(T.nilable(String)) }
            attr_reader :resource_type

            sig { params(resource_type: String).void }
            attr_writer :resource_type

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                principal_id: String,
                principal_type: String,
                resource_id: String,
                resource_type: String
              ).returns(T.attached_class)
            end
            def self.new(
              # The identifier of the role assignment.
              id: nil,
              # The principal (user or group) that received the role.
              principal_id: nil,
              # The type of principal (user or group) that received the role.
              principal_type: nil,
              # The resource the role assignment is scoped to.
              resource_id: nil,
              # The type of resource the role assignment is scoped to.
              resource_type: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  principal_id: String,
                  principal_type: String,
                  resource_id: String,
                  resource_type: String
                }
              )
            end
            def to_hash
            end
          end

          class RoleAssignmentDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The identifier of the role assignment.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The principal (user or group) that had the role removed.
            sig { returns(T.nilable(String)) }
            attr_reader :principal_id

            sig { params(principal_id: String).void }
            attr_writer :principal_id

            # The type of principal (user or group) that had the role removed.
            sig { returns(T.nilable(String)) }
            attr_reader :principal_type

            sig { params(principal_type: String).void }
            attr_writer :principal_type

            # The resource the role assignment was scoped to.
            sig { returns(T.nilable(String)) }
            attr_reader :resource_id

            sig { params(resource_id: String).void }
            attr_writer :resource_id

            # The type of resource the role assignment was scoped to.
            sig { returns(T.nilable(String)) }
            attr_reader :resource_type

            sig { params(resource_type: String).void }
            attr_writer :resource_type

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                principal_id: String,
                principal_type: String,
                resource_id: String,
                resource_type: String
              ).returns(T.attached_class)
            end
            def self.new(
              # The identifier of the role assignment.
              id: nil,
              # The principal (user or group) that had the role removed.
              principal_id: nil,
              # The type of principal (user or group) that had the role removed.
              principal_type: nil,
              # The resource the role assignment was scoped to.
              resource_id: nil,
              # The type of resource the role assignment was scoped to.
              resource_type: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  principal_id: String,
                  principal_type: String,
                  resource_id: String,
                  resource_type: String
                }
              )
            end
            def to_hash
            end
          end

          class RoleCreated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleCreated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The role ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The permissions granted by the role.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :permissions

            sig { params(permissions: T::Array[String]).void }
            attr_writer :permissions

            # The resource the role is scoped to.
            sig { returns(T.nilable(String)) }
            attr_reader :resource_id

            sig { params(resource_id: String).void }
            attr_writer :resource_id

            # The type of resource the role belongs to.
            sig { returns(T.nilable(String)) }
            attr_reader :resource_type

            sig { params(resource_type: String).void }
            attr_writer :resource_type

            # The name of the role.
            sig { returns(T.nilable(String)) }
            attr_reader :role_name

            sig { params(role_name: String).void }
            attr_writer :role_name

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                permissions: T::Array[String],
                resource_id: String,
                resource_type: String,
                role_name: String
              ).returns(T.attached_class)
            end
            def self.new(
              # The role ID.
              id: nil,
              # The permissions granted by the role.
              permissions: nil,
              # The resource the role is scoped to.
              resource_id: nil,
              # The type of resource the role belongs to.
              resource_type: nil,
              # The name of the role.
              role_name: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  permissions: T::Array[String],
                  resource_id: String,
                  resource_type: String,
                  role_name: String
                }
              )
            end
            def to_hash
            end
          end

          class RoleDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The role ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The role ID.
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class RoleUpdated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The role ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to update the role.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated::ChangesRequested
                )
              )
            end
            attr_reader :changes_requested

            sig do
              params(
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated::ChangesRequested::OrHash
              ).void
            end
            attr_writer :changes_requested

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated::ChangesRequested::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The role ID.
              id: nil,
              # The payload used to update the role.
              changes_requested: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  changes_requested:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated::ChangesRequested
                }
              )
            end
            def to_hash
            end

            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated::ChangesRequested,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The updated role description, when provided.
              sig { returns(T.nilable(String)) }
              attr_reader :description

              sig { params(description: String).void }
              attr_writer :description

              # Additional metadata stored on the role.
              sig { returns(T.nilable(T.anything)) }
              attr_reader :metadata

              sig { params(metadata: T.anything).void }
              attr_writer :metadata

              # The permissions added to the role.
              sig { returns(T.nilable(T::Array[String])) }
              attr_reader :permissions_added

              sig { params(permissions_added: T::Array[String]).void }
              attr_writer :permissions_added

              # The permissions removed from the role.
              sig { returns(T.nilable(T::Array[String])) }
              attr_reader :permissions_removed

              sig { params(permissions_removed: T::Array[String]).void }
              attr_writer :permissions_removed

              # The resource the role is scoped to.
              sig { returns(T.nilable(String)) }
              attr_reader :resource_id

              sig { params(resource_id: String).void }
              attr_writer :resource_id

              # The type of resource the role belongs to.
              sig { returns(T.nilable(String)) }
              attr_reader :resource_type

              sig { params(resource_type: String).void }
              attr_writer :resource_type

              # The updated role name, when provided.
              sig { returns(T.nilable(String)) }
              attr_reader :role_name

              sig { params(role_name: String).void }
              attr_writer :role_name

              # The payload used to update the role.
              sig do
                params(
                  description: String,
                  metadata: T.anything,
                  permissions_added: T::Array[String],
                  permissions_removed: T::Array[String],
                  resource_id: String,
                  resource_type: String,
                  role_name: String
                ).returns(T.attached_class)
              end
              def self.new(
                # The updated role description, when provided.
                description: nil,
                # Additional metadata stored on the role.
                metadata: nil,
                # The permissions added to the role.
                permissions_added: nil,
                # The permissions removed from the role.
                permissions_removed: nil,
                # The resource the role is scoped to.
                resource_id: nil,
                # The type of resource the role belongs to.
                resource_type: nil,
                # The updated role name, when provided.
                role_name: nil
              )
              end

              sig do
                override.returns(
                  {
                    description: String,
                    metadata: T.anything,
                    permissions_added: T::Array[String],
                    permissions_removed: T::Array[String],
                    resource_id: String,
                    resource_type: String,
                    role_name: String
                  }
                )
              end
              def to_hash
              end
            end
          end

          class ScimDisabled < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimDisabled,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the SCIM was disabled for.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The ID of the SCIM was disabled for.
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class ScimEnabled < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimEnabled,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the SCIM was enabled for.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The ID of the SCIM was enabled for.
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class ServiceAccountCreated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The service account ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to create the service account.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated::Data
                )
              )
            end
            attr_reader :data

            sig do
              params(
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated::Data::OrHash
              ).void
            end
            attr_writer :data

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated::Data::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The service account ID.
              id: nil,
              # The payload used to create the service account.
              data: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  data:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated::Data
                }
              )
            end
            def to_hash
            end

            class Data < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated::Data,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The role of the service account. Is either `owner` or `member`.
              sig { returns(T.nilable(String)) }
              attr_reader :role

              sig { params(role: String).void }
              attr_writer :role

              # The payload used to create the service account.
              sig { params(role: String).returns(T.attached_class) }
              def self.new(
                # The role of the service account. Is either `owner` or `member`.
                role: nil
              )
              end

              sig { override.returns({ role: String }) }
              def to_hash
              end
            end
          end

          class ServiceAccountDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The service account ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The service account ID.
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class ServiceAccountUpdated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The service account ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to updated the service account.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated::ChangesRequested
                )
              )
            end
            attr_reader :changes_requested

            sig do
              params(
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated::ChangesRequested::OrHash
              ).void
            end
            attr_writer :changes_requested

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated::ChangesRequested::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The service account ID.
              id: nil,
              # The payload used to updated the service account.
              changes_requested: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  changes_requested:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated::ChangesRequested
                }
              )
            end
            def to_hash
            end

            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated::ChangesRequested,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The role of the service account. Is either `owner` or `member`.
              sig { returns(T.nilable(String)) }
              attr_reader :role

              sig { params(role: String).void }
              attr_writer :role

              # The payload used to updated the service account.
              sig { params(role: String).returns(T.attached_class) }
              def self.new(
                # The role of the service account. Is either `owner` or `member`.
                role: nil
              )
              end

              sig { override.returns({ role: String }) }
              def to_hash
              end
            end
          end

          class UserAdded < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded,
                  OpenAI::Internal::AnyHash
                )
              end

            # The user ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to add the user to the project.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded::Data
                )
              )
            end
            attr_reader :data

            sig do
              params(
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded::Data::OrHash
              ).void
            end
            attr_writer :data

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                data:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded::Data::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The user ID.
              id: nil,
              # The payload used to add the user to the project.
              data: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  data:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded::Data
                }
              )
            end
            def to_hash
            end

            class Data < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded::Data,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The role of the user. Is either `owner` or `member`.
              sig { returns(T.nilable(String)) }
              attr_reader :role

              sig { params(role: String).void }
              attr_writer :role

              # The payload used to add the user to the project.
              sig { params(role: String).returns(T.attached_class) }
              def self.new(
                # The role of the user. Is either `owner` or `member`.
                role: nil
              )
              end

              sig { override.returns({ role: String }) }
              def to_hash
              end
            end
          end

          class UserDeleted < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::UserDeleted,
                  OpenAI::Internal::AnyHash
                )
              end

            # The user ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The details for events with this `type`.
            sig { params(id: String).returns(T.attached_class) }
            def self.new(
              # The user ID.
              id: nil
            )
            end

            sig { override.returns({ id: String }) }
            def to_hash
            end
          end

          class UserUpdated < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated,
                  OpenAI::Internal::AnyHash
                )
              end

            # The project ID.
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The payload used to update the user.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated::ChangesRequested
                )
              )
            end
            attr_reader :changes_requested

            sig do
              params(
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated::ChangesRequested::OrHash
              ).void
            end
            attr_writer :changes_requested

            # The details for events with this `type`.
            sig do
              params(
                id: String,
                changes_requested:
                  OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated::ChangesRequested::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # The project ID.
              id: nil,
              # The payload used to update the user.
              changes_requested: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  changes_requested:
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated::ChangesRequested
                }
              )
            end
            def to_hash
            end

            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated::ChangesRequested,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The role of the user. Is either `owner` or `member`.
              sig { returns(T.nilable(String)) }
              attr_reader :role

              sig { params(role: String).void }
              attr_writer :role

              # The payload used to update the user.
              sig { params(role: String).returns(T.attached_class) }
              def self.new(
                # The role of the user. Is either `owner` or `member`.
                role: nil
              )
              end

              sig { override.returns({ role: String }) }
              def to_hash
              end
            end
          end
        end
      end
    end
  end
end
