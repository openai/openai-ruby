# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::GroupsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response =
      @openai.admin.organization.projects.groups.create("project_id", group_id: "group_id", role: "role")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectGroup
    end

    assert_pattern do
      response => {
        created_at: Integer,
        group_id: String,
        group_name: String,
        object: Symbol,
        project_id: String
      }
    end
  end

  def test_list
    response = @openai.admin.organization.projects.groups.list("project_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Projects::ProjectGroup
    end

    assert_pattern do
      row => {
        created_at: Integer,
        group_id: String,
        group_name: String,
        object: Symbol,
        project_id: String
      }
    end
  end

  def test_delete_required_params
    response = @openai.admin.organization.projects.groups.delete("group_id", project_id: "project_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Projects::GroupDeleteResponse
    end

    assert_pattern do
      response => {
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol
      }
    end
  end
end
