# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::Sessions::SubagentsTest < OpenAI::Test::ResourceTest
  def test_retrieve_required_params
    response = @openai.beta.agents.sessions.subagents.retrieve("subagent_id", session_id: "session_id")

    assert_pattern do
      response => OpenAI::Beta::Subagent
    end

    assert_pattern do
      response => {
          id: String,
          closed_at: Integer | nil,
          instructions: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentContent]) | nil,
          name: String | nil,
          object: Symbol,
          opened_at: Integer,
          parent_agent_id: String,
          session_id: String,
          status: OpenAI::Beta::Subagent::Status
        }
    end
  end

  def test_list
    response = @openai.beta.agents.sessions.subagents.list("session_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::Subagent
    end

    assert_pattern do
      row => {
          id: String,
          closed_at: Integer | nil,
          instructions: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::AgentContent]) | nil,
          name: String | nil,
          object: Symbol,
          opened_at: Integer,
          parent_agent_id: String,
          session_id: String,
          status: OpenAI::Beta::Subagent::Status
        }
    end
  end
end
