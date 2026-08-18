# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Responses::InputTokensTest < OpenAI::Test::ResourceTest
  def test_count
    response = @openai.responses.input_tokens.count

    assert_pattern do
      response => OpenAI::Models::Responses::InputTokenCountResponse
    end

    assert_pattern do
      response => {
        input_tokens: Integer,
        object: Symbol
      }
    end
  end
end
