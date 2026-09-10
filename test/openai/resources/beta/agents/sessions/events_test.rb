# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Beta::Agents::Sessions::EventsTest < OpenAI::Test::ResourceTest
  def test_create_required_params
    response = @openai.beta.agents.sessions.events.create(
      "session_id",
      events: [
        {
          input: [{content: [{text: "text", type: :input_text}], role: :user}],
          type: :"agent.session.input.message"
        }
      ]
    )

    assert_pattern do
      response => nil
    end
  end
end
