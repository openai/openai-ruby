# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::UsersTest < OpenAI::Test::ResourceTest
  def test_retrieve
    response = @openai.admin.organization.users.retrieve("user_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::OrganizationUser
    end

    assert_pattern do
      response => {
        id: String,
        added_at: Integer,
        object: Symbol,
        api_key_last_used_at: Integer | nil,
        created: Integer | nil,
        developer_persona: String | nil,
        email: String | nil,
        is_default: OpenAI::Internal::Type::Boolean | nil,
        is_scale_tier_authorized_purchaser: OpenAI::Internal::Type::Boolean | nil,
        is_scim_managed: OpenAI::Internal::Type::Boolean | nil,
        is_service_account: OpenAI::Internal::Type::Boolean | nil,
        name: String | nil,
        projects: OpenAI::Admin::Organization::OrganizationUser::Projects | nil,
        role: String | nil,
        technical_level: String | nil,
        user: OpenAI::Admin::Organization::OrganizationUser::User | nil
      }
    end
  end

  def test_update
    response = @openai.admin.organization.users.update("user_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::OrganizationUser
    end

    assert_pattern do
      response => {
        id: String,
        added_at: Integer,
        object: Symbol,
        api_key_last_used_at: Integer | nil,
        created: Integer | nil,
        developer_persona: String | nil,
        email: String | nil,
        is_default: OpenAI::Internal::Type::Boolean | nil,
        is_scale_tier_authorized_purchaser: OpenAI::Internal::Type::Boolean | nil,
        is_scim_managed: OpenAI::Internal::Type::Boolean | nil,
        is_service_account: OpenAI::Internal::Type::Boolean | nil,
        name: String | nil,
        projects: OpenAI::Admin::Organization::OrganizationUser::Projects | nil,
        role: String | nil,
        technical_level: String | nil,
        user: OpenAI::Admin::Organization::OrganizationUser::User | nil
      }
    end
  end

  def test_list
    response = @openai.admin.organization.users.list

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::OrganizationUser
    end

    assert_pattern do
      row => {
        id: String,
        added_at: Integer,
        object: Symbol,
        api_key_last_used_at: Integer | nil,
        created: Integer | nil,
        developer_persona: String | nil,
        email: String | nil,
        is_default: OpenAI::Internal::Type::Boolean | nil,
        is_scale_tier_authorized_purchaser: OpenAI::Internal::Type::Boolean | nil,
        is_scim_managed: OpenAI::Internal::Type::Boolean | nil,
        is_service_account: OpenAI::Internal::Type::Boolean | nil,
        name: String | nil,
        projects: OpenAI::Admin::Organization::OrganizationUser::Projects | nil,
        role: String | nil,
        technical_level: String | nil,
        user: OpenAI::Admin::Organization::OrganizationUser::User | nil
      }
    end
  end

  def test_delete
    response = @openai.admin.organization.users.delete("user_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::UserDeleteResponse
    end

    assert_pattern do
      response => {
        id: String,
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol
      }
    end
  end
end
