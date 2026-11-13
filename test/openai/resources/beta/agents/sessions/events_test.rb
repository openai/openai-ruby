# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::Sessions::EventsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.agents.sessions.events.create(
      "session_id",
      events: [
        {
          request_id: "request_id",
          response: {decision: "approve", type: :mcp_tool_call},
          type: :"agent.session.input.mcp_approval_request_result"
        }
      ]
    )

    assert_pattern do
      response => nil
    end
  end
end
