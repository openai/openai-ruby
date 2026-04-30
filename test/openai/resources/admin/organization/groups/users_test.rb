# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Groups::UsersTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.admin.organization.groups.users.create("group_id", user_id: "user_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Groups::UserCreateResponse
    end

    assert_pattern do
      response => {
        group_id: String,
        object: Symbol,
        user_id: String
      }
    end
  end

  def test_list
    response = @openai.admin.organization.groups.users.list("group_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
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

  def test_delete_required_params
    response = @openai.admin.organization.groups.users.delete("user_id", group_id: "group_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Groups::UserDeleteResponse
    end

    assert_pattern do
      response => {
        deleted: OpenAI::Internal::Type::Boolean,
        object: Symbol
      }
    end
  end
end
