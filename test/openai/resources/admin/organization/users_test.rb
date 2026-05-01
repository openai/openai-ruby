# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::UsersTest < OpenAI::Test::ResourceTest
  def test_retrieve
    response = @openai.admin.organization.users.retrieve("user_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::OrganizationUser
    end

    assert_pattern do
      response => {
        id: String,
        added_at: Integer,
        email: String,
        name: String,
        object: Symbol,
        role: OpenAI::Admin::Organization::OrganizationUser::Role
      }
    end
  end

  def test_update
    response = @openai.admin.organization.users.update("user_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::OrganizationUser
    end

    assert_pattern do
      response => {
        id: String,
        added_at: Integer,
        email: String,
        name: String,
        object: Symbol,
        role: OpenAI::Admin::Organization::OrganizationUser::Role
      }
    end
  end

  def test_list
    response = @openai.admin.organization.users.list

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::OrganizationUser
    end

    assert_pattern do
      row => {
        id: String,
        added_at: Integer,
        email: String,
        name: String,
        object: Symbol,
        role: OpenAI::Admin::Organization::OrganizationUser::Role
      }
    end
  end

  def test_delete
    response = @openai.admin.organization.users.delete("user_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::UserDeleteResponse
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
