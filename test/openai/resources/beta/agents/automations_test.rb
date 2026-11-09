# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::AutomationsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.agents.automations.create(
      create_automation_params: {
        expression: "x",
        name: "x",
        target: {
          environment: {type: :none},
          input: [{content: [{text: "text", type: :input_text}], role: :user}],
          type: :new_session
        },
        timezone: "x",
        type: :periodic
      }
    )

    assert_pattern do
      response => OpenAI::Beta::Agents::Automation
    end

    assert_pattern do
      case response
      in (
        OpenAI::Beta::Agents::PeriodicAutomation | OpenAI::Beta::Agents::OneTimeAutomation
      )
        nil
      end
    end

    assert_pattern do
      case response
      in (
        {
            type: :periodic,
            id: String,
            created_at: Integer,
            created_by: OpenAI::Beta::Agents::AutomationCreatedBy,
            expression: String,
            metadata: ^(OpenAI::Internal::Type::HashOf[String]),
            name: String,
            object: Symbol,
            status: OpenAI::Beta::Agents::PeriodicAutomation::Status,
            target: OpenAI::Beta::Agents::AutomationTarget,
            timezone: String
          } | {
            type: :once,
            id: String,
            created_at: Integer,
            created_by: OpenAI::Beta::Agents::AutomationCreatedBy,
            metadata: ^(OpenAI::Internal::Type::HashOf[String]),
            name: String,
            object: Symbol,
            run_at: Integer,
            status: OpenAI::Beta::Agents::OneTimeAutomation::Status,
            target: OpenAI::Beta::Agents::AutomationTarget
          }
      )
        nil
      end
    end
  end

  def test_retrieve
    response = @openai.beta.agents.automations.retrieve("automation_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Automation
    end

    assert_pattern do
      case response
      in (
        OpenAI::Beta::Agents::PeriodicAutomation | OpenAI::Beta::Agents::OneTimeAutomation
      )
        nil
      end
    end

    assert_pattern do
      case response
      in (
        {
            type: :periodic,
            id: String,
            created_at: Integer,
            created_by: OpenAI::Beta::Agents::AutomationCreatedBy,
            expression: String,
            metadata: ^(OpenAI::Internal::Type::HashOf[String]),
            name: String,
            object: Symbol,
            status: OpenAI::Beta::Agents::PeriodicAutomation::Status,
            target: OpenAI::Beta::Agents::AutomationTarget,
            timezone: String
          } | {
            type: :once,
            id: String,
            created_at: Integer,
            created_by: OpenAI::Beta::Agents::AutomationCreatedBy,
            metadata: ^(OpenAI::Internal::Type::HashOf[String]),
            name: String,
            object: Symbol,
            run_at: Integer,
            status: OpenAI::Beta::Agents::OneTimeAutomation::Status,
            target: OpenAI::Beta::Agents::AutomationTarget
          }
      )
        nil
      end
    end
  end

  def test_update
    response = @openai.beta.agents.automations.update("automation_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Automation
    end

    assert_pattern do
      case response
      in (
        OpenAI::Beta::Agents::PeriodicAutomation | OpenAI::Beta::Agents::OneTimeAutomation
      )
        nil
      end
    end

    assert_pattern do
      case response
      in (
        {
            type: :periodic,
            id: String,
            created_at: Integer,
            created_by: OpenAI::Beta::Agents::AutomationCreatedBy,
            expression: String,
            metadata: ^(OpenAI::Internal::Type::HashOf[String]),
            name: String,
            object: Symbol,
            status: OpenAI::Beta::Agents::PeriodicAutomation::Status,
            target: OpenAI::Beta::Agents::AutomationTarget,
            timezone: String
          } | {
            type: :once,
            id: String,
            created_at: Integer,
            created_by: OpenAI::Beta::Agents::AutomationCreatedBy,
            metadata: ^(OpenAI::Internal::Type::HashOf[String]),
            name: String,
            object: Symbol,
            run_at: Integer,
            status: OpenAI::Beta::Agents::OneTimeAutomation::Status,
            target: OpenAI::Beta::Agents::AutomationTarget
          }
      )
        nil
      end
    end
  end

  def test_list
    response = @openai.beta.agents.automations.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    # Validate this response only; pagination is covered with finite fixtures.
    row = response.data&.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::Agents::Automation
    end

    assert_pattern do
      case row
      in (
        OpenAI::Beta::Agents::PeriodicAutomation | OpenAI::Beta::Agents::OneTimeAutomation
      )
        nil
      end
    end

    assert_pattern do
      case row
      in (
        {
            type: :periodic,
            id: String,
            created_at: Integer,
            created_by: OpenAI::Beta::Agents::AutomationCreatedBy,
            expression: String,
            metadata: ^(OpenAI::Internal::Type::HashOf[String]),
            name: String,
            object: Symbol,
            status: OpenAI::Beta::Agents::PeriodicAutomation::Status,
            target: OpenAI::Beta::Agents::AutomationTarget,
            timezone: String
          } | {
            type: :once,
            id: String,
            created_at: Integer,
            created_by: OpenAI::Beta::Agents::AutomationCreatedBy,
            metadata: ^(OpenAI::Internal::Type::HashOf[String]),
            name: String,
            object: Symbol,
            run_at: Integer,
            status: OpenAI::Beta::Agents::OneTimeAutomation::Status,
            target: OpenAI::Beta::Agents::AutomationTarget
          }
      )
        nil
      end
    end
  end

  def test_delete
    response = @openai.beta.agents.automations.delete("automation_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::AutomationDeleted
    end

    assert_pattern do
      response => {
          id: String,
          deleted: OpenAI::Internal::Type::Boolean,
          object: Symbol
        }
    end
  end

  def test_pause
    response = @openai.beta.agents.automations.pause("automation_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Automation
    end

    assert_pattern do
      case response
      in (
        OpenAI::Beta::Agents::PeriodicAutomation | OpenAI::Beta::Agents::OneTimeAutomation
      )
        nil
      end
    end

    assert_pattern do
      case response
      in (
        {
            type: :periodic,
            id: String,
            created_at: Integer,
            created_by: OpenAI::Beta::Agents::AutomationCreatedBy,
            expression: String,
            metadata: ^(OpenAI::Internal::Type::HashOf[String]),
            name: String,
            object: Symbol,
            status: OpenAI::Beta::Agents::PeriodicAutomation::Status,
            target: OpenAI::Beta::Agents::AutomationTarget,
            timezone: String
          } | {
            type: :once,
            id: String,
            created_at: Integer,
            created_by: OpenAI::Beta::Agents::AutomationCreatedBy,
            metadata: ^(OpenAI::Internal::Type::HashOf[String]),
            name: String,
            object: Symbol,
            run_at: Integer,
            status: OpenAI::Beta::Agents::OneTimeAutomation::Status,
            target: OpenAI::Beta::Agents::AutomationTarget
          }
      )
        nil
      end
    end
  end

  def test_resume
    response = @openai.beta.agents.automations.resume("automation_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Automation
    end

    assert_pattern do
      case response
      in (
        OpenAI::Beta::Agents::PeriodicAutomation | OpenAI::Beta::Agents::OneTimeAutomation
      )
        nil
      end
    end

    assert_pattern do
      case response
      in (
        {
            type: :periodic,
            id: String,
            created_at: Integer,
            created_by: OpenAI::Beta::Agents::AutomationCreatedBy,
            expression: String,
            metadata: ^(OpenAI::Internal::Type::HashOf[String]),
            name: String,
            object: Symbol,
            status: OpenAI::Beta::Agents::PeriodicAutomation::Status,
            target: OpenAI::Beta::Agents::AutomationTarget,
            timezone: String
          } | {
            type: :once,
            id: String,
            created_at: Integer,
            created_by: OpenAI::Beta::Agents::AutomationCreatedBy,
            metadata: ^(OpenAI::Internal::Type::HashOf[String]),
            name: String,
            object: Symbol,
            run_at: Integer,
            status: OpenAI::Beta::Agents::OneTimeAutomation::Status,
            target: OpenAI::Beta::Agents::AutomationTarget
          }
      )
        nil
      end
    end
  end
end
