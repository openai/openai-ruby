# frozen_string_literal: true

require_relative "../../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::ServiceAccounts::APIKeysTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response =
      @openai.admin.organization.projects.service_accounts.api_keys.create(
        "service_account_id",
        project_id: "project_id"
      )

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Projects::ServiceAccounts::APIKeyCreateResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        name: String,
        object: Symbol,
        value: String
      }
    end
  end
end
