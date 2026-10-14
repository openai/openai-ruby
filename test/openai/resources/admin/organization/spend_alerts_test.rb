# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::SpendAlertsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response =
      @openai.admin.organization.spend_alerts.create(
        currency: :USD,
        interval: :month,
        notification_channel: {recipients: ["string"], type: :email},
        threshold_amount: 0
      )

    assert_pattern do
      response => OpenAI::Admin::Organization::OrganizationSpendAlert
    end

    assert_pattern do
      response => {
        id: String,
        currency: OpenAI::Admin::Organization::OrganizationSpendAlert::Currency,
        interval: OpenAI::Admin::Organization::OrganizationSpendAlert::Interval,
        notification_channel: OpenAI::Admin::Organization::OrganizationSpendAlert::NotificationChannel,
        object: Symbol,
        threshold_amount: Integer
      }
    end
  end

  def test_retrieve
    response = @openai.admin.organization.spend_alerts.retrieve("alert_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::OrganizationSpendAlert
    end

    assert_pattern do
      response => {
        id: String,
        currency: OpenAI::Admin::Organization::OrganizationSpendAlert::Currency,
        interval: OpenAI::Admin::Organization::OrganizationSpendAlert::Interval,
        notification_channel: OpenAI::Admin::Organization::OrganizationSpendAlert::NotificationChannel,
        object: Symbol,
        threshold_amount: Integer
      }
    end
  end

  def test_update_required_params
    response =
      @openai.admin.organization.spend_alerts.update(
        "alert_id",
        currency: :USD,
        interval: :month,
        notification_channel: {recipients: ["string"], type: :email},
        threshold_amount: 0
      )

    assert_pattern do
      response => OpenAI::Admin::Organization::OrganizationSpendAlert
    end

    assert_pattern do
      response => {
        id: String,
        currency: OpenAI::Admin::Organization::OrganizationSpendAlert::Currency,
        interval: OpenAI::Admin::Organization::OrganizationSpendAlert::Interval,
        notification_channel: OpenAI::Admin::Organization::OrganizationSpendAlert::NotificationChannel,
        object: Symbol,
        threshold_amount: Integer
      }
    end
  end

  def test_list
    response = @openai.admin.organization.spend_alerts.list

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::OrganizationSpendAlert
    end

    assert_pattern do
      row => {
        id: String,
        currency: OpenAI::Admin::Organization::OrganizationSpendAlert::Currency,
        interval: OpenAI::Admin::Organization::OrganizationSpendAlert::Interval,
        notification_channel: OpenAI::Admin::Organization::OrganizationSpendAlert::NotificationChannel,
        object: Symbol,
        threshold_amount: Integer
      }
    end
  end

  def test_delete
    response = @openai.admin.organization.spend_alerts.delete("alert_id")

    assert_pattern do
      response => OpenAI::Admin::Organization::OrganizationSpendAlertDeleted
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
