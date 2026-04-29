# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::AuditLogsTest < OpenAI::Test::ResourceTest
  def test_list
    response = @openai.admin.organization.audit_logs.list

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::Admin::Organization::AuditLogListResponse
    end

    assert_pattern do
      row => {
        id: String,
        actor: OpenAI::Models::Admin::Organization::AuditLogListResponse::Actor,
        effective_at: Integer,
        type: OpenAI::Models::Admin::Organization::AuditLogListResponse::Type,
        api_key_created: OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyCreated | nil,
        api_key_deleted: OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyDeleted | nil,
        api_key_updated: OpenAI::Models::Admin::Organization::AuditLogListResponse::APIKeyUpdated | nil,
        certificate_created: OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateCreated | nil,
        certificate_deleted: OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateDeleted | nil,
        certificate_updated: OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificateUpdated | nil,
        certificates_activated: OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesActivated | nil,
        certificates_deactivated: OpenAI::Models::Admin::Organization::AuditLogListResponse::CertificatesDeactivated | nil,
        checkpoint_permission_created: OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionCreated | nil,
        checkpoint_permission_deleted: OpenAI::Models::Admin::Organization::AuditLogListResponse::CheckpointPermissionDeleted | nil,
        external_key_registered: OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRegistered | nil,
        external_key_removed: OpenAI::Models::Admin::Organization::AuditLogListResponse::ExternalKeyRemoved | nil,
        group_created: OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupCreated | nil,
        group_deleted: OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupDeleted | nil,
        group_updated: OpenAI::Models::Admin::Organization::AuditLogListResponse::GroupUpdated | nil,
        invite_accepted: OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteAccepted | nil,
        invite_deleted: OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteDeleted | nil,
        invite_sent: OpenAI::Models::Admin::Organization::AuditLogListResponse::InviteSent | nil,
        ip_allowlist_config_activated: OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigActivated | nil,
        ip_allowlist_config_deactivated: OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistConfigDeactivated | nil,
        ip_allowlist_created: OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistCreated | nil,
        ip_allowlist_deleted: OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistDeleted | nil,
        ip_allowlist_updated: OpenAI::Models::Admin::Organization::AuditLogListResponse::IPAllowlistUpdated | nil,
        login_failed: OpenAI::Models::Admin::Organization::AuditLogListResponse::LoginFailed | nil,
        login_succeeded: OpenAI::Internal::Type::Unknown | nil,
        logout_failed: OpenAI::Models::Admin::Organization::AuditLogListResponse::LogoutFailed | nil,
        logout_succeeded: OpenAI::Internal::Type::Unknown | nil,
        organization_updated: OpenAI::Models::Admin::Organization::AuditLogListResponse::OrganizationUpdated | nil,
        project: OpenAI::Models::Admin::Organization::AuditLogListResponse::Project | nil,
        project_archived: OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectArchived | nil,
        project_created: OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectCreated | nil,
        project_deleted: OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectDeleted | nil,
        project_updated: OpenAI::Models::Admin::Organization::AuditLogListResponse::ProjectUpdated | nil,
        rate_limit_deleted: OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitDeleted | nil,
        rate_limit_updated: OpenAI::Models::Admin::Organization::AuditLogListResponse::RateLimitUpdated | nil,
        role_assignment_created: OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentCreated | nil,
        role_assignment_deleted: OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleAssignmentDeleted | nil,
        role_created: OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleCreated | nil,
        role_deleted: OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleDeleted | nil,
        role_updated: OpenAI::Models::Admin::Organization::AuditLogListResponse::RoleUpdated | nil,
        scim_disabled: OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimDisabled | nil,
        scim_enabled: OpenAI::Models::Admin::Organization::AuditLogListResponse::ScimEnabled | nil,
        service_account_created: OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountCreated | nil,
        service_account_deleted: OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountDeleted | nil,
        service_account_updated: OpenAI::Models::Admin::Organization::AuditLogListResponse::ServiceAccountUpdated | nil,
        user_added: OpenAI::Models::Admin::Organization::AuditLogListResponse::UserAdded | nil,
        user_deleted: OpenAI::Models::Admin::Organization::AuditLogListResponse::UserDeleted | nil,
        user_updated: OpenAI::Models::Admin::Organization::AuditLogListResponse::UserUpdated | nil
      }
    end
  end
end
