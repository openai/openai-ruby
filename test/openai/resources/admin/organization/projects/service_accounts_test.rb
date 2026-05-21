# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::ServiceAccountsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.admin.organization.projects.service_accounts.create("project_id", name: "name")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse
    end

    assert_pattern do
      response => {
        id: String,
        api_key: OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::APIKey | nil,
        created_at: Integer,
        name: String,
        object: Symbol,
        role: Symbol
      }
    end
  end

  def test_retrieve_required_params
    response =
      @openai.admin.organization.projects.service_accounts.retrieve(
        "service_account_id",
        project_id: "project_id"
      )

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectServiceAccount
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        name: String,
        object: Symbol,
        role: OpenAI::Admin::Organization::Projects::ProjectServiceAccount::Role
      }
    end
  end

  def test_update_required_params
    response =
      @openai.admin.organization.projects.service_accounts.update(
        "service_account_id",
        project_id: "project_id"
      )

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectServiceAccount
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        name: String,
        object: Symbol,
        role: OpenAI::Admin::Organization::Projects::ProjectServiceAccount::Role
      }
    end
  end

  def test_list
    response = @openai.admin.organization.projects.service_accounts.list("project_id")

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Projects::ProjectServiceAccount
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        name: String,
        object: Symbol,
        role: OpenAI::Admin::Organization::Projects::ProjectServiceAccount::Role
      }
    end
  end

  def test_delete_required_params
    response =
      @openai.admin.organization.projects.service_accounts.delete(
        "service_account_id",
        project_id: "project_id"
      )

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Projects::ServiceAccountDeleteResponse
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
