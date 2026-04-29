# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::AuditLogs#list
        class AuditLogListResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of this log.
          #
          #   @return [String]
          required :id, String

          # @!attribute actor
          #   The actor who performed the audit logged action.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor]
          required :actor, -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor }

          # @!attribute effective_at
          #   The Unix timestamp (in seconds) of the event.
          #
          #   @return [Integer]
          required :effective_at, Integer

          # @!attribute type
          #   The event type.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::AuditLogListResponse::Type]
          required :type, enum: -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::Type }

          # @!attribute api_key_created
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated, nil]
          optional :api_key_created,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated },
                   api_name: :"api_key.created"

          # @!attribute api_key_deleted
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyDeleted, nil]
          optional :api_key_deleted,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyDeleted },
                   api_name: :"api_key.deleted"

          # @!attribute api_key_updated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated, nil]
          optional :api_key_updated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated },
                   api_name: :"api_key.updated"

          # @!attribute certificate_created
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateCreated, nil]
          optional :certificate_created,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateCreated },
                   api_name: :"certificate.created"

          # @!attribute certificate_deleted
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateDeleted, nil]
          optional :certificate_deleted,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateDeleted },
                   api_name: :"certificate.deleted"

          # @!attribute certificate_updated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateUpdated, nil]
          optional :certificate_updated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateUpdated },
                   api_name: :"certificate.updated"

          # @!attribute certificates_activated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated, nil]
          optional :certificates_activated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated },
                   api_name: :"certificates.activated"

          # @!attribute certificates_deactivated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated, nil]
          optional :certificates_deactivated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated },
                   api_name: :"certificates.deactivated"

          # @!attribute checkpoint_permission_created
          #   The project and fine-tuned model checkpoint that the checkpoint permission was
          #   created for.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated, nil]
          optional :checkpoint_permission_created,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated },
                   api_name: :"checkpoint.permission.created"

          # @!attribute checkpoint_permission_deleted
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionDeleted, nil]
          optional :checkpoint_permission_deleted,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionDeleted },
                   api_name: :"checkpoint.permission.deleted"

          # @!attribute external_key_registered
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRegistered, nil]
          optional :external_key_registered,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRegistered },
                   api_name: :"external_key.registered"

          # @!attribute external_key_removed
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRemoved, nil]
          optional :external_key_removed,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRemoved },
                   api_name: :"external_key.removed"

          # @!attribute group_created
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated, nil]
          optional :group_created,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated },
                   api_name: :"group.created"

          # @!attribute group_deleted
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupDeleted, nil]
          optional :group_deleted,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupDeleted },
                   api_name: :"group.deleted"

          # @!attribute group_updated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated, nil]
          optional :group_updated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated },
                   api_name: :"group.updated"

          # @!attribute invite_accepted
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteAccepted, nil]
          optional :invite_accepted,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteAccepted },
                   api_name: :"invite.accepted"

          # @!attribute invite_deleted
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteDeleted, nil]
          optional :invite_deleted,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteDeleted },
                   api_name: :"invite.deleted"

          # @!attribute invite_sent
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent, nil]
          optional :invite_sent,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent },
                   api_name: :"invite.sent"

          # @!attribute ip_allowlist_config_activated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated, nil]
          optional :ip_allowlist_config_activated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated },
                   api_name: :"ip_allowlist.config.activated"

          # @!attribute ip_allowlist_config_deactivated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated, nil]
          optional :ip_allowlist_config_deactivated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated },
                   api_name: :"ip_allowlist.config.deactivated"

          # @!attribute ip_allowlist_created
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistCreated, nil]
          optional :ip_allowlist_created,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistCreated },
                   api_name: :"ip_allowlist.created"

          # @!attribute ip_allowlist_deleted
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistDeleted, nil]
          optional :ip_allowlist_deleted,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistDeleted },
                   api_name: :"ip_allowlist.deleted"

          # @!attribute ip_allowlist_updated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistUpdated, nil]
          optional :ip_allowlist_updated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistUpdated },
                   api_name: :"ip_allowlist.updated"

          # @!attribute login_failed
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::LoginFailed, nil]
          optional :login_failed,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::LoginFailed },
                   api_name: :"login.failed"

          # @!attribute login_succeeded
          #   This event has no additional fields beyond the standard audit log attributes.
          #
          #   @return [Object, nil]
          optional :login_succeeded, OpenAI::Internal::Type::Unknown, api_name: :"login.succeeded"

          # @!attribute logout_failed
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::LogoutFailed, nil]
          optional :logout_failed,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::LogoutFailed },
                   api_name: :"logout.failed"

          # @!attribute logout_succeeded
          #   This event has no additional fields beyond the standard audit log attributes.
          #
          #   @return [Object, nil]
          optional :logout_succeeded, OpenAI::Internal::Type::Unknown, api_name: :"logout.succeeded"

          # @!attribute organization_updated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated, nil]
          optional :organization_updated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated },
                   api_name: :"organization.updated"

          # @!attribute project
          #   The project that the action was scoped to. Absent for actions not scoped to
          #   projects. Note that any admin actions taken via Admin API keys are associated
          #   with the default project.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::Project, nil]
          optional :project, -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::Project }

          # @!attribute project_archived
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectArchived, nil]
          optional :project_archived,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectArchived },
                   api_name: :"project.archived"

          # @!attribute project_created
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated, nil]
          optional :project_created,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated },
                   api_name: :"project.created"

          # @!attribute project_deleted
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectDeleted, nil]
          optional :project_deleted,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectDeleted },
                   api_name: :"project.deleted"

          # @!attribute project_updated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated, nil]
          optional :project_updated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated },
                   api_name: :"project.updated"

          # @!attribute rate_limit_deleted
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitDeleted, nil]
          optional :rate_limit_deleted,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitDeleted },
                   api_name: :"rate_limit.deleted"

          # @!attribute rate_limit_updated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated, nil]
          optional :rate_limit_updated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated },
                   api_name: :"rate_limit.updated"

          # @!attribute role_assignment_created
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentCreated, nil]
          optional :role_assignment_created,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentCreated },
                   api_name: :"role.assignment.created"

          # @!attribute role_assignment_deleted
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentDeleted, nil]
          optional :role_assignment_deleted,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentDeleted },
                   api_name: :"role.assignment.deleted"

          # @!attribute role_created
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleCreated, nil]
          optional :role_created,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleCreated },
                   api_name: :"role.created"

          # @!attribute role_deleted
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleDeleted, nil]
          optional :role_deleted,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleDeleted },
                   api_name: :"role.deleted"

          # @!attribute role_updated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated, nil]
          optional :role_updated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated },
                   api_name: :"role.updated"

          # @!attribute scim_disabled
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimDisabled, nil]
          optional :scim_disabled,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimDisabled },
                   api_name: :"scim.disabled"

          # @!attribute scim_enabled
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimEnabled, nil]
          optional :scim_enabled,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimEnabled },
                   api_name: :"scim.enabled"

          # @!attribute service_account_created
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated, nil]
          optional :service_account_created,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated },
                   api_name: :"service_account.created"

          # @!attribute service_account_deleted
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountDeleted, nil]
          optional :service_account_deleted,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountDeleted },
                   api_name: :"service_account.deleted"

          # @!attribute service_account_updated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated, nil]
          optional :service_account_updated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated },
                   api_name: :"service_account.updated"

          # @!attribute user_added
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded, nil]
          optional :user_added,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded },
                   api_name: :"user.added"

          # @!attribute user_deleted
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::UserDeleted, nil]
          optional :user_deleted,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::UserDeleted },
                   api_name: :"user.deleted"

          # @!attribute user_updated
          #   The details for events with this `type`.
          #
          #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated, nil]
          optional :user_updated,
                   -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated },
                   api_name: :"user.updated"

          # @!method initialize(id:, actor:, effective_at:, type:, api_key_created: nil, api_key_deleted: nil, api_key_updated: nil, certificate_created: nil, certificate_deleted: nil, certificate_updated: nil, certificates_activated: nil, certificates_deactivated: nil, checkpoint_permission_created: nil, checkpoint_permission_deleted: nil, external_key_registered: nil, external_key_removed: nil, group_created: nil, group_deleted: nil, group_updated: nil, invite_accepted: nil, invite_deleted: nil, invite_sent: nil, ip_allowlist_config_activated: nil, ip_allowlist_config_deactivated: nil, ip_allowlist_created: nil, ip_allowlist_deleted: nil, ip_allowlist_updated: nil, login_failed: nil, login_succeeded: nil, logout_failed: nil, logout_succeeded: nil, organization_updated: nil, project: nil, project_archived: nil, project_created: nil, project_deleted: nil, project_updated: nil, rate_limit_deleted: nil, rate_limit_updated: nil, role_assignment_created: nil, role_assignment_deleted: nil, role_created: nil, role_deleted: nil, role_updated: nil, scim_disabled: nil, scim_enabled: nil, service_account_created: nil, service_account_deleted: nil, service_account_updated: nil, user_added: nil, user_deleted: nil, user_updated: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::AuditLogListResponse} for more details.
          #
          #   A log of a user action or configuration change within this organization.
          #
          #   @param id [String] The ID of this log.
          #
          #   @param actor [OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor] The actor who performed the audit logged action.
          #
          #   @param effective_at [Integer] The Unix timestamp (in seconds) of the event.
          #
          #   @param type [Symbol, OpenAI::Models::Admin::Organization::AuditLogListResponse::Type] The event type.
          #
          #   @param api_key_created [OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated] The details for events with this `type`.
          #
          #   @param api_key_deleted [OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyDeleted] The details for events with this `type`.
          #
          #   @param api_key_updated [OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated] The details for events with this `type`.
          #
          #   @param certificate_created [OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateCreated] The details for events with this `type`.
          #
          #   @param certificate_deleted [OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateDeleted] The details for events with this `type`.
          #
          #   @param certificate_updated [OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateUpdated] The details for events with this `type`.
          #
          #   @param certificates_activated [OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated] The details for events with this `type`.
          #
          #   @param certificates_deactivated [OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated] The details for events with this `type`.
          #
          #   @param checkpoint_permission_created [OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated] The project and fine-tuned model checkpoint that the checkpoint permission was c
          #
          #   @param checkpoint_permission_deleted [OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionDeleted] The details for events with this `type`.
          #
          #   @param external_key_registered [OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRegistered] The details for events with this `type`.
          #
          #   @param external_key_removed [OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRemoved] The details for events with this `type`.
          #
          #   @param group_created [OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated] The details for events with this `type`.
          #
          #   @param group_deleted [OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupDeleted] The details for events with this `type`.
          #
          #   @param group_updated [OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated] The details for events with this `type`.
          #
          #   @param invite_accepted [OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteAccepted] The details for events with this `type`.
          #
          #   @param invite_deleted [OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteDeleted] The details for events with this `type`.
          #
          #   @param invite_sent [OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent] The details for events with this `type`.
          #
          #   @param ip_allowlist_config_activated [OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated] The details for events with this `type`.
          #
          #   @param ip_allowlist_config_deactivated [OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated] The details for events with this `type`.
          #
          #   @param ip_allowlist_created [OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistCreated] The details for events with this `type`.
          #
          #   @param ip_allowlist_deleted [OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistDeleted] The details for events with this `type`.
          #
          #   @param ip_allowlist_updated [OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistUpdated] The details for events with this `type`.
          #
          #   @param login_failed [OpenAI::Models::Admin::Organization::AuditLogListResponse::LoginFailed] The details for events with this `type`.
          #
          #   @param login_succeeded [Object] This event has no additional fields beyond the standard audit log attributes.
          #
          #   @param logout_failed [OpenAI::Models::Admin::Organization::AuditLogListResponse::LogoutFailed] The details for events with this `type`.
          #
          #   @param logout_succeeded [Object] This event has no additional fields beyond the standard audit log attributes.
          #
          #   @param organization_updated [OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated] The details for events with this `type`.
          #
          #   @param project [OpenAI::Models::Admin::Organization::AuditLogListResponse::Project] The project that the action was scoped to. Absent for actions not scoped to proj
          #
          #   @param project_archived [OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectArchived] The details for events with this `type`.
          #
          #   @param project_created [OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated] The details for events with this `type`.
          #
          #   @param project_deleted [OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectDeleted] The details for events with this `type`.
          #
          #   @param project_updated [OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated] The details for events with this `type`.
          #
          #   @param rate_limit_deleted [OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitDeleted] The details for events with this `type`.
          #
          #   @param rate_limit_updated [OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated] The details for events with this `type`.
          #
          #   @param role_assignment_created [OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentCreated] The details for events with this `type`.
          #
          #   @param role_assignment_deleted [OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentDeleted] The details for events with this `type`.
          #
          #   @param role_created [OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleCreated] The details for events with this `type`.
          #
          #   @param role_deleted [OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleDeleted] The details for events with this `type`.
          #
          #   @param role_updated [OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated] The details for events with this `type`.
          #
          #   @param scim_disabled [OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimDisabled] The details for events with this `type`.
          #
          #   @param scim_enabled [OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimEnabled] The details for events with this `type`.
          #
          #   @param service_account_created [OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated] The details for events with this `type`.
          #
          #   @param service_account_deleted [OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountDeleted] The details for events with this `type`.
          #
          #   @param service_account_updated [OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated] The details for events with this `type`.
          #
          #   @param user_added [OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded] The details for events with this `type`.
          #
          #   @param user_deleted [OpenAI::Models::Admin::Organization::AuditLogListResponse::UserDeleted] The details for events with this `type`.
          #
          #   @param user_updated [OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated] The details for events with this `type`.

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#actor
          class Actor < OpenAI::Internal::Type::BaseModel
            # @!attribute api_key
            #   The API Key used to perform the audit logged action.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey, nil]
            optional :api_key, -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey }

            # @!attribute session
            #   The session in which the audit logged action was performed.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session, nil]
            optional :session, -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session }

            # @!attribute type
            #   The type of actor. Is either `session` or `api_key`.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Type, nil]
            optional :type, enum: -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Type }

            # @!method initialize(api_key: nil, session: nil, type: nil)
            #   The actor who performed the audit logged action.
            #
            #   @param api_key [OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey] The API Key used to perform the audit logged action.
            #
            #   @param session [OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session] The session in which the audit logged action was performed.
            #
            #   @param type [Symbol, OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Type] The type of actor. Is either `session` or `api_key`.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor#api_key
            class APIKey < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   The tracking id of the API key.
              #
              #   @return [String, nil]
              optional :id, String

              # @!attribute service_account
              #   The service account that performed the audit logged action.
              #
              #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::ServiceAccount, nil]
              optional :service_account,
                       -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::ServiceAccount }

              # @!attribute type
              #   The type of API key. Can be either `user` or `service_account`.
              #
              #   @return [Symbol, OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::Type, nil]
              optional :type,
                       enum: -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::Type }

              # @!attribute user
              #   The user who performed the audit logged action.
              #
              #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::User, nil]
              optional :user, -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::User }

              # @!method initialize(id: nil, service_account: nil, type: nil, user: nil)
              #   The API Key used to perform the audit logged action.
              #
              #   @param id [String] The tracking id of the API key.
              #
              #   @param service_account [OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::ServiceAccount] The service account that performed the audit logged action.
              #
              #   @param type [Symbol, OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::Type] The type of API key. Can be either `user` or `service_account`.
              #
              #   @param user [OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey::User] The user who performed the audit logged action.

              # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey#service_account
              class ServiceAccount < OpenAI::Internal::Type::BaseModel
                # @!attribute id
                #   The service account id.
                #
                #   @return [String, nil]
                optional :id, String

                # @!method initialize(id: nil)
                #   The service account that performed the audit logged action.
                #
                #   @param id [String] The service account id.
              end

              # The type of API key. Can be either `user` or `service_account`.
              #
              # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey#type
              module Type
                extend OpenAI::Internal::Type::Enum

                USER = :user
                SERVICE_ACCOUNT = :service_account

                # @!method self.values
                #   @return [Array<Symbol>]
              end

              # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::APIKey#user
              class User < OpenAI::Internal::Type::BaseModel
                # @!attribute id
                #   The user id.
                #
                #   @return [String, nil]
                optional :id, String

                # @!attribute email
                #   The user email.
                #
                #   @return [String, nil]
                optional :email, String

                # @!method initialize(id: nil, email: nil)
                #   The user who performed the audit logged action.
                #
                #   @param id [String] The user id.
                #
                #   @param email [String] The user email.
              end
            end

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor#session
            class Session < OpenAI::Internal::Type::BaseModel
              # @!attribute ip_address
              #   The IP address from which the action was performed.
              #
              #   @return [String, nil]
              optional :ip_address, String

              # @!attribute user
              #   The user who performed the audit logged action.
              #
              #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session::User, nil]
              optional :user, -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session::User }

              # @!method initialize(ip_address: nil, user: nil)
              #   The session in which the audit logged action was performed.
              #
              #   @param ip_address [String] The IP address from which the action was performed.
              #
              #   @param user [OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session::User] The user who performed the audit logged action.

              # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor::Session#user
              class User < OpenAI::Internal::Type::BaseModel
                # @!attribute id
                #   The user id.
                #
                #   @return [String, nil]
                optional :id, String

                # @!attribute email
                #   The user email.
                #
                #   @return [String, nil]
                optional :email, String

                # @!method initialize(id: nil, email: nil)
                #   The user who performed the audit logged action.
                #
                #   @param id [String] The user id.
                #
                #   @param email [String] The user email.
              end
            end

            # The type of actor. Is either `session` or `api_key`.
            #
            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor#type
            module Type
              extend OpenAI::Internal::Type::Enum

              SESSION = :session
              API_KEY = :api_key

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # The event type.
          #
          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#type
          module Type
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

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#api_key_created
          class APIKeyCreated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The tracking ID of the API key.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute data
            #   The payload used to create the API key.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated::Data, nil]
            optional :data, -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated::Data }

            # @!method initialize(id: nil, data: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The tracking ID of the API key.
            #
            #   @param data [OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated::Data] The payload used to create the API key.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated#data
            class Data < OpenAI::Internal::Type::BaseModel
              # @!attribute scopes
              #   A list of scopes allowed for the API key, e.g. `["api.model.request"]`
              #
              #   @return [Array<String>, nil]
              optional :scopes, OpenAI::Internal::Type::ArrayOf[String]

              # @!method initialize(scopes: nil)
              #   The payload used to create the API key.
              #
              #   @param scopes [Array<String>] A list of scopes allowed for the API key, e.g. `["api.model.request"]`
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#api_key_deleted
          class APIKeyDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The tracking ID of the API key.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The tracking ID of the API key.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#api_key_updated
          class APIKeyUpdated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The tracking ID of the API key.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute changes_requested
            #   The payload used to update the API key.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated::ChangesRequested, nil]
            optional :changes_requested,
                     -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated::ChangesRequested }

            # @!method initialize(id: nil, changes_requested: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The tracking ID of the API key.
            #
            #   @param changes_requested [OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated::ChangesRequested] The payload used to update the API key.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated#changes_requested
            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              # @!attribute scopes
              #   A list of scopes allowed for the API key, e.g. `["api.model.request"]`
              #
              #   @return [Array<String>, nil]
              optional :scopes, OpenAI::Internal::Type::ArrayOf[String]

              # @!method initialize(scopes: nil)
              #   The payload used to update the API key.
              #
              #   @param scopes [Array<String>] A list of scopes allowed for the API key, e.g. `["api.model.request"]`
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#certificate_created
          class CertificateCreated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The certificate ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute name
            #   The name of the certificate.
            #
            #   @return [String, nil]
            optional :name, String

            # @!method initialize(id: nil, name: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The certificate ID.
            #
            #   @param name [String] The name of the certificate.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#certificate_deleted
          class CertificateDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The certificate ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute certificate
            #   The certificate content in PEM format.
            #
            #   @return [String, nil]
            optional :certificate, String

            # @!attribute name
            #   The name of the certificate.
            #
            #   @return [String, nil]
            optional :name, String

            # @!method initialize(id: nil, certificate: nil, name: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The certificate ID.
            #
            #   @param certificate [String] The certificate content in PEM format.
            #
            #   @param name [String] The name of the certificate.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#certificate_updated
          class CertificateUpdated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The certificate ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute name
            #   The name of the certificate.
            #
            #   @return [String, nil]
            optional :name, String

            # @!method initialize(id: nil, name: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The certificate ID.
            #
            #   @param name [String] The name of the certificate.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#certificates_activated
          class CertificatesActivated < OpenAI::Internal::Type::BaseModel
            # @!attribute certificates
            #
            #   @return [Array<OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated::Certificate>, nil]
            optional :certificates,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated::Certificate] }

            # @!method initialize(certificates: nil)
            #   The details for events with this `type`.
            #
            #   @param certificates [Array<OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated::Certificate>]

            class Certificate < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   The certificate ID.
              #
              #   @return [String, nil]
              optional :id, String

              # @!attribute name
              #   The name of the certificate.
              #
              #   @return [String, nil]
              optional :name, String

              # @!method initialize(id: nil, name: nil)
              #   @param id [String] The certificate ID.
              #
              #   @param name [String] The name of the certificate.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#certificates_deactivated
          class CertificatesDeactivated < OpenAI::Internal::Type::BaseModel
            # @!attribute certificates
            #
            #   @return [Array<OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated::Certificate>, nil]
            optional :certificates,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated::Certificate] }

            # @!method initialize(certificates: nil)
            #   The details for events with this `type`.
            #
            #   @param certificates [Array<OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated::Certificate>]

            class Certificate < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   The certificate ID.
              #
              #   @return [String, nil]
              optional :id, String

              # @!attribute name
              #   The name of the certificate.
              #
              #   @return [String, nil]
              optional :name, String

              # @!method initialize(id: nil, name: nil)
              #   @param id [String] The certificate ID.
              #
              #   @param name [String] The name of the certificate.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#checkpoint_permission_created
          class CheckpointPermissionCreated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the checkpoint permission.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute data
            #   The payload used to create the checkpoint permission.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated::Data, nil]
            optional :data,
                     -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated::Data }

            # @!method initialize(id: nil, data: nil)
            #   The project and fine-tuned model checkpoint that the checkpoint permission was
            #   created for.
            #
            #   @param id [String] The ID of the checkpoint permission.
            #
            #   @param data [OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated::Data] The payload used to create the checkpoint permission.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated#data
            class Data < OpenAI::Internal::Type::BaseModel
              # @!attribute fine_tuned_model_checkpoint
              #   The ID of the fine-tuned model checkpoint.
              #
              #   @return [String, nil]
              optional :fine_tuned_model_checkpoint, String

              # @!attribute project_id
              #   The ID of the project that the checkpoint permission was created for.
              #
              #   @return [String, nil]
              optional :project_id, String

              # @!method initialize(fine_tuned_model_checkpoint: nil, project_id: nil)
              #   The payload used to create the checkpoint permission.
              #
              #   @param fine_tuned_model_checkpoint [String] The ID of the fine-tuned model checkpoint.
              #
              #   @param project_id [String] The ID of the project that the checkpoint permission was created for.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#checkpoint_permission_deleted
          class CheckpointPermissionDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the checkpoint permission.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the checkpoint permission.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#external_key_registered
          class ExternalKeyRegistered < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the external key configuration.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute data
            #   The configuration for the external key.
            #
            #   @return [Object, nil]
            optional :data, OpenAI::Internal::Type::Unknown

            # @!method initialize(id: nil, data: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the external key configuration.
            #
            #   @param data [Object] The configuration for the external key.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#external_key_removed
          class ExternalKeyRemoved < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the external key configuration.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the external key configuration.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#group_created
          class GroupCreated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the group.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute data
            #   Information about the created group.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated::Data, nil]
            optional :data, -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated::Data }

            # @!method initialize(id: nil, data: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the group.
            #
            #   @param data [OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated::Data] Information about the created group.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated#data
            class Data < OpenAI::Internal::Type::BaseModel
              # @!attribute group_name
              #   The group name.
              #
              #   @return [String, nil]
              optional :group_name, String

              # @!method initialize(group_name: nil)
              #   Information about the created group.
              #
              #   @param group_name [String] The group name.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#group_deleted
          class GroupDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the group.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the group.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#group_updated
          class GroupUpdated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the group.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute changes_requested
            #   The payload used to update the group.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated::ChangesRequested, nil]
            optional :changes_requested,
                     -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated::ChangesRequested }

            # @!method initialize(id: nil, changes_requested: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the group.
            #
            #   @param changes_requested [OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated::ChangesRequested] The payload used to update the group.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated#changes_requested
            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              # @!attribute group_name
              #   The updated group name.
              #
              #   @return [String, nil]
              optional :group_name, String

              # @!method initialize(group_name: nil)
              #   The payload used to update the group.
              #
              #   @param group_name [String] The updated group name.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#invite_accepted
          class InviteAccepted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the invite.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the invite.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#invite_deleted
          class InviteDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the invite.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the invite.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#invite_sent
          class InviteSent < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the invite.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute data
            #   The payload used to create the invite.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent::Data, nil]
            optional :data, -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent::Data }

            # @!method initialize(id: nil, data: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the invite.
            #
            #   @param data [OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent::Data] The payload used to create the invite.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent#data
            class Data < OpenAI::Internal::Type::BaseModel
              # @!attribute email
              #   The email invited to the organization.
              #
              #   @return [String, nil]
              optional :email, String

              # @!attribute role
              #   The role the email was invited to be. Is either `owner` or `member`.
              #
              #   @return [String, nil]
              optional :role, String

              # @!method initialize(email: nil, role: nil)
              #   The payload used to create the invite.
              #
              #   @param email [String] The email invited to the organization.
              #
              #   @param role [String] The role the email was invited to be. Is either `owner` or `member`.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#ip_allowlist_config_activated
          class IPAllowlistConfigActivated < OpenAI::Internal::Type::BaseModel
            # @!attribute configs
            #   The configurations that were activated.
            #
            #   @return [Array<OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated::Config>, nil]
            optional :configs,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated::Config] }

            # @!method initialize(configs: nil)
            #   The details for events with this `type`.
            #
            #   @param configs [Array<OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated::Config>] The configurations that were activated.

            class Config < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   The ID of the IP allowlist configuration.
              #
              #   @return [String, nil]
              optional :id, String

              # @!attribute name
              #   The name of the IP allowlist configuration.
              #
              #   @return [String, nil]
              optional :name, String

              # @!method initialize(id: nil, name: nil)
              #   @param id [String] The ID of the IP allowlist configuration.
              #
              #   @param name [String] The name of the IP allowlist configuration.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#ip_allowlist_config_deactivated
          class IPAllowlistConfigDeactivated < OpenAI::Internal::Type::BaseModel
            # @!attribute configs
            #   The configurations that were deactivated.
            #
            #   @return [Array<OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated::Config>, nil]
            optional :configs,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated::Config] }

            # @!method initialize(configs: nil)
            #   The details for events with this `type`.
            #
            #   @param configs [Array<OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated::Config>] The configurations that were deactivated.

            class Config < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   The ID of the IP allowlist configuration.
              #
              #   @return [String, nil]
              optional :id, String

              # @!attribute name
              #   The name of the IP allowlist configuration.
              #
              #   @return [String, nil]
              optional :name, String

              # @!method initialize(id: nil, name: nil)
              #   @param id [String] The ID of the IP allowlist configuration.
              #
              #   @param name [String] The name of the IP allowlist configuration.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#ip_allowlist_created
          class IPAllowlistCreated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the IP allowlist configuration.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute allowed_ips
            #   The IP addresses or CIDR ranges included in the configuration.
            #
            #   @return [Array<String>, nil]
            optional :allowed_ips, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute name
            #   The name of the IP allowlist configuration.
            #
            #   @return [String, nil]
            optional :name, String

            # @!method initialize(id: nil, allowed_ips: nil, name: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the IP allowlist configuration.
            #
            #   @param allowed_ips [Array<String>] The IP addresses or CIDR ranges included in the configuration.
            #
            #   @param name [String] The name of the IP allowlist configuration.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#ip_allowlist_deleted
          class IPAllowlistDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the IP allowlist configuration.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute allowed_ips
            #   The IP addresses or CIDR ranges that were in the configuration.
            #
            #   @return [Array<String>, nil]
            optional :allowed_ips, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute name
            #   The name of the IP allowlist configuration.
            #
            #   @return [String, nil]
            optional :name, String

            # @!method initialize(id: nil, allowed_ips: nil, name: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the IP allowlist configuration.
            #
            #   @param allowed_ips [Array<String>] The IP addresses or CIDR ranges that were in the configuration.
            #
            #   @param name [String] The name of the IP allowlist configuration.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#ip_allowlist_updated
          class IPAllowlistUpdated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the IP allowlist configuration.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute allowed_ips
            #   The updated set of IP addresses or CIDR ranges in the configuration.
            #
            #   @return [Array<String>, nil]
            optional :allowed_ips, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(id: nil, allowed_ips: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the IP allowlist configuration.
            #
            #   @param allowed_ips [Array<String>] The updated set of IP addresses or CIDR ranges in the configuration.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#login_failed
          class LoginFailed < OpenAI::Internal::Type::BaseModel
            # @!attribute error_code
            #   The error code of the failure.
            #
            #   @return [String, nil]
            optional :error_code, String

            # @!attribute error_message
            #   The error message of the failure.
            #
            #   @return [String, nil]
            optional :error_message, String

            # @!method initialize(error_code: nil, error_message: nil)
            #   The details for events with this `type`.
            #
            #   @param error_code [String] The error code of the failure.
            #
            #   @param error_message [String] The error message of the failure.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#logout_failed
          class LogoutFailed < OpenAI::Internal::Type::BaseModel
            # @!attribute error_code
            #   The error code of the failure.
            #
            #   @return [String, nil]
            optional :error_code, String

            # @!attribute error_message
            #   The error message of the failure.
            #
            #   @return [String, nil]
            optional :error_message, String

            # @!method initialize(error_code: nil, error_message: nil)
            #   The details for events with this `type`.
            #
            #   @param error_code [String] The error code of the failure.
            #
            #   @param error_message [String] The error message of the failure.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#organization_updated
          class OrganizationUpdated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The organization ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute changes_requested
            #   The payload used to update the organization settings.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated::ChangesRequested, nil]
            optional :changes_requested,
                     -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated::ChangesRequested }

            # @!method initialize(id: nil, changes_requested: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The organization ID.
            #
            #   @param changes_requested [OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated::ChangesRequested] The payload used to update the organization settings.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated#changes_requested
            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              # @!attribute api_call_logging
              #   How your organization logs data from supported API calls. One of `disabled`,
              #   `enabled_per_call`, `enabled_for_all_projects`, or
              #   `enabled_for_selected_projects`
              #
              #   @return [String, nil]
              optional :api_call_logging, String

              # @!attribute api_call_logging_project_ids
              #   The list of project ids if api_call_logging is set to
              #   `enabled_for_selected_projects`
              #
              #   @return [String, nil]
              optional :api_call_logging_project_ids, String

              # @!attribute description
              #   The organization description.
              #
              #   @return [String, nil]
              optional :description, String

              # @!attribute name
              #   The organization name.
              #
              #   @return [String, nil]
              optional :name, String

              # @!attribute threads_ui_visibility
              #   Visibility of the threads page which shows messages created with the Assistants
              #   API and Playground. One of `ANY_ROLE`, `OWNERS`, or `NONE`.
              #
              #   @return [String, nil]
              optional :threads_ui_visibility, String

              # @!attribute title
              #   The organization title.
              #
              #   @return [String, nil]
              optional :title, String

              # @!attribute usage_dashboard_visibility
              #   Visibility of the usage dashboard which shows activity and costs for your
              #   organization. One of `ANY_ROLE` or `OWNERS`.
              #
              #   @return [String, nil]
              optional :usage_dashboard_visibility, String

              # @!method initialize(api_call_logging: nil, api_call_logging_project_ids: nil, description: nil, name: nil, threads_ui_visibility: nil, title: nil, usage_dashboard_visibility: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated::ChangesRequested}
              #   for more details.
              #
              #   The payload used to update the organization settings.
              #
              #   @param api_call_logging [String] How your organization logs data from supported API calls. One of `disabled`, `en
              #
              #   @param api_call_logging_project_ids [String] The list of project ids if api_call_logging is set to `enabled_for_selected_proj
              #
              #   @param description [String] The organization description.
              #
              #   @param name [String] The organization name.
              #
              #   @param threads_ui_visibility [String] Visibility of the threads page which shows messages created with the Assistants
              #
              #   @param title [String] The organization title.
              #
              #   @param usage_dashboard_visibility [String] Visibility of the usage dashboard which shows activity and costs for your organi
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#project
          class Project < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The project ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute name
            #   The project title.
            #
            #   @return [String, nil]
            optional :name, String

            # @!method initialize(id: nil, name: nil)
            #   The project that the action was scoped to. Absent for actions not scoped to
            #   projects. Note that any admin actions taken via Admin API keys are associated
            #   with the default project.
            #
            #   @param id [String] The project ID.
            #
            #   @param name [String] The project title.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#project_archived
          class ProjectArchived < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The project ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The project ID.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#project_created
          class ProjectCreated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The project ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute data
            #   The payload used to create the project.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated::Data, nil]
            optional :data, -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated::Data }

            # @!method initialize(id: nil, data: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The project ID.
            #
            #   @param data [OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated::Data] The payload used to create the project.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated#data
            class Data < OpenAI::Internal::Type::BaseModel
              # @!attribute name
              #   The project name.
              #
              #   @return [String, nil]
              optional :name, String

              # @!attribute title
              #   The title of the project as seen on the dashboard.
              #
              #   @return [String, nil]
              optional :title, String

              # @!method initialize(name: nil, title: nil)
              #   The payload used to create the project.
              #
              #   @param name [String] The project name.
              #
              #   @param title [String] The title of the project as seen on the dashboard.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#project_deleted
          class ProjectDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The project ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The project ID.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#project_updated
          class ProjectUpdated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The project ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute changes_requested
            #   The payload used to update the project.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated::ChangesRequested, nil]
            optional :changes_requested,
                     -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated::ChangesRequested }

            # @!method initialize(id: nil, changes_requested: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The project ID.
            #
            #   @param changes_requested [OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated::ChangesRequested] The payload used to update the project.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated#changes_requested
            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              # @!attribute title
              #   The title of the project as seen on the dashboard.
              #
              #   @return [String, nil]
              optional :title, String

              # @!method initialize(title: nil)
              #   The payload used to update the project.
              #
              #   @param title [String] The title of the project as seen on the dashboard.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#rate_limit_deleted
          class RateLimitDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The rate limit ID
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The rate limit ID
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#rate_limit_updated
          class RateLimitUpdated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The rate limit ID
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute changes_requested
            #   The payload used to update the rate limits.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated::ChangesRequested, nil]
            optional :changes_requested,
                     -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated::ChangesRequested }

            # @!method initialize(id: nil, changes_requested: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The rate limit ID
            #
            #   @param changes_requested [OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated::ChangesRequested] The payload used to update the rate limits.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated#changes_requested
            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              # @!attribute batch_1_day_max_input_tokens
              #   The maximum batch input tokens per day. Only relevant for certain models.
              #
              #   @return [Integer, nil]
              optional :batch_1_day_max_input_tokens, Integer

              # @!attribute max_audio_megabytes_per_1_minute
              #   The maximum audio megabytes per minute. Only relevant for certain models.
              #
              #   @return [Integer, nil]
              optional :max_audio_megabytes_per_1_minute, Integer

              # @!attribute max_images_per_1_minute
              #   The maximum images per minute. Only relevant for certain models.
              #
              #   @return [Integer, nil]
              optional :max_images_per_1_minute, Integer

              # @!attribute max_requests_per_1_day
              #   The maximum requests per day. Only relevant for certain models.
              #
              #   @return [Integer, nil]
              optional :max_requests_per_1_day, Integer

              # @!attribute max_requests_per_1_minute
              #   The maximum requests per minute.
              #
              #   @return [Integer, nil]
              optional :max_requests_per_1_minute, Integer

              # @!attribute max_tokens_per_1_minute
              #   The maximum tokens per minute.
              #
              #   @return [Integer, nil]
              optional :max_tokens_per_1_minute, Integer

              # @!method initialize(batch_1_day_max_input_tokens: nil, max_audio_megabytes_per_1_minute: nil, max_images_per_1_minute: nil, max_requests_per_1_day: nil, max_requests_per_1_minute: nil, max_tokens_per_1_minute: nil)
              #   The payload used to update the rate limits.
              #
              #   @param batch_1_day_max_input_tokens [Integer] The maximum batch input tokens per day. Only relevant for certain models.
              #
              #   @param max_audio_megabytes_per_1_minute [Integer] The maximum audio megabytes per minute. Only relevant for certain models.
              #
              #   @param max_images_per_1_minute [Integer] The maximum images per minute. Only relevant for certain models.
              #
              #   @param max_requests_per_1_day [Integer] The maximum requests per day. Only relevant for certain models.
              #
              #   @param max_requests_per_1_minute [Integer] The maximum requests per minute.
              #
              #   @param max_tokens_per_1_minute [Integer] The maximum tokens per minute.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#role_assignment_created
          class RoleAssignmentCreated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier of the role assignment.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute principal_id
            #   The principal (user or group) that received the role.
            #
            #   @return [String, nil]
            optional :principal_id, String

            # @!attribute principal_type
            #   The type of principal (user or group) that received the role.
            #
            #   @return [String, nil]
            optional :principal_type, String

            # @!attribute resource_id
            #   The resource the role assignment is scoped to.
            #
            #   @return [String, nil]
            optional :resource_id, String

            # @!attribute resource_type
            #   The type of resource the role assignment is scoped to.
            #
            #   @return [String, nil]
            optional :resource_type, String

            # @!method initialize(id: nil, principal_id: nil, principal_type: nil, resource_id: nil, resource_type: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The identifier of the role assignment.
            #
            #   @param principal_id [String] The principal (user or group) that received the role.
            #
            #   @param principal_type [String] The type of principal (user or group) that received the role.
            #
            #   @param resource_id [String] The resource the role assignment is scoped to.
            #
            #   @param resource_type [String] The type of resource the role assignment is scoped to.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#role_assignment_deleted
          class RoleAssignmentDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier of the role assignment.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute principal_id
            #   The principal (user or group) that had the role removed.
            #
            #   @return [String, nil]
            optional :principal_id, String

            # @!attribute principal_type
            #   The type of principal (user or group) that had the role removed.
            #
            #   @return [String, nil]
            optional :principal_type, String

            # @!attribute resource_id
            #   The resource the role assignment was scoped to.
            #
            #   @return [String, nil]
            optional :resource_id, String

            # @!attribute resource_type
            #   The type of resource the role assignment was scoped to.
            #
            #   @return [String, nil]
            optional :resource_type, String

            # @!method initialize(id: nil, principal_id: nil, principal_type: nil, resource_id: nil, resource_type: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The identifier of the role assignment.
            #
            #   @param principal_id [String] The principal (user or group) that had the role removed.
            #
            #   @param principal_type [String] The type of principal (user or group) that had the role removed.
            #
            #   @param resource_id [String] The resource the role assignment was scoped to.
            #
            #   @param resource_type [String] The type of resource the role assignment was scoped to.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#role_created
          class RoleCreated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The role ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute permissions
            #   The permissions granted by the role.
            #
            #   @return [Array<String>, nil]
            optional :permissions, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute resource_id
            #   The resource the role is scoped to.
            #
            #   @return [String, nil]
            optional :resource_id, String

            # @!attribute resource_type
            #   The type of resource the role belongs to.
            #
            #   @return [String, nil]
            optional :resource_type, String

            # @!attribute role_name
            #   The name of the role.
            #
            #   @return [String, nil]
            optional :role_name, String

            # @!method initialize(id: nil, permissions: nil, resource_id: nil, resource_type: nil, role_name: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The role ID.
            #
            #   @param permissions [Array<String>] The permissions granted by the role.
            #
            #   @param resource_id [String] The resource the role is scoped to.
            #
            #   @param resource_type [String] The type of resource the role belongs to.
            #
            #   @param role_name [String] The name of the role.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#role_deleted
          class RoleDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The role ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The role ID.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#role_updated
          class RoleUpdated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The role ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute changes_requested
            #   The payload used to update the role.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated::ChangesRequested, nil]
            optional :changes_requested,
                     -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated::ChangesRequested }

            # @!method initialize(id: nil, changes_requested: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The role ID.
            #
            #   @param changes_requested [OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated::ChangesRequested] The payload used to update the role.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated#changes_requested
            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              # @!attribute description
              #   The updated role description, when provided.
              #
              #   @return [String, nil]
              optional :description, String

              # @!attribute metadata
              #   Additional metadata stored on the role.
              #
              #   @return [Object, nil]
              optional :metadata, OpenAI::Internal::Type::Unknown

              # @!attribute permissions_added
              #   The permissions added to the role.
              #
              #   @return [Array<String>, nil]
              optional :permissions_added, OpenAI::Internal::Type::ArrayOf[String]

              # @!attribute permissions_removed
              #   The permissions removed from the role.
              #
              #   @return [Array<String>, nil]
              optional :permissions_removed, OpenAI::Internal::Type::ArrayOf[String]

              # @!attribute resource_id
              #   The resource the role is scoped to.
              #
              #   @return [String, nil]
              optional :resource_id, String

              # @!attribute resource_type
              #   The type of resource the role belongs to.
              #
              #   @return [String, nil]
              optional :resource_type, String

              # @!attribute role_name
              #   The updated role name, when provided.
              #
              #   @return [String, nil]
              optional :role_name, String

              # @!method initialize(description: nil, metadata: nil, permissions_added: nil, permissions_removed: nil, resource_id: nil, resource_type: nil, role_name: nil)
              #   The payload used to update the role.
              #
              #   @param description [String] The updated role description, when provided.
              #
              #   @param metadata [Object] Additional metadata stored on the role.
              #
              #   @param permissions_added [Array<String>] The permissions added to the role.
              #
              #   @param permissions_removed [Array<String>] The permissions removed from the role.
              #
              #   @param resource_id [String] The resource the role is scoped to.
              #
              #   @param resource_type [String] The type of resource the role belongs to.
              #
              #   @param role_name [String] The updated role name, when provided.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#scim_disabled
          class ScimDisabled < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the SCIM was disabled for.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the SCIM was disabled for.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#scim_enabled
          class ScimEnabled < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the SCIM was enabled for.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The ID of the SCIM was enabled for.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#service_account_created
          class ServiceAccountCreated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The service account ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute data
            #   The payload used to create the service account.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated::Data, nil]
            optional :data,
                     -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated::Data }

            # @!method initialize(id: nil, data: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The service account ID.
            #
            #   @param data [OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated::Data] The payload used to create the service account.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated#data
            class Data < OpenAI::Internal::Type::BaseModel
              # @!attribute role
              #   The role of the service account. Is either `owner` or `member`.
              #
              #   @return [String, nil]
              optional :role, String

              # @!method initialize(role: nil)
              #   The payload used to create the service account.
              #
              #   @param role [String] The role of the service account. Is either `owner` or `member`.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#service_account_deleted
          class ServiceAccountDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The service account ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The service account ID.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#service_account_updated
          class ServiceAccountUpdated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The service account ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute changes_requested
            #   The payload used to updated the service account.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated::ChangesRequested, nil]
            optional :changes_requested,
                     -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated::ChangesRequested }

            # @!method initialize(id: nil, changes_requested: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The service account ID.
            #
            #   @param changes_requested [OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated::ChangesRequested] The payload used to updated the service account.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated#changes_requested
            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              # @!attribute role
              #   The role of the service account. Is either `owner` or `member`.
              #
              #   @return [String, nil]
              optional :role, String

              # @!method initialize(role: nil)
              #   The payload used to updated the service account.
              #
              #   @param role [String] The role of the service account. Is either `owner` or `member`.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#user_added
          class UserAdded < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The user ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute data
            #   The payload used to add the user to the project.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded::Data, nil]
            optional :data, -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded::Data }

            # @!method initialize(id: nil, data: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The user ID.
            #
            #   @param data [OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded::Data] The payload used to add the user to the project.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded#data
            class Data < OpenAI::Internal::Type::BaseModel
              # @!attribute role
              #   The role of the user. Is either `owner` or `member`.
              #
              #   @return [String, nil]
              optional :role, String

              # @!method initialize(role: nil)
              #   The payload used to add the user to the project.
              #
              #   @param role [String] The role of the user. Is either `owner` or `member`.
            end
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#user_deleted
          class UserDeleted < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The user ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(id: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The user ID.
          end

          # @see OpenAI::Models::Admin::Organization::AuditLogListResponse#user_updated
          class UserUpdated < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The project ID.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute changes_requested
            #   The payload used to update the user.
            #
            #   @return [OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated::ChangesRequested, nil]
            optional :changes_requested,
                     -> { OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated::ChangesRequested }

            # @!method initialize(id: nil, changes_requested: nil)
            #   The details for events with this `type`.
            #
            #   @param id [String] The project ID.
            #
            #   @param changes_requested [OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated::ChangesRequested] The payload used to update the user.

            # @see OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated#changes_requested
            class ChangesRequested < OpenAI::Internal::Type::BaseModel
              # @!attribute role
              #   The role of the user. Is either `owner` or `member`.
              #
              #   @return [String, nil]
              optional :role, String

              # @!method initialize(role: nil)
              #   The payload used to update the user.
              #
              #   @param role [String] The role of the user. Is either `owner` or `member`.
            end
          end
        end
      end
    end
  end
end
