# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Users::RolesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.admin.organization.users.roles.create("user_id", role_id: "role_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Users::RoleCreateResponse
    end

    assert_pattern do
      response => {
        object: Symbol,
        role: OpenAI::Admin::Organization::Role,
        user: OpenAI::Admin::Organization::OrganizationUser
      }
    end
  end

  def test_list
    response = @openai.admin.organization.users.roles.list("user_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::Admin::Organization::Users::RoleListResponse
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer | nil,
        created_by: String | nil,
        created_by_user_obj: ^(OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]) | nil,
        description: String | nil,
        metadata: ^(OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]) | nil,
        name: String,
        permissions: ^(OpenAI::Internal::Type::ArrayOf[String]),
        predefined_role: OpenAI::Internal::Type::Boolean,
        resource_type: String,
        updated_at: Integer | nil
      }
    end
  end

  def test_delete_required_params
    response = @openai.admin.organization.users.roles.delete("role_id", user_id: "user_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Users::RoleDeleteResponse
    end

    assert_pattern do
      response => {
        deleted: OpenAI::Internal::Type::Boolean,
        object: String
      }
    end
  end
end
