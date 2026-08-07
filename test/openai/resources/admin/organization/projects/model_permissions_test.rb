# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::ModelPermissionsTest < OpenAI::Test::ResourceTest
  def test_retrieve
    response = @openai.admin.organization.projects.model_permissions.retrieve("project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectModelPermissions
    end

    assert_pattern do
      response => {
        mode: OpenAI::Admin::Organization::Projects::ProjectModelPermissions::Mode,
        model_ids: ^(OpenAI::Internal::Type::ArrayOf[String]),
        object: Symbol
      }
    end
  end

  def test_update_required_params
    response =
      @openai.admin.organization.projects.model_permissions.update(
        "project_id",
        mode: :allow_list,
        model_ids: ["string"]
      )

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectModelPermissions
    end

    assert_pattern do
      response => {
        mode: OpenAI::Admin::Organization::Projects::ProjectModelPermissions::Mode,
        model_ids: ^(OpenAI::Internal::Type::ArrayOf[String]),
        object: Symbol
      }
    end
  end

  def test_delete
    response = @openai.admin.organization.projects.model_permissions.delete("project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectModelPermissionsDeleted
    end

    assert_pattern do
      response => {
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol
      }
    end
  end
end
