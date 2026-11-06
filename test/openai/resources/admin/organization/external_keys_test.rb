# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::ExternalKeysTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.admin.organization.external_keys.create(
      body: {
        external_id: "external_id",
        kms_arn: "kms_arn",
        name: "name",
        role_arn: "arn:aws:iam::123456789012:role/example-role",
        type: :aws
      }
    )

    assert_pattern do
      response => OpenAI::Admin::Organization::ExternalKey
    end

    assert_pattern do
      response => {
          id: String,
          api_project_ids: ^(OpenAI::Internal::Type::ArrayOf[String]),
          created_at: Integer,
          name: String,
          object: String,
          type: String,
          workspace_id: String,
          audience: String | nil,
          external_id: String | nil,
          key_name: String | nil,
          key_version: String | nil,
          kms_arn: String | nil,
          kms_key_location: String | nil,
          kms_key_name: String | nil,
          kms_key_ring_name: String | nil,
          kms_key_version: String | nil,
          kms_project_id: String | nil,
          purpose: OpenAI::Admin::Organization::ExternalKey::Purpose | nil,
          role_arn: String | nil,
          tenant_id: String | nil,
          vault_uri: String | nil,
          workload_identity_pool_id: String | nil,
          workload_identity_project_number: String | nil,
          workload_identity_provider_id: String | nil
        }
    end
  end

  def test_retrieve
    response = @openai.admin.organization.external_keys.retrieve("external_key_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::ExternalKey
    end

    assert_pattern do
      response => {
          id: String,
          api_project_ids: ^(OpenAI::Internal::Type::ArrayOf[String]),
          created_at: Integer,
          name: String,
          object: String,
          type: String,
          workspace_id: String,
          audience: String | nil,
          external_id: String | nil,
          key_name: String | nil,
          key_version: String | nil,
          kms_arn: String | nil,
          kms_key_location: String | nil,
          kms_key_name: String | nil,
          kms_key_ring_name: String | nil,
          kms_key_version: String | nil,
          kms_project_id: String | nil,
          purpose: OpenAI::Admin::Organization::ExternalKey::Purpose | nil,
          role_arn: String | nil,
          tenant_id: String | nil,
          vault_uri: String | nil,
          workload_identity_pool_id: String | nil,
          workload_identity_project_number: String | nil,
          workload_identity_provider_id: String | nil
        }
    end
  end

  def test_list
    response = @openai.admin.organization.external_keys.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    # Validate this response only; pagination is covered with finite fixtures.
    row = response.data&.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::ExternalKey
    end

    assert_pattern do
      row => {
          id: String,
          api_project_ids: ^(OpenAI::Internal::Type::ArrayOf[String]),
          created_at: Integer,
          name: String,
          object: String,
          type: String,
          workspace_id: String,
          audience: String | nil,
          external_id: String | nil,
          key_name: String | nil,
          key_version: String | nil,
          kms_arn: String | nil,
          kms_key_location: String | nil,
          kms_key_name: String | nil,
          kms_key_ring_name: String | nil,
          kms_key_version: String | nil,
          kms_project_id: String | nil,
          purpose: OpenAI::Admin::Organization::ExternalKey::Purpose | nil,
          role_arn: String | nil,
          tenant_id: String | nil,
          vault_uri: String | nil,
          workload_identity_pool_id: String | nil,
          workload_identity_project_number: String | nil,
          workload_identity_provider_id: String | nil
        }
    end
  end

  def test_delete
    response = @openai.admin.organization.external_keys.delete("external_key_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::ExternalKey
    end

    assert_pattern do
      response => {
          id: String,
          api_project_ids: ^(OpenAI::Internal::Type::ArrayOf[String]),
          created_at: Integer,
          name: String,
          object: String,
          type: String,
          workspace_id: String,
          audience: String | nil,
          external_id: String | nil,
          key_name: String | nil,
          key_version: String | nil,
          kms_arn: String | nil,
          kms_key_location: String | nil,
          kms_key_name: String | nil,
          kms_key_ring_name: String | nil,
          kms_key_version: String | nil,
          kms_project_id: String | nil,
          purpose: OpenAI::Admin::Organization::ExternalKey::Purpose | nil,
          role_arn: String | nil,
          tenant_id: String | nil,
          vault_uri: String | nil,
          workload_identity_pool_id: String | nil,
          workload_identity_project_number: String | nil,
          workload_identity_provider_id: String | nil
        }
    end
  end

  def test_validate
    response = @openai.admin.organization.external_keys.validate("external_key_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::ExternalKeyValidateResponse
    end

    assert_pattern do
      response => {
          status: String
        }
    end
  end
end
