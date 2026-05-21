# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::SpendAlertsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response =
      @openai.admin.organization.projects.spend_alerts.create(
        "project_id",
        currency: :USD,
        interval: :month,
        notification_channel: {recipients: ["string"], type: :email},
        threshold_amount: 0
      )

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectSpendAlert
    end

    assert_pattern do
      response => {
        id: String,
        currency: OpenAI::Admin::Organization::Projects::ProjectSpendAlert::Currency,
        interval: OpenAI::Admin::Organization::Projects::ProjectSpendAlert::Interval,
        notification_channel: OpenAI::Admin::Organization::Projects::ProjectSpendAlert::NotificationChannel,
        object: Symbol,
        threshold_amount: Integer
      }
    end
  end

  def test_update_required_params
    response =
      @openai.admin.organization.projects.spend_alerts.update(
        "alert_id",
        project_id: "project_id",
        currency: :USD,
        interval: :month,
        notification_channel: {recipients: ["string"], type: :email},
        threshold_amount: 0
      )

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectSpendAlert
    end

    assert_pattern do
      response => {
        id: String,
        currency: OpenAI::Admin::Organization::Projects::ProjectSpendAlert::Currency,
        interval: OpenAI::Admin::Organization::Projects::ProjectSpendAlert::Interval,
        notification_channel: OpenAI::Admin::Organization::Projects::ProjectSpendAlert::NotificationChannel,
        object: Symbol,
        threshold_amount: Integer
      }
    end
  end

  def test_list
    response = @openai.admin.organization.projects.spend_alerts.list("project_id")

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Projects::ProjectSpendAlert
    end

    assert_pattern do
      row => {
        id: String,
        currency: OpenAI::Admin::Organization::Projects::ProjectSpendAlert::Currency,
        interval: OpenAI::Admin::Organization::Projects::ProjectSpendAlert::Interval,
        notification_channel: OpenAI::Admin::Organization::Projects::ProjectSpendAlert::NotificationChannel,
        object: Symbol,
        threshold_amount: Integer
      }
    end
  end

  def test_delete_required_params
    response = @openai.admin.organization.projects.spend_alerts.delete("alert_id", project_id: "project_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectSpendAlertDeleted
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
