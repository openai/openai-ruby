# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::FineTuning::Checkpoints::PermissionsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response =
      @openai.fine_tuning.checkpoints.permissions.create(
        "ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd",
        project_ids: ["string"]
      )

    assert_pattern do
      response => OpenAI::Internal::Page
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Models::FineTuning::Checkpoints::PermissionCreateResponse
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        object: Symbol,
        project_id: String
      }
    end
  end

  def test_retrieve
    response = @openai.fine_tuning.checkpoints.permissions.retrieve("ft-AF1WoRqd3aJAHsqc9NY7iL8F")

    assert_pattern do
      response => OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveResponse
    end

    assert_pattern do
      response => {
        data: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveResponse::Data]),
        has_more: OpenAI::Internal::Type::Boolean,
        object: Symbol,
        first_id: String | nil,
        last_id: String | nil
      }
    end
  end

  def test_delete
    response =
      @openai.fine_tuning.checkpoints.permissions.delete("ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd")

    assert_pattern do
      response => OpenAI::Models::FineTuning::Checkpoints::PermissionDeleteResponse
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
