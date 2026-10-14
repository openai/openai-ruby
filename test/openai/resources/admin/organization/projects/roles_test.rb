# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::RolesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response =
      @openai.admin.organization.projects.roles.create(
        "project_id",
        permissions: ["string"],
        role_name: "role_name"
      )

    assert_pattern do
      response => OpenAI::Admin::Organization::Role
    end

    assert_pattern do
      response => {
        id: String,
        description: String | nil,
        name: String,
        object: Symbol,
        permissions: ^(OpenAI::Internal::Type::ArrayOf[String]),
        predefined_role: OpenAI::Internal::Type::Boolean,
        resource_type: String
      }
    end
  end

  def test_retrieve_required_params
    response = @openai.admin.organization.projects.roles.retrieve("role_id", project_id: "project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Role
    end

    assert_pattern do
      response => {
        id: String,
        description: String | nil,
        name: String,
        object: Symbol,
        permissions: ^(OpenAI::Internal::Type::ArrayOf[String]),
        predefined_role: OpenAI::Internal::Type::Boolean,
        resource_type: String
      }
    end
  end

  def test_update_required_params
    response = @openai.admin.organization.projects.roles.update("role_id", project_id: "project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Role
    end

    assert_pattern do
      response => {
        id: String,
        description: String | nil,
        name: String,
        object: Symbol,
        permissions: ^(OpenAI::Internal::Type::ArrayOf[String]),
        predefined_role: OpenAI::Internal::Type::Boolean,
        resource_type: String
      }
    end
  end

  def test_list
    response = @openai.admin.organization.projects.roles.list("project_id")

    assert_pattern do
      response => OpenAI::Internal::NextCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Role
    end

    assert_pattern do
      row => {
        id: String,
        description: String | nil,
        name: String,
        object: Symbol,
        permissions: ^(OpenAI::Internal::Type::ArrayOf[String]),
        predefined_role: OpenAI::Internal::Type::Boolean,
        resource_type: String
      }
    end
  end

  def test_delete_required_params
    response = @openai.admin.organization.projects.roles.delete("role_id", project_id: "project_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Projects::RoleDeleteResponse
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
