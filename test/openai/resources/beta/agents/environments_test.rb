# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::EnvironmentsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.agents.environments.create(environment: {type: :openai_hosted})

    assert_pattern do
      response => OpenAI::Beta::Agents::EnvironmentInfo
    end

    assert_pattern do
      response => {
          id: String,
          files: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedEnvironmentFile]),
          object: Symbol,
          plugins: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::HostedPlugin]),
          skills: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedSkill]),
          status: OpenAI::Beta::Agents::EnvironmentInfo::Status,
          type: OpenAI::Beta::Agents::EnvironmentInfo::Type
        }
    end
  end

  def test_retrieve
    response = @openai.beta.agents.environments.retrieve("environment_id")

    assert_pattern do
      response => OpenAI::Beta::Agents::EnvironmentInfo
    end

    assert_pattern do
      response => {
          id: String,
          files: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedEnvironmentFile]),
          object: Symbol,
          plugins: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::HostedPlugin]),
          skills: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedSkill]),
          status: OpenAI::Beta::Agents::EnvironmentInfo::Status,
          type: OpenAI::Beta::Agents::EnvironmentInfo::Type
        }
    end
  end

  def test_list
    response = @openai.beta.agents.environments.list

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::Agents::EnvironmentInfo
    end

    assert_pattern do
      row => {
          id: String,
          files: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedEnvironmentFile]),
          object: Symbol,
          plugins: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::HostedPlugin]),
          skills: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::HostedSkill]),
          status: OpenAI::Beta::Agents::EnvironmentInfo::Status,
          type: OpenAI::Beta::Agents::EnvironmentInfo::Type
        }
    end
  end
end
