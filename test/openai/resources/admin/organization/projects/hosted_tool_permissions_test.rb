# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::HostedToolPermissionsTest < OpenAI::Test::ResourceTest
  def test_retrieve
    response = @openai.admin.organization.projects.hosted_tool_permissions.retrieve("project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions
    end

    assert_pattern do
      response => {
        code_interpreter: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter,
        file_search: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch,
        image_generation: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration,
        mcp: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp,
        web_search: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch
      }
    end
  end

  def test_update
    response = @openai.admin.organization.projects.hosted_tool_permissions.update("project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions
    end

    assert_pattern do
      response => {
        code_interpreter: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter,
        file_search: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch,
        image_generation: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration,
        mcp: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp,
        web_search: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch
      }
    end
  end
end
