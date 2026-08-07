# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::CompletionsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.completions.create(model: :"gpt-3.5-turbo-instruct", prompt: "This is a test.")

    assert_pattern do
      response => OpenAI::Completion
    end

    assert_pattern do
      response => {
        id: String,
        choices: ^(OpenAI::Internal::Type::ArrayOf[OpenAI::CompletionChoice]),
        created: Integer,
        model: String,
        object: Symbol,
        system_fingerprint: String | nil,
        usage: OpenAI::CompletionUsage | nil
      }
    end
  end
end
