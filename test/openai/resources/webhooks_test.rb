# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::WebhooksTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.webhooks.create(event_types: [:"batch.completed"], name: "x", url: "https://")

    assert_pattern do
      response => OpenAI::Webhooks::WebhookEndpointWithSecret
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          event_types: ^(OpenAI::Internal::Type::ArrayOf[String]),
          name: String,
          object: Symbol,
          signing_secret: String,
          signing_secret_hint: String | nil,
          url: String,
          updated_at: Integer | nil
        }
    end
  end

  def test_retrieve
    response = @openai.webhooks.retrieve("whe_123")

    assert_pattern do
      response => OpenAI::Webhooks::WebhookEndpoint
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          event_types: ^(OpenAI::Internal::Type::ArrayOf[String]),
          name: String,
          object: Symbol,
          signing_secret_hint: String | nil,
          url: String,
          updated_at: Integer | nil
        }
    end
  end

  def test_update
    response = @openai.webhooks.update("whe_123")

    assert_pattern do
      response => OpenAI::Webhooks::WebhookEndpoint
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          event_types: ^(OpenAI::Internal::Type::ArrayOf[String]),
          name: String,
          object: Symbol,
          signing_secret_hint: String | nil,
          url: String,
          updated_at: Integer | nil
        }
    end
  end

  def test_list
    response = @openai.webhooks.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Webhooks::WebhookEndpoint
    end

    assert_pattern do
      row => {
          id: String,
          created_at: Integer,
          event_types: ^(OpenAI::Internal::Type::ArrayOf[String]),
          name: String,
          object: Symbol,
          signing_secret_hint: String | nil,
          url: String,
          updated_at: Integer | nil
        }
    end
  end

  def test_delete
    response = @openai.webhooks.delete("whe_123")

    assert_pattern do
      response => OpenAI::Webhooks::DeletedWebhookEndpoint
    end

    assert_pattern do
      response => {
          id: String,
          deleted: OpenAI::Internal::Type::Boolean,
          object: Symbol
        }
    end
  end

  def test_rotate_secret
    response = @openai.webhooks.rotate_secret("whe_123")

    assert_pattern do
      response => OpenAI::Webhooks::WebhookEndpointWithSecret
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          event_types: ^(OpenAI::Internal::Type::ArrayOf[String]),
          name: String,
          object: Symbol,
          signing_secret: String,
          signing_secret_hint: String | nil,
          url: String,
          updated_at: Integer | nil
        }
    end
  end

  def test_test__required_params
    response = @openai.webhooks.test_("whe_123", event_type: :"batch.completed")

    assert_pattern do
      response => OpenAI::Webhooks::WebhookEndpointTestResult
    end

    assert_pattern do
      response => {
          event_type: String,
          object: Symbol,
          status_code: Integer,
          success: OpenAI::Internal::Type::Boolean,
          webhook_endpoint_id: String
        }
    end
  end
end
