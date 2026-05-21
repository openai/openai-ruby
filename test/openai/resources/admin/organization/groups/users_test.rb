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

  def test_retrieve_required_params
    response = @openai.admin.organization.groups.users.retrieve("user_id", group_id: "group_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse
    end

    assert_pattern do
      response => {
        id: String,
        email: String | nil,
        is_service_account: OpenAI::Internal::Type::Boolean | nil,
        name: String,
        picture: String | nil,
        user_type: OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse::UserType
      }
    end
  end

  def test_list
    response = @openai.admin.organization.groups.users.list("group_id")

    assert_pattern do
      response => OpenAI::Internal::NextCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Groups::OrganizationGroupUser
    end

    assert_pattern do
      row => {
        id: String,
        email: String | nil,
        name: String
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
