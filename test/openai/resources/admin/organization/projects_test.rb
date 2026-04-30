# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::ProjectsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.admin.organization.projects.create(name: "name")

    assert_pattern do
      response => OpenAI::Admin::Organization::Project
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        name: String,
        object: Symbol,
        status: OpenAI::Admin::Organization::Project::Status,
        archived_at: Integer | nil
      }
    end
  end

  def test_retrieve
    response = @openai.admin.organization.projects.retrieve("project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Project
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        name: String,
        object: Symbol,
        status: OpenAI::Admin::Organization::Project::Status,
        archived_at: Integer | nil
      }
    end
  end

  def test_update_required_params
    response = @openai.admin.organization.projects.update("project_id", name: "name")

    assert_pattern do
      response => OpenAI::Admin::Organization::Project
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        name: String,
        object: Symbol,
        status: OpenAI::Admin::Organization::Project::Status,
        archived_at: Integer | nil
      }
    end
  end

  def test_list
    response = @openai.admin.organization.projects.list

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Project
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        name: String,
        object: Symbol,
        status: OpenAI::Admin::Organization::Project::Status,
        archived_at: Integer | nil
      }
    end
  end

  def test_archive
    response = @openai.admin.organization.projects.archive("project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Project
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        name: String,
        object: Symbol,
        status: OpenAI::Admin::Organization::Project::Status,
        archived_at: Integer | nil
      }
    end
  end
end
