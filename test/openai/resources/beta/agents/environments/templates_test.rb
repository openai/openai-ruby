# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::Environments::TemplatesTest < OpenAI::Test::ResourceTest
  def test_create
    response = @openai.beta.agents.environments.templates.create

    assert_pattern do
      response => OpenAI::Beta::Agents::Environments::EnvironmentTemplate
    end

    assert_pattern do
      response => {
          id: String,
          capability_directories: ^(OpenAI::Internal::Type::ArrayOf[String]),
          created_at: Integer,
          files: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File]),
          name: String | nil,
          network: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network,
          object: Symbol,
          packages: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Packages,
          plugins: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::HostedPlugin]),
          skills: ^(OpenAI::Internal::Type::ArrayOf[
            union: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill
          ]),
          updated_at: Integer
        }
    end
  end

  def test_retrieve
    response = @openai.beta.agents.environments.templates.retrieve("environment_template_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Environments::EnvironmentTemplate
    end

    assert_pattern do
      response => {
          id: String,
          capability_directories: ^(OpenAI::Internal::Type::ArrayOf[String]),
          created_at: Integer,
          files: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File]),
          name: String | nil,
          network: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network,
          object: Symbol,
          packages: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Packages,
          plugins: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::HostedPlugin]),
          skills: ^(OpenAI::Internal::Type::ArrayOf[
            union: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill
          ]),
          updated_at: Integer
        }
    end
  end

  def test_update
    response = @openai.beta.agents.environments.templates.update("environment_template_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Environments::EnvironmentTemplate
    end

    assert_pattern do
      response => {
          id: String,
          capability_directories: ^(OpenAI::Internal::Type::ArrayOf[String]),
          created_at: Integer,
          files: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File]),
          name: String | nil,
          network: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network,
          object: Symbol,
          packages: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Packages,
          plugins: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::HostedPlugin]),
          skills: ^(OpenAI::Internal::Type::ArrayOf[
            union: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill
          ]),
          updated_at: Integer
        }
    end
  end

  def test_list
    response = @openai.beta.agents.environments.templates.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::Agents::Environments::EnvironmentTemplate
    end

    assert_pattern do
      row => {
          id: String,
          capability_directories: ^(OpenAI::Internal::Type::ArrayOf[String]),
          created_at: Integer,
          files: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::File]),
          name: String | nil,
          network: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Network,
          object: Symbol,
          packages: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Packages,
          plugins: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::HostedPlugin]),
          skills: ^(OpenAI::Internal::Type::ArrayOf[
            union: OpenAI::Beta::Agents::Environments::EnvironmentTemplate::Skill
          ]),
          updated_at: Integer
        }
    end
  end

  def test_delete
    response = @openai.beta.agents.environments.templates.delete("environment_template_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::Environments::EnvironmentTemplateDeleted
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
