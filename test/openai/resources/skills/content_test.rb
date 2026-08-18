# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Skills::ContentTest < OpenAI::Test::ResourceTest
  def test_retrieve
    response = @openai.skills.content.retrieve("skill_123")

    assert_pattern do
      response => StringIO
    end
  end
end
