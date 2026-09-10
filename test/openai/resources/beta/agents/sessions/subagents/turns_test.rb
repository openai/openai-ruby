# frozen_string_literal: true

require_relative "../../../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::Sessions::Subagents::TurnsTest < OpenAI::Test::ResourceTest
  def test_retrieve_required_params
    response = @openai.beta.agents.sessions.subagents.turns.retrieve(
      "turn_id",
      session_id: "session_id",
      subagent_id: "subagent_id"
    )

    assert_pattern do
      response => OpenAI::Beta::Agents::Sessions::Turn
    end

    assert_pattern do
      response => {
          id: String,
          agent_id: String,
          completed_at: Integer | nil,
          created_at: Integer,
          error: OpenAI::Beta::SessionTurnError | nil,
          object: Symbol,
          session_id: String,
          started_at: Integer | nil,
          status: OpenAI::Beta::Agents::Sessions::Turn::Status,
          subagent_id: String | nil,
          usage: OpenAI::Beta::TokenUsage | nil
        }
    end
  end

  def test_list_required_params
    response = @openai.beta.agents.sessions.subagents.turns.list("subagent_id", session_id: "session_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::Agents::Sessions::Turn
    end

    assert_pattern do
      row => {
          id: String,
          agent_id: String,
          completed_at: Integer | nil,
          created_at: Integer,
          error: OpenAI::Beta::SessionTurnError | nil,
          object: Symbol,
          session_id: String,
          started_at: Integer | nil,
          status: OpenAI::Beta::Agents::Sessions::Turn::Status,
          subagent_id: String | nil,
          usage: OpenAI::Beta::TokenUsage | nil
        }
    end
  end
end
