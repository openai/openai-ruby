# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::Environments::FilesTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.agents.environments.files.create(
      "environment_id",
      hosted_environment_file_param: {file_id: "file_id", path: "path", type: :file_id}
    )

    assert_pattern do
      response => OpenAI::Beta::Agents::Environments::EnvironmentFile
    end

    assert_pattern do
      response => {
          environment_id: String,
          object: Symbol,
          path: String,
          size_bytes: Integer
        }
    end
  end

  def test_list
    response = @openai.beta.agents.environments.files.list("environment_id")

    assert_pattern do
      response => OpenAI::Internal::TokenPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::Agents::Environments::EnvironmentFile
    end

    assert_pattern do
      row => {
          environment_id: String,
          object: Symbol,
          path: String,
          size_bytes: Integer
        }
    end
  end
end
