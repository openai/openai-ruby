# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::EnvironmentsTest < OpenAI::Test::ResourceTest
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
end
