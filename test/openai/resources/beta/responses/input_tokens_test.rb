# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.

require_relative "../../../test_helper"

class OpenAI::Test::Resources::Beta::Responses::InputTokensTest < OpenAI::Test::ResourceTest
  def test_count
    response = @openai.beta.responses.input_tokens.count

    assert_pattern do
      response => OpenAI::Models::Beta::Responses::InputTokenCountResponse
    end

    assert_pattern do
      response => {
        input_tokens: Integer,
        object: Symbol
      }
    end
  end
end
