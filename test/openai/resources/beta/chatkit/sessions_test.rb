# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Beta::ChatKit::SessionsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.chatkit.sessions.create(user: "x", workflow: {id: "id"})

    assert_pattern do
      response => OpenAI::Beta::ChatKit::ChatSession
    end

    assert_pattern do
      response => {
        id: String,
        chatkit_configuration: OpenAI::Beta::ChatKit::ChatSessionChatKitConfiguration,
        client_secret: String,
        expires_at: Integer,
        max_requests_per_1_minute: Integer,
        object: Symbol,
        rate_limits: OpenAI::Beta::ChatKit::ChatSessionRateLimits,
        status: OpenAI::Beta::ChatKit::ChatSessionStatus,
        user: String,
        workflow: OpenAI::Beta::ChatKitWorkflow
      }
    end
  end

  def test_cancel
    response = @openai.beta.chatkit.sessions.cancel("cksess_123")

    assert_pattern do
      response => OpenAI::Beta::ChatKit::ChatSession
    end

    assert_pattern do
      response => {
        id: String,
        chatkit_configuration: OpenAI::Beta::ChatKit::ChatSessionChatKitConfiguration,
        client_secret: String,
        expires_at: Integer,
        max_requests_per_1_minute: Integer,
        object: Symbol,
        rate_limits: OpenAI::Beta::ChatKit::ChatSessionRateLimits,
        status: OpenAI::Beta::ChatKit::ChatSessionStatus,
        user: String,
        workflow: OpenAI::Beta::ChatKitWorkflow
      }
    end
  end
end
