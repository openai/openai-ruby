# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::AdminAPIKeysTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.admin.organization.admin_api_keys.create(name: "New Admin Key")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::AdminAPIKeyCreateResponse
    end
  end

  def test_retrieve
    response = @openai.admin.organization.admin_api_keys.retrieve("key_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::AdminAPIKey
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        last_used_at: Integer | nil,
        name: String,
        object: Symbol,
        owner: OpenAI::Admin::Organization::AdminAPIKey::Owner,
        redacted_value: String,
        value: String | nil
      }
    end
  end

  def test_list
    response = @openai.admin.organization.admin_api_keys.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::AdminAPIKey
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        last_used_at: Integer | nil,
        name: String,
        object: Symbol,
        owner: OpenAI::Admin::Organization::AdminAPIKey::Owner,
        redacted_value: String,
        value: String | nil
      }
    end
  end

  def test_delete
    response = @openai.admin.organization.admin_api_keys.delete("key_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::AdminAPIKeyDeleteResponse
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
