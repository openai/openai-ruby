# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Chat::CompletionsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.chat.completions.create(
      messages: [{content: "string", role: :developer}],
      model: :"gpt-4o",
      stream: true
    )

    assert_pattern do
      response => OpenAI::Models::Chat::ChatCompletion
    end

    assert_pattern do
      response => {
        id: String,
        choices: ^(OpenAI::ArrayOf[OpenAI::Models::Chat::ChatCompletion::Choice]),
        created: Integer,
        model: String,
        object: Symbol,
        service_tier: OpenAI::Models::Chat::ChatCompletion::ServiceTier | nil,
        system_fingerprint: String | nil,
        usage: OpenAI::Models::CompletionUsage | nil
      }
    end
  end
end
