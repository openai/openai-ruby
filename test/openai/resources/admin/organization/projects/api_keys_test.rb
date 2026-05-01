# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::APIKeysTest < OpenAI::Test::ResourceTest
  def test_retrieve_required_params
    response = @openai.admin.organization.projects.api_keys.retrieve("api_key_id", project_id: "project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectAPIKey
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        last_used_at: Integer | nil,
        name: String,
        object: Symbol,
        owner: OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner,
        redacted_value: String
      }
    end
  end

  def test_list
    response = @openai.admin.organization.projects.api_keys.list("project_id")

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Projects::ProjectAPIKey
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        last_used_at: Integer | nil,
        name: String,
        object: Symbol,
        owner: OpenAI::Admin::Organization::Projects::ProjectAPIKey::Owner,
        redacted_value: String
      }
    end
  end

  def test_delete_required_params
    response = @openai.admin.organization.projects.api_keys.delete("api_key_id", project_id: "project_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Projects::APIKeyDeleteResponse
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
