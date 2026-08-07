# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::DataRetentionTest < OpenAI::Test::ResourceTest
  def test_retrieve
    response = @openai.admin.organization.projects.data_retention.retrieve("project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectDataRetention
    end

    assert_pattern do
      response => {
        object: Symbol,
        type: OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type
      }
    end
  end

  def test_update_required_params
    response =
      @openai.admin.organization.projects.data_retention.update(
        "project_id",
        retention_type: :organization_default
      )

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectDataRetention
    end

    assert_pattern do
      response => {
        object: Symbol,
        type: OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type
      }
    end
  end
end
