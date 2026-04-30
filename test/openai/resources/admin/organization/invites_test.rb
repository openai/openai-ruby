# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::InvitesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.admin.organization.invites.create(email: "email", role: :reader)

    assert_pattern do
      response => OpenAI::Admin::Organization::Invite
    end

    assert_pattern do
      response => {
        id: String,
        email: String,
        expires_at: Integer,
        invited_at: Integer,
        object: Symbol,
        role: OpenAI::Admin::Organization::Invite::Role,
        status: OpenAI::Admin::Organization::Invite::Status,
        accepted_at: Integer | nil,
        projects: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Admin::Organization::Invite::Project]) | nil
      }
    end
  end

  def test_retrieve
    response = @openai.admin.organization.invites.retrieve("invite_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Invite
    end

    assert_pattern do
      response => {
        id: String,
        email: String,
        expires_at: Integer,
        invited_at: Integer,
        object: Symbol,
        role: OpenAI::Admin::Organization::Invite::Role,
        status: OpenAI::Admin::Organization::Invite::Status,
        accepted_at: Integer | nil,
        projects: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Admin::Organization::Invite::Project]) | nil
      }
    end
  end

  def test_list
    response = @openai.admin.organization.invites.list

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Invite
    end

    assert_pattern do
      row => {
        id: String,
        email: String,
        expires_at: Integer,
        invited_at: Integer,
        object: Symbol,
        role: OpenAI::Admin::Organization::Invite::Role,
        status: OpenAI::Admin::Organization::Invite::Status,
        accepted_at: Integer | nil,
        projects: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Admin::Organization::Invite::Project]) | nil
      }
    end
  end

  def test_delete
    response = @openai.admin.organization.invites.delete("invite_id")

    assert_pattern do
      response => OpenAI::Models::Admin::Organization::InviteDeleteResponse
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
