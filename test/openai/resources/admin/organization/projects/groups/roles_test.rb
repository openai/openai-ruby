# frozen_string_literal: true

require_relative "../../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::Groups::RolesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response =
      @openai.admin.organization.projects.groups.roles.create(
        "group_id",
        project_id: "project_id",
        role_id: "role_id"
      )

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse
    end

    assert_pattern do
      response => {
        group: OpenAI::Models::Admin::Organization::Projects::Groups::RoleCreateResponse::Group,
        object: Symbol,
        role: OpenAI::Admin::Organization::Role
      }
    end
  end

  def test_list_required_params
    response = @openai.admin.organization.projects.groups.roles.list("group_id", project_id: "project_id")

    assert_pattern do
      response => OpenAI::Internal::NextCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::Admin::Organization::Projects::Groups::RoleListResponse
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
    response =
      @openai.admin.organization.projects.groups.roles.delete(
        "role_id",
        project_id: "project_id",
        group_id: "group_id"
      )

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Projects::Groups::RoleDeleteResponse
    end

    assert_pattern do
      response => {
        deleted: OpenAI::Internal::Type::Boolean,
        object: String
      }
    end
  end
end
