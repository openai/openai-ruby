# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::CompletionsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.completions.create(model: "string", prompt: "This is a test.", stream: true)

    assert_pattern do
      response => OpenAI::Models::Completion
    end

    assert_pattern do
      response => {
        id: String,
        choices: ^(OpenAI::ArrayOf[OpenAI::Models::CompletionChoice]),
        created: Integer,
        model: String,
        object: Symbol,
        system_fingerprint: String | nil,
        usage: OpenAI::Models::CompletionUsage | nil
      }
    end
  end
end
