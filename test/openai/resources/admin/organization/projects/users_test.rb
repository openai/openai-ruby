# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::UsersTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.admin.organization.projects.users.create("project_id", role: "role")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectUser
    end

    assert_pattern do
      response => {
        id: String,
        added_at: Integer,
        object: Symbol,
        role: String,
        email: String | nil,
        name: String | nil
      }
    end
  end

  def test_retrieve_required_params
    response = @openai.admin.organization.projects.users.retrieve("user_id", project_id: "project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectUser
    end

    assert_pattern do
      response => {
        id: String,
        added_at: Integer,
        object: Symbol,
        role: String,
        email: String | nil,
        name: String | nil
      }
    end
  end

  def test_update_required_params
    response = @openai.admin.organization.projects.users.update("user_id", project_id: "project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectUser
    end

    assert_pattern do
      response => {
        id: String,
        added_at: Integer,
        object: Symbol,
        role: String,
        email: String | nil,
        name: String | nil
      }
    end
  end

  def test_list
    response = @openai.admin.organization.projects.users.list("project_id")

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Projects::ProjectUser
    end

    assert_pattern do
      row => {
        id: String,
        added_at: Integer,
        object: Symbol,
        role: String,
        email: String | nil,
        name: String | nil
      }
    end
  end

  def test_delete_required_params
    response = @openai.admin.organization.projects.users.delete("user_id", project_id: "project_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Projects::UserDeleteResponse
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
