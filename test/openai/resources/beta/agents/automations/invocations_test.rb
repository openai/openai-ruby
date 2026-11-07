# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::Automations::InvocationsTest < OpenAI::Test::ResourceTest
  def test_create
    response = @openai.beta.agents.automations.invocations.create("automation_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Automations::AutomationInvocation
    end

    assert_pattern do
      response => {
          id: String,
          automation_id: String,
          created_at: Integer,
          error: OpenAI::Beta::Agents::Automations::AutomationInvocation::Error | nil,
          object: Symbol,
          scheduled_at: Integer | nil,
          session_id: String | nil,
          skip_reason: Symbol | nil,
          source: OpenAI::Beta::Agents::Automations::AutomationInvocationSource,
          status: OpenAI::Beta::Agents::Automations::AutomationInvocation::Status
        }
    end
  end

  def test_retrieve_required_params
    response = @openai.beta.agents.automations.invocations.retrieve("invocation_id", automation_id: "automation_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Automations::AutomationInvocation
    end

    assert_pattern do
      response => {
          id: String,
          automation_id: String,
          created_at: Integer,
          error: OpenAI::Beta::Agents::Automations::AutomationInvocation::Error | nil,
          object: Symbol,
          scheduled_at: Integer | nil,
          session_id: String | nil,
          skip_reason: Symbol | nil,
          source: OpenAI::Beta::Agents::Automations::AutomationInvocationSource,
          status: OpenAI::Beta::Agents::Automations::AutomationInvocation::Status
        }
    end
  end

  def test_list
    response = @openai.beta.agents.automations.invocations.list("automation_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    # Validate this response only; pagination is covered with finite fixtures.
    row = response.data&.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::Agents::Automations::AutomationInvocation
    end

    assert_pattern do
      row => {
          id: String,
          automation_id: String,
          created_at: Integer,
          error: OpenAI::Beta::Agents::Automations::AutomationInvocation::Error | nil,
          object: Symbol,
          scheduled_at: Integer | nil,
          session_id: String | nil,
          skip_reason: Symbol | nil,
          source: OpenAI::Beta::Agents::Automations::AutomationInvocationSource,
          status: OpenAI::Beta::Agents::Automations::AutomationInvocation::Status
        }
    end
  end
end
