# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::DecisionsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.decisions.create(
      input: "string",
      model: "model",
      questions: [{instructions: "instructions", type: :predicate}]
    )

    assert_pattern do
      response => OpenAI::Decision
    end

    assert_pattern do
      response => {
          answers: ^(OpenAI::Internal::Type::ArrayOf[union: OpenAI::Decision::Answer]),
          model: String,
          usage: OpenAI::Decision::Usage
        }
    end
  end
end
