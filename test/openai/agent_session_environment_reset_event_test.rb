# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::AgentSessionEnvironmentResetEventTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def after_all
    WebMock.disable!
    super
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_reset_event_without_a_turn
    assert_reset_event(turn_id: nil, reset_count: 0)
  end

  def test_reset_event_with_a_turn
    assert_reset_event(turn_id: "turn_synthetic", reset_count: 7)
  end

  def test_suspended_and_expired_events_without_a_turn
    event_classes = {
      suspended: OpenAI::Beta::AgentSessionEnvironmentSuspendedEvent,
      expired: OpenAI::Beta::AgentSessionEnvironmentExpiredEvent
    }
    payloads = event_classes.map do |status, _event_class|
      {
        type: "agent.session.environment.#{status}",
        event_id: "event_#{status}",
        session_id: "session_synthetic",
        turn_id: nil,
        environment: {id: "ccarenv_synthetic", type: "openai_hosted", status: status, error: nil}
      }
    end

    request = stub_request(:get, "http://localhost/agents/sessions/session_synthetic/events").to_return(
      status: 200,
      headers: {"content-type" => "text/event-stream"},
      body: payloads.map { |payload| "data: #{JSON.generate(payload)}\n\n" }.join
    )
    client = OpenAI::Client.new(base_url: "http://localhost", api_key: "synthetic", max_retries: 0)
    stream = client.beta.agents.sessions.events.stream_streaming("session_synthetic")
    events = stream.to_a

    assert_equal(2, events.length)
    events.zip(event_classes, payloads).each do |event, (status, event_class), payload|
      assert_instance_of(event_class, event)
      assert_equal(:"agent.session.environment.#{status}", event.type)
      assert_nil(event.turn_id)
      assert_instance_of(OpenAI::Beta::AgentSessionEnvironmentState, event.environment)
      assert_equal(status, event.environment.status)
      assert_equal("ccarenv_synthetic", event.environment.id)
      assert_nil(event.environment.error)
      assert_equal(JSON.parse(JSON.generate(payload)), JSON.parse(event.to_json))
    end

    assert_requested(request, times: 1)
  ensure
    stream&.close
  end

  private

  def assert_reset_event(turn_id:, reset_count:)
    payload = {
      type: "agent.session.environment.reset",
      event_id: "event_synthetic",
      session_id: "session_synthetic",
      environment_id: "environment_synthetic",
      turn_id: turn_id,
      reset_count: reset_count
    }
    request = stub_request(:get, "http://localhost/agents/sessions/session_synthetic/events").to_return(
      status: 200,
      headers: {"content-type" => "text/event-stream"},
      body: "data: #{JSON.generate(payload)}\n\n"
    )
    client = OpenAI::Client.new(base_url: "http://localhost", api_key: "synthetic", max_retries: 0)
    stream = client.beta.agents.sessions.events.stream_streaming("session_synthetic")
    events = stream.to_a

    assert_equal(1, events.length)
    event = events.fetch(0)
    assert_instance_of(OpenAI::Beta::AgentSessionEnvironmentResetEvent, event)
    assert_equal(:"agent.session.environment.reset", event.type)
    assert_equal("event_synthetic", event.event_id)
    assert_equal("session_synthetic", event.session_id)
    assert_equal("environment_synthetic", event.environment_id)
    assert_equal(reset_count, event.reset_count)
    if turn_id.nil?
      assert_nil(event.turn_id)
    else
      assert_equal(turn_id, event.turn_id)
    end

    assert_requested(request, times: 1)
  ensure
    stream&.close
  end
end
