# frozen_string_literal: true

require_relative "agent_turn_result_test"

class OpenAI::Test::AgentSessionErrorEventTest < Minitest::Test
  def test_both_raw_endpoints_preserve_a_session_error_before_an_unknown_frame_and_idle
    [false, true].each do |creation|
      server = OpenAI::Test::AgentTurnResultTest::Server.new(
        [
          {
            type: "error",
            session_id: "session_test",
            error: {type: "session_error", code: "fixture_error", message: "Session reported an error.", param: nil}
          },
          {type: "agent.session.future", payload: {example: "future event"}},
          {type: "agent.session.idle", session: {id: "session_test", status: "idle"}}
        ]
      )
      sessions = OpenAI::Client
        .new(api_key: "fake-key", base_url: "https://sdk-test.example/v1", http_client: server, max_retries: 0)
        .beta
        .agents
        .sessions
      subject = if creation
        sessions.create_streaming(agent: {model: "test-model"}, environment: {type: :none}, input: "Hello")
      else
        sessions.events.stream_streaming("session_test")
      end

      events = subject.to_a

      assert_equal(:error, events.first.type)
      assert_instance_of(Hash, events[1])
      assert_equal("agent.session.future", events[1].fetch(:type))
      assert_equal({example: "future event"}, events[1].fetch(:payload))
      assert_instance_of(OpenAI::Models::Beta::AgentSessionErrorEvent, events.first)
      assert_equal("0", events.first.event_id)
      assert_equal("session_test", events.first.session_id)
      assert_equal("session_error", events.first.error.type)
      assert_equal("fixture_error", events.first.error.code)
      assert_equal("Session reported an error.", events.first.error.message)
      assert_nil(events.first.error.param)
      assert_instance_of(OpenAI::Models::Beta::AgentSessionIdleEvent, events.last)
      assert_equal("2", events.last.event_id)
      subject.close
      assert(server.body.closed)
    end
  end
end
