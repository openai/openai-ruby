# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::SessionsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.agents.sessions.create(environment: {type: :none})

    assert_pattern do
      response => OpenAI::Beta::AgentSession
    end

    assert_pattern do
      response => {
          id: String,
          agent: OpenAI::Beta::AgentSession::Agent,
          created_at: Integer,
          environment: OpenAI::Beta::Environment,
          error: String | nil,
          last_active_at: Integer,
          metadata: ^(OpenAI::Internal::Type::HashOf[String]),
          object: Symbol,
          required_actions: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentSession::RequiredAction]),
          status: OpenAI::Beta::AgentSession::Status,
          usage: OpenAI::Beta::TokenUsage | nil,
          vault_ids: ^(OpenAI::Internal::Type::ArrayOf[String])
        }
    end
  end

  def test_retrieve
    response = @openai.beta.agents.sessions.retrieve("session_id")

    assert_pattern do
      response => OpenAI::Beta::AgentSession
    end

    assert_pattern do
      response => {
          id: String,
          agent: OpenAI::Beta::AgentSession::Agent,
          created_at: Integer,
          environment: OpenAI::Beta::Environment,
          error: String | nil,
          last_active_at: Integer,
          metadata: ^(OpenAI::Internal::Type::HashOf[String]),
          object: Symbol,
          required_actions: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentSession::RequiredAction]),
          status: OpenAI::Beta::AgentSession::Status,
          usage: OpenAI::Beta::TokenUsage | nil,
          vault_ids: ^(OpenAI::Internal::Type::ArrayOf[String])
        }
    end
  end

  def test_update
    response = @openai.beta.agents.sessions.update("session_id")

    assert_pattern do
      response => OpenAI::Beta::AgentSession
    end

    assert_pattern do
      response => {
          id: String,
          agent: OpenAI::Beta::AgentSession::Agent,
          created_at: Integer,
          environment: OpenAI::Beta::Environment,
          error: String | nil,
          last_active_at: Integer,
          metadata: ^(OpenAI::Internal::Type::HashOf[String]),
          object: Symbol,
          required_actions: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentSession::RequiredAction]),
          status: OpenAI::Beta::AgentSession::Status,
          usage: OpenAI::Beta::TokenUsage | nil,
          vault_ids: ^(OpenAI::Internal::Type::ArrayOf[String])
        }
    end
  end

  def test_list
    response = @openai.beta.agents.sessions.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::AgentSession
    end

    assert_pattern do
      row => {
          id: String,
          agent: OpenAI::Beta::AgentSession::Agent,
          created_at: Integer,
          environment: OpenAI::Beta::Environment,
          error: String | nil,
          last_active_at: Integer,
          metadata: ^(OpenAI::Internal::Type::HashOf[String]),
          object: Symbol,
          required_actions: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentSession::RequiredAction]),
          status: OpenAI::Beta::AgentSession::Status,
          usage: OpenAI::Beta::TokenUsage | nil,
          vault_ids: ^(OpenAI::Internal::Type::ArrayOf[String])
        }
    end
  end

  def test_delete
    response = @openai.beta.agents.sessions.delete("session_id")

    assert_pattern do
      response => OpenAI::Beta::AgentSessionDeleted
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
