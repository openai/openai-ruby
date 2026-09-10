# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Beta::AgentsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.agents.create(model: "model")

    assert_pattern do
      response => OpenAI::Beta::Agent
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          instructions: String | nil,
          metadata: ^(OpenAI::Internal::Type::HashOf[String]),
          model: String,
          multi_agent: OpenAI::Beta::MultiAgentConfig,
          name: String | nil,
          object: Symbol,
          reasoning: OpenAI::Beta::AgentReasoning,
          service_tier: OpenAI::Beta::Agent::ServiceTier,
          text: OpenAI::Beta::AgentText,
          tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::PersistedAgentTool]),
          updated_at: Integer
        }
    end
  end

  def test_retrieve
    response = @openai.beta.agents.retrieve("agent_id")

    assert_pattern do
      response => OpenAI::Beta::Agent
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          instructions: String | nil,
          metadata: ^(OpenAI::Internal::Type::HashOf[String]),
          model: String,
          multi_agent: OpenAI::Beta::MultiAgentConfig,
          name: String | nil,
          object: Symbol,
          reasoning: OpenAI::Beta::AgentReasoning,
          service_tier: OpenAI::Beta::Agent::ServiceTier,
          text: OpenAI::Beta::AgentText,
          tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::PersistedAgentTool]),
          updated_at: Integer
        }
    end
  end

  def test_update
    response = @openai.beta.agents.update("agent_id")

    assert_pattern do
      response => OpenAI::Beta::Agent
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          instructions: String | nil,
          metadata: ^(OpenAI::Internal::Type::HashOf[String]),
          model: String,
          multi_agent: OpenAI::Beta::MultiAgentConfig,
          name: String | nil,
          object: Symbol,
          reasoning: OpenAI::Beta::AgentReasoning,
          service_tier: OpenAI::Beta::Agent::ServiceTier,
          text: OpenAI::Beta::AgentText,
          tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::PersistedAgentTool]),
          updated_at: Integer
        }
    end
  end

  def test_list
    response = @openai.beta.agents.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::Agent
    end

    assert_pattern do
      row => {
          id: String,
          created_at: Integer,
          instructions: String | nil,
          metadata: ^(OpenAI::Internal::Type::HashOf[String]),
          model: String,
          multi_agent: OpenAI::Beta::MultiAgentConfig,
          name: String | nil,
          object: Symbol,
          reasoning: OpenAI::Beta::AgentReasoning,
          service_tier: OpenAI::Beta::Agent::ServiceTier,
          text: OpenAI::Beta::AgentText,
          tools: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::PersistedAgentTool]),
          updated_at: Integer
        }
    end
  end

  def test_delete
    response = @openai.beta.agents.delete("agent_id")

    assert_pattern do
      response => OpenAI::Beta::AgentDeleted
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
