# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::Resources::ModerationsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.moderations.create(input: "I want to kill them.")

    assert_pattern do
      response => OpenAI::Models::ModerationCreateResponse
    end

    assert_pattern do
      response => {
        id: String,
        model: String,
        results: ^(OpenAI::ArrayOf[OpenAI::Models::Moderation])
      }
    end
  end
end
