# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::ExternalStorageTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.admin.organization.external_storage.create(
      project_id: "proj_123",
      provider: {bucket: "bucket", role_arn: "role_arn", type: :aws}
    )

    assert_pattern do
      response => OpenAI::Admin::Organization::ExternalStorageConfiguration
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          geography: String,
          object: Symbol,
          project_id: String,
          provider: OpenAI::Admin::Organization::ExternalStorageConfiguration::Provider,
          status: OpenAI::Admin::Organization::ExternalStorageConfiguration::Status
        }
    end
  end

  def test_retrieve
    response = @openai.admin.organization.external_storage.retrieve("extstorage_123")

    assert_pattern do
      response => OpenAI::Admin::Organization::ExternalStorageConfiguration
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          geography: String,
          object: Symbol,
          project_id: String,
          provider: OpenAI::Admin::Organization::ExternalStorageConfiguration::Provider,
          status: OpenAI::Admin::Organization::ExternalStorageConfiguration::Status
        }
    end
  end

  def test_list
    response = @openai.admin.organization.external_storage.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::ExternalStorageConfiguration
    end

    assert_pattern do
      row => {
          id: String,
          created_at: Integer,
          geography: String,
          object: Symbol,
          project_id: String,
          provider: OpenAI::Admin::Organization::ExternalStorageConfiguration::Provider,
          status: OpenAI::Admin::Organization::ExternalStorageConfiguration::Status
        }
    end
  end

  def test_delete
    response = @openai.admin.organization.external_storage.delete("extstorage_123")

    assert_pattern do
      response => OpenAI::Admin::Organization::ExternalStorageDeleted
    end

    assert_pattern do
      response => {
          id: String,
          deleted: OpenAI::Internal::Type::Boolean,
          object: Symbol
        }
    end
  end

  def test_validate
    response = @openai.admin.organization.external_storage.validate("extstorage_123")

    assert_pattern do
      response => OpenAI::Admin::Organization::ExternalStorageConfiguration
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          geography: String,
          object: Symbol,
          project_id: String,
          provider: OpenAI::Admin::Organization::ExternalStorageConfiguration::Provider,
          status: OpenAI::Admin::Organization::ExternalStorageConfiguration::Status
        }
    end
  end
end
