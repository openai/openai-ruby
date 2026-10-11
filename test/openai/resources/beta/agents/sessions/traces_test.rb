# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::Sessions::TracesTest < OpenAI::Test::ResourceTest
  def test_list
    response = @openai.beta.agents.sessions.traces.list("session_id")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    # Validate this response only; pagination is covered with finite fixtures.
    row = response.data&.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Beta::Agents::Sessions::SessionTrace
    end

    assert_pattern do
      row => {
          id: String,
          created_at: Integer,
          object: Symbol,
          otlp: ^(OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]),
          session_id: String
        }
    end
  end
end
