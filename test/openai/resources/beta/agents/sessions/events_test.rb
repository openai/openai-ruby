# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::Sessions::EventsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.agents.sessions.events.create(
      "session_id",
      events: [
        {
          request_id: "request_id",
          response: {
            action: "submit",
            fields: [{field_id: "field_id", value: "value"}],
            type: :browser_authentication
          },
          type: :"agent.session.input.computer_use_approval_request_result"
        }
      ]
    )

    assert_pattern do
      response => nil
    end
  end
end
