# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::GroupsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.admin.organization.groups.create(name: "x")

    assert_pattern do
      response => OpenAI::Admin::Organization::Group
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        is_scim_managed: OpenAI::Internal::Type::Boolean,
        name: String
      }
    end
  end

  def test_update_required_params
    response = @openai.admin.organization.groups.update("group_id", name: "x")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::GroupUpdateResponse
    end

    assert_pattern do
      response => {
        id: String,
        created_at: Integer,
        is_scim_managed: OpenAI::Internal::Type::Boolean,
        name: String
      }
    end
  end

  def test_list
    response = @openai.admin.organization.groups.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Group
    end

    assert_pattern do
      row => {
        id: String,
        created_at: Integer,
        is_scim_managed: OpenAI::Internal::Type::Boolean,
        name: String
      }
    end
  end

  def test_delete
    response = @openai.admin.organization.groups.delete("group_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::GroupDeleteResponse
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
