# frozen_string_literal: true

require_relative "agent_turn_result_test"

class OpenAI::Test::AgentBudgetEventTest < Minitest::Test
  def configure(events)
    @server = OpenAI::Test::AgentTurnResultTest::Server.new(events)
    @sessions = OpenAI::Client
      .new(api_key: "fake-key", base_url: "https://sdk-test.example/v1", http_client: @server, max_retries: 0)
      .beta
      .agents
      .sessions
  end

  def stream(creation:)
    if creation
      @sessions.create_streaming(agent: {model: "test-model"}, environment: {type: :none}, input: "Hello")
    else
      @sessions.stream("session_test", input: "Hello")
    end
  end

  def turn(kind)
    {
      type: "agent.session.turn.#{kind}",
      session_id: "session_test",
      turn_id: "turn_root",
      turn: {id: "turn_root", session_id: "session_test", status: kind == "created" ? "in_progress" : kind}
    }
  end

  def answer
    {
      type: "agent.session.turn.item.done",
      session_id: "session_test",
      turn_id: "turn_root",
      output_index: 0,
      item: {
        id: "message_answer",
        type: "message",
        role: "assistant",
        turn_id: "turn_root",
        phase: "final_answer",
        status: "completed",
        content: [{type: "output_text", text: "Answer", annotations: []}]
      }
    }
  end

  def budget(session_id = "session_test")
    {type: "agent.session.budget_reached", session: {id: session_id, status: "budget_reached"}}
  end

  def idle = {type: "agent.session.idle", session: {id: "session_test", status: "idle"}}

  def budget_error
    {
      type: "error",
      session_id: "session_test",
      error: {type: "budget_error", code: "budget_reached", message: "Budget reached", param: nil}
    }
  end

  def test_both_raw_endpoints_deliver_a_typed_budget_event_without_a_preceding_error
    [false, true].each do |creation|
      configure([budget])
      subject = if creation
        stream(creation: true)
      else
        @sessions.events.stream_streaming("session_test")
      end

      events = subject.to_a

      assert_equal(1, events.size)
      assert_instance_of(OpenAI::Models::Beta::AgentSessionBudgetReachedEvent, events.first)
      assert_equal(:"agent.session.budget_reached", events.first.type)
      assert_equal(:budget_reached, events.first.session.status)
      assert_nil(events.first.session.spend_control)
      refute(events.first.session.to_h.key?(:spend_control))
      subject.close
      assert(@server.body.closed)
    end
  end

  def test_both_raw_endpoints_preserve_an_error_before_a_typed_budget_event
    [false, true].product([250, nil]).each do |creation, limit|
      budget_event = budget
      budget_event[:session][:spend_control] = {limit: limit, consumed: 135}
      configure([budget_error, budget_event, idle])
      subject = if creation
        stream(creation: true)
      else
        @sessions.events.stream_streaming("session_test")
      end

      events = subject.to_a

      assert_equal([:error, :"agent.session.budget_reached", :"agent.session.idle"], events.map(&:type))
      assert_instance_of(OpenAI::Models::Beta::AgentSessionErrorEvent, events.first)
      assert_equal("0", events.first.event_id)
      assert_equal("session_test", events.first.session_id)
      assert_equal("budget_error", events.first.error.type)
      assert_equal("budget_reached", events.first.error.code)
      assert_equal("Budget reached", events.first.error.message)
      assert_nil(events.first.error.param)
      assert_instance_of(OpenAI::Models::Beta::AgentSessionBudgetReachedEvent, events[1])
      assert_equal("1", events[1].event_id)
      assert_equal("session_test", events[1].session.id)
      assert_equal(:budget_reached, events[1].session.status)
      spending = events[1].session.spend_control
      assert_instance_of(OpenAI::Models::Beta::AgentSession::SpendControl, spending)
      assert(spending.to_h.key?(:limit))
      limit.nil? ? assert_nil(spending.limit) : assert_equal(limit, spending.limit)
      assert_equal(135, spending.consumed)
      subject.close
      assert(@server.body.closed)
    end
  end

  def test_session_helper_closes_at_its_matching_budget_snapshot
    [false, true].each do |with_turn|
      events = with_turn ? [turn("created"), turn("completed")] : []
      events << budget
      configure(events + [idle])
      received = stream(creation: false).to_a

      assert_equal(events.size, received.size)
      assert_instance_of(OpenAI::Models::Beta::AgentSessionBudgetReachedEvent, received.last)
      assert_equal(events.size, @server.body.reads)
      assert(@server.body.closed)
    end
  end

  def test_creation_result_stops_at_its_matching_budget_snapshot_before_any_turn
    created = {type: "agent.session.created", session: {id: "session_test", status: "idle"}}
    scenarios = [[created, budget("session_other"), budget], [budget_error, budget("session_other"), budget], [budget]]
    scenarios.each do |events|
      configure(events + [idle])

      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
        stream(creation: true).get_final_result
      end

      assert_equal(:incomplete, error.reason)
      assert_equal("session_test", error.session_id)
      assert_nil(error.turn)
      assert_equal(events.size, @server.body.reads)
      assert(@server.body.closed)
    end
  end

  def test_completed_result_waits_for_its_matching_budget_snapshot
    [false, true].each do |creation|
      configure([turn("created"), answer, turn("completed"), budget("session_other"), budget, idle])
      subject = stream(creation: creation)
      result = subject.get_final_result

      assert_equal("Answer", result.output_text)
      assert_equal(:completed, result.turn.status)
      assert_same(result, subject.get_final_result)
      assert_equal(5, @server.body.reads)
      assert(@server.body.closed)
    end
  end

  def test_budget_snapshot_does_not_mask_an_incomplete_turn
    [false, true].each do |creation|
      configure([turn("created"), answer, budget])
      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
        stream(creation: creation).get_final_result
      end

      assert_equal(creation ? :incomplete : :observation_error, error.reason)
      assert_equal("turn_root", error.turn.id)
      assert_equal("Answer", error.messages.first.output_text)
      assert(@server.body.closed)
    end
  end

  def test_early_budget_snapshot_preserves_the_later_authoritative_result
    [false, true].each do |creation|
      configure([turn("created"), budget, answer, turn("completed"), budget, idle])
      result = stream(creation: creation).get_final_result

      assert_equal("Answer", result.output_text)
      assert_equal(:completed, result.turn.status)
      assert_equal(5, @server.body.reads)
      assert(@server.body.closed)
    end
  end
end
