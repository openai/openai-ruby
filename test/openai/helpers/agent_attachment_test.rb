# frozen_string_literal: true

require_relative "agent_turn_result_test"

class OpenAI::Test::AgentAttachmentTest < OpenAI::Test::AgentTurnResultTest
  class Body < OpenAI::Test::AgentTurnResultTest::Body
    def initialize(events, server)
      super(events)
      @server = server
    end

    def each
      super do |chunk|
        event = JSON.parse(chunk.delete_prefix("data: ").strip)
        @server.before_event&.call(event)
        @server.turns[event["turn_id"]] = event["turn"] if event["turn"]
        @server.status = event.dig("session", "status") if event["session"]
        yield chunk
      end
    end
  end

  class Server < OpenAI::Test::AgentTurnResultTest::Server
    attr_accessor :turns, :items, :on_subscribe, :item_error, :before_event, :required_actions

    def initialize(events)
      super
      @body = Body.new(events, self)
      @turns = {}
      @items = []
      @status = "in_progress"
    end

    def execute(request)
      path = request.url.path
      if request.method == :get && path.end_with?("/events")
        @on_subscribe&.call
      elsif request.method == :get && path.include?("/turns")
        @requests << request
        if path.end_with?("/turns")
          return response(200, JSON.generate(data: @turns.values.reverse, has_more: false))
        end

        return response(200, JSON.generate(@turns.fetch(path.split("/").last)))
      elsif request.method == :get && path.end_with?("/items")
        @requests << request
        raise @item_error if @item_error
        after = URI.decode_www_form(request.url.query.to_s).to_h["after"]
        offset = after ? @items.index { _1[:id] == after } + 1 : 0
        page = @items.slice(offset, 1) || []
        return response(200, JSON.generate(data: page, has_more: offset + 1 < @items.length))
      end

      if request.method == :get && path.end_with?("/sessions/session_test")
        @requests << request
        return response(
          200,
          JSON.generate(id: "session_test", status: @status, required_actions: @required_actions || [])
        )
      end

      super
    end
  end

  def configure_attachment(events: [turn("completed"), idle], initial: "in_progress", items: [answer_event[:item]])
    @server = Server.new(events)
    @server.status = initial
    @server.turns["turn_root"] = turn(initial)[:turn] unless initial == "idle"
    @server.items = items
    @sessions = OpenAI::Client
      .new(api_key: "fake-key", base_url: "https://sdk-test.example/v1", http_client: @server)
      .beta
      .agents
      .sessions
  end

  def function_call
    {
      type: "agent.session.turn.item.added",
      session_id: "session_test",
      turn_id: nil,
      item: {
        id: "call_item",
        type: "function_call",
        name: "lookup",
        call_id: "call_test",
        arguments: "{\"order\":\"A123\"}",
        status: "in_progress",
        turn_id: "turn_root"
      }
    }
  end

  def test_reattachment_uses_existing_handlers_and_recovers_missed_final_output
    configure_attachment(events: [function_call, function_call, turn("completed"), idle], initial: "waiting")
    calls = []
    result = @sessions
      .stream(
        "session_test",
        tool_handlers: {
          "lookup" => -> (args) {
            calls << args
            "found"
          }
        }
      )
      .get_final_result
    assert_equal([{"order" => "A123"}], calls)
    assert_equal("Answer", result.output_text)
    assert_equal(["agent.session.input.tool_result"], @server.submissions.map { _1["type"] })
    assert_predicate(@server.body, :closed)
  end

  def test_false_output_type_is_rejected_before_attaching_or_dispatching
    configure_attachment(events: [function_call], initial: "waiting")
    calls = []
    error = assert_raises(ArgumentError) do
      @sessions.stream("session_test", output_type: false, tool_handlers: {"lookup" => -> (args) { calls << args }})
    end

    assert_equal("output_type must be an OpenAI::BaseModel subclass", error.message)
    assert_empty(@server.requests)
    assert_empty(calls)
  end

  def test_false_input_is_rejected_before_attaching_or_dispatching
    configure_attachment(events: [function_call], initial: "waiting")
    calls = []
    assert_raises(ArgumentError) do
      @sessions.stream("session_test", input: false, tool_handlers: {"lookup" => -> (args) { calls << args }})
    end

    assert_empty(@server.requests)
    assert_empty(calls)
  end

  def test_unknown_pending_snapshot_actions_are_scoped_to_the_selected_root
    ["turn_root", nil].each do |id|
      configure_attachment(events: [], initial: "waiting")
      @server.status = "requires_action"
      @server.required_actions = [
        {type: "future_action", turn_id: "unrelated", opaque: "other"},
        {type: "future_action", turn_id: id, opaque: "selected"}
      ]
      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
        @sessions.stream("session_test").get_final_result
      end

      assert_equal(:requires_action, error.reason)
      assert_equal("turn_root", error.turn_id)
      assert_equal(["selected"], error.required_actions.map { _1[:opaque] })
      assert_equal(0, @server.body.reads)
    end
  end

  def test_live_environment_action_is_reported_without_selecting_historical_work
    [nil, "completed"].each do |historical|
      pending = action
      pending[:session][:required_actions] = [{type: "environment_connection", environment_id: "env"}]
      configure_attachment(events: [pending])
      @server.turns.clear
      @server.turns["turn_root"] = turn(historical)[:turn] if historical
      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
        @sessions.stream("session_test").get_final_result
      end

      assert_equal(:requires_action, error.reason)
      assert_nil(error.turn_id)
      assert_equal(:environment_connection, error.required_actions.first.type)
      assert_equal(1, @server.body.reads)
    end
  end

  def test_replayed_call_identity_is_available_before_each_handler_invocation
    observed = []
    invoked = []
    2.times do
      configure_attachment(events: [function_call, turn("completed"), idle], initial: "waiting")
      identity = nil
      stream = @sessions
        .stream(
          "session_test",
          tool_handlers: {
            "lookup" => -> (_args) {
              invoked << identity
              "found"
            }
          }
        )
        .with_result_collection
      stream.each do |event|
        next unless event.type == :"agent.session.turn.item.added"
        identity = [event.session_id, event.item.turn_id, event.item.call_id]
        observed << identity
        assert_equal(observed.length - 1, invoked.length)
      end

      assert_equal("Answer", stream.get_final_result.output_text)
    end

    assert_equal([["session_test", "turn_root", "call_test"]] * 2, invoked)
    assert_equal(observed, invoked)
  end

  def test_terminal_selected_snapshot_does_not_wait_for_or_dispatch_a_successor
    successor_call = function_call.merge(turn_id: "turn_next", item: function_call[:item].merge(turn_id: "turn_next"))
    configure_attachment(events: [successor_call])
    @server.on_subscribe = lambda do
      @server.turns["turn_root"] = turn("completed")[:turn]
      @server.turns["turn_next"] = turn("created", id: "turn_next")[:turn]
      @server.status = "in_progress"
    end
    calls = []
    result = @sessions
      .stream("session_test", tool_handlers: {"lookup" => -> (args) { calls << args }})
      .get_final_result
    assert_equal("turn_root", result.turn_id)
    assert_equal("Answer", result.output_text)
    assert_empty(calls)
    assert_equal(0, @server.body.reads)
  end

  def test_successor_actions_and_calls_are_not_assigned_to_the_selected_root
    successor = function_call.merge(turn_id: "turn_next", item: function_call[:item].merge(turn_id: "turn_next"))
    action_event = action(name: "unregistered")
    action_event[:session][:required_actions].first[:turn_id] = "turn_next"
    configure_attachment(events: [successor, action_event, turn("completed")])
    calls = []
    result = @sessions
      .stream("session_test", tool_handlers: {"lookup" => -> (args) { calls << args }})
      .get_final_result
    assert_equal("Answer", result.output_text)
    assert_empty(calls)
  end

  def test_first_reconstructed_call_selects_a_root_that_started_after_initial_snapshots
    configure_attachment(events: [function_call, turn("completed")])
    @server.turns.clear
    @server.before_event = -> (_event) { @server.turns["turn_root"] ||= turn("created")[:turn] }
    calls = []
    result = @sessions
      .stream(
        "session_test",
        tool_handlers: {
          "lookup" => -> (args) {
            calls << args
            "found"
          }
        }
      )
      .get_final_result
    assert_equal("turn_root", result.turn_id)
    assert_equal(1, calls.length)
  end

  def test_delayed_approval_item_selects_its_root_and_refreshes_manual_diagnostics
    request = {type: "browser_authentication", reason: nil, credential_origin: nil, fields: [], options: []}
    approval = {
      type: "agent.session.turn.item.added",
      session_id: "session_test",
      turn_id: nil,
      item: {
        type: "computer_use_approval_request",
        id: "approval_item",
        turn_id: "turn_root",
        request_id: "approval",
        request: request
      }
    }
    configure_attachment(events: [approval])
    @server.turns.clear
    @server.before_event = lambda do |_event|
      @server.turns["turn_root"] = turn("waiting")[:turn]
      @server.status = "requires_action"
      @server.required_actions = [
        {type: "computer_use_approval_request", turn_id: "turn_root", request_id: "approval", request: request}
      ]
    end
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
      @sessions.stream("session_test").get_final_result
    end

    assert_equal(:requires_action, error.reason)
    assert_equal("turn_root", error.turn_id)
    assert_equal("approval", error.required_actions.first.request_id)
    assert_equal("Answer", error.messages.first.content.first.text)
    assert_equal(1, @server.body.reads)
  end

  def test_unknown_turnless_snapshot_action_is_reported_without_selecting_historical_work
    [nil, "completed"].each do |historical|
      configure_attachment(events: [])
      @server.turns.clear
      @server.turns["turn_root"] = turn(historical)[:turn] if historical
      @server.status = "requires_action"
      @server.required_actions = [
        {type: "future_action", turn_id: "turn_root", opaque: "other"},
        {type: "future_action", opaque: "current"}
      ]
      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
        @sessions.stream("session_test").get_final_result
      end

      assert_equal(:requires_action, error.reason)
      assert_nil(error.turn_id)
      assert_equal("session_test", error.session_id)
      assert_equal(["current"], error.required_actions.map { _1[:opaque] })
      assert_equal(0, @server.body.reads)
      assert_empty(@server.submissions)
    end
  end

  def test_environment_connection_can_be_diagnosed_before_any_root_exists
    configure_attachment(events: [])
    @server.turns.clear
    @server.status = "requires_action"
    @server.required_actions = [{type: "environment_connection", environment_id: "env"}]
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
      @sessions.stream("session_test").get_final_result
    end

    assert_equal(:requires_action, error.reason)
    assert_nil(error.turn_id)
    assert_equal("session_test", error.session_id)
    assert_equal(:environment_connection, error.required_actions.first.type)
    assert_equal(0, @server.body.reads)
  end

  def test_environment_connection_after_historical_work_has_no_selected_turn
    configure_attachment(events: [])
    @server.turns["turn_root"] = turn("completed")[:turn]
    @server.status = "requires_action"
    @server.required_actions = [{type: "environment_connection", environment_id: "env"}]
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
      @sessions.stream("session_test").get_final_result
    end

    assert_equal(:requires_action, error.reason)
    assert_nil(error.turn_id)
    assert_equal("session_test", error.session_id)
    assert_equal(:environment_connection, error.required_actions.first.type)
    assert_equal(0, @server.body.reads)
  end

  def test_unknown_turnless_successor_actions_do_not_block_the_selected_root
    pending = action
    pending[:session][:required_actions] = [{type: "future_action", opaque: "successor"}]
    configure_attachment(events: [pending, turn("completed")])
    @server.before_event = -> (_event) { @server.turns["successor"] = turn("waiting", id: "successor")[:turn] }
    assert_equal("Answer", @sessions.stream("session_test").get_final_result.output_text)
  end

  def test_unknown_turnless_current_root_action_is_preserved
    pending = action
    pending[:session][:required_actions] = [{type: "future_action", opaque: "current"}]
    configure_attachment(events: [pending])
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
      @sessions.stream("session_test").get_final_result
    end

    assert_equal(:requires_action, error.reason)
    assert_equal("future_action", error.required_actions.first[:type])
  end

  def test_blocked_attachment_preserves_durable_output_before_disconnect
    configure_attachment(events: [function_call], initial: "waiting")
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
      @sessions.stream("session_test").get_final_result
    end

    assert_equal(:requires_action, error.reason)
    assert_equal("Answer", error.messages.first.content.first.text)
    assert_equal("call_test", error.required_actions.first.call_id)
  end

  def test_active_read_failure_preserves_durable_output_and_original_cause
    configure_attachment(events: [])
    @server.body.error = IOError.new("original disconnection")
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
      @sessions.stream("session_test").get_final_result
    end

    assert_equal(:observation_error, error.reason)
    assert_same(@server.body.error, error.cause)
    assert_equal("Answer", error.messages.first.content.first.text)
    assert_equal(2, @server.requests.count { _1.url.path.end_with?("/turns/turn_root") })
  end

  def test_failed_history_reconciliation_preserves_the_original_blocked_outcome
    configure_attachment(events: [function_call], initial: "waiting")
    @server.item_error = IOError.new("history read failed")
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
      @sessions.stream("session_test").get_final_result
    end

    assert_equal(:requires_action, error.reason)
    assert_equal("call_test", error.required_actions.first.call_id)
  end

  def test_failed_history_reconciliation_preserves_the_original_read_cause
    configure_attachment(events: [])
    @server.body.error = IOError.new("original disconnection")
    @server.item_error = IOError.new("history read failed")
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
      @sessions.stream("session_test").get_final_result
    end

    assert_equal(:observation_error, error.reason)
    assert_same(@server.body.error, error.cause)
  end

  def test_lazy_manual_diagnostic_failure_is_wrapped_and_closes_stream
    configure_attachment(events: [], initial: "waiting")
    @server.status = "requires_action"
    subject = @sessions.stream("session_test")
    @server.define_singleton_method(:execute) { |_request| raise IOError, "diagnostic read failed" }
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { subject.with_result_collection }
    assert_equal(:observation_error, error.reason)
    assert_equal("turn_root", error.turn_id)
    assert_predicate(@server.body, :closed)
  end

  def test_session_failure_refreshes_selected_turn_metadata
    failed = {type: "agent.session.failed", session: {id: "session_test", status: "failed"}}
    configure_attachment(events: [failed])
    @server.before_event = -> (_event) { @server.turns["turn_root"] = turn("failed")[:turn].merge(completed_at: 9) }
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
      @sessions.stream("session_test").get_final_result
    end

    assert_equal(:failed, error.reason)
    assert_equal(:failed, error.turn.status)
    assert_equal(9, error.turn.completed_at)
    assert_equal("Answer", error.messages.first.content.first.text)
  end

  def test_successor_session_failure_does_not_poison_completed_selected_turn
    configure_attachment(events: [])
    @server.on_subscribe = -> do
      @server.turns["turn_root"] = turn("completed")[:turn]
      @server.turns["successor"] = turn("failed", id: "successor")[:turn]
      @server.status = "failed"
    end

    assert_equal("Answer", @sessions.stream("session_test").get_final_result.output_text)
  end

  def test_buffered_old_idle_does_not_end_observation_of_a_new_root
    configure_attachment(events: [idle, function_call, turn("completed")])
    @server.turns.clear
    @server.before_event = lambda do |event|
      @server.turns["turn_root"] = turn("created")[:turn] if event["type"] == "agent.session.turn.item.added"
    end
    original = @server.method(:execute)
    @server.define_singleton_method(:execute) do |request|
      @status = "in_progress" if request.url.path.end_with?("/sessions/session_test")
      original.call(request)
    end

    result = @sessions.stream("session_test", tool_handlers: {"lookup" => -> (_args) { "found" }}).get_final_result
    assert_equal("turn_root", result.turn_id)
    assert_equal("Answer", result.output_text)
    assert_equal(1, @server.submissions.length)
  end

  def test_turn_in_progress_can_select_a_root_after_initial_snapshots
    configure_attachment(events: [turn("in_progress"), turn("completed")])
    @server.turns.clear
    assert_equal("turn_root", @sessions.stream("session_test").get_final_result.turn_id)
  end

  def test_historical_root_item_cannot_select_an_answer_older_than_the_baseline
    old_call = function_call.merge(item: function_call[:item].merge(turn_id: "older"))
    configure_attachment(events: [old_call, turn("created"), turn("completed")], initial: "idle")
    @server.status = "in_progress"
    @server.turns["older"] = turn("completed", id: "older")[:turn]
    @server.turns["baseline"] = turn("completed", id: "baseline")[:turn]
    result = @sessions.stream("session_test").get_final_result
    assert_equal("turn_root", result.turn_id)
    assert_equal("Answer", result.output_text)
    assert_empty(@server.submissions)
  end

  def test_successor_environment_action_is_not_attributed_to_selected_predecessor
    environment_action = action
    environment_action[:session][:required_actions] = [{type: "environment_connection", environment_id: "env"}]
    configure_attachment(events: [environment_action, turn("completed")])
    @server.before_event = -> (_event) { @server.turns["successor"] = turn("waiting", id: "successor")[:turn] }
    result = @sessions.stream("session_test").get_final_result
    assert_equal("Answer", result.output_text)
    assert_equal("turn_root", result.turn_id)
  end

  def test_raw_attachment_does_not_retain_manual_approval_payload
    configure_attachment(events: [], initial: "waiting")
    @server.status = "requires_action"
    @server.required_actions = [{type: "environment_connection", environment_id: "env"}]
    subject = @sessions.stream("session_test")
    refute(subject.instance_variable_get(:@attachment).instance_variable_defined?(:@manual_actions))
    assert_empty(subject.instance_variable_get(:@collector).instance_variable_get(:@required_actions))
    assert_equal(1, @server.requests.count { _1.url.path.end_with?("/sessions/session_test") })
    subject.close
  end

  def test_manual_approval_snapshot_is_reported_only_for_the_selected_waiting_root
    ["browser_authentication", "browser_origin_access"].each do |type|
      configure_attachment(events: [], initial: "waiting")
      @server.status = "requires_action"
      @server.required_actions = [
        {
          type: "computer_use_approval_request",
          turn_id: "turn_root",
          request_id: "approval",
          request: {type: type, origin: "https://example.com", reason: nil, fields: [], options: []}
        }
      ]
      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
        @sessions.stream("session_test").get_final_result
      end

      assert_equal(:requires_action, error.reason)
      assert_equal("approval", error.required_actions.first.request_id)
      assert_equal(0, @server.body.reads)
    end
  end

  def test_environment_reconnection_snapshot_is_reported_for_current_waiting_root
    configure_attachment(events: [], initial: "waiting")
    @server.status = "requires_action"
    @server.required_actions = [{type: "environment_connection", environment_id: "environment_test"}]
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
      @sessions.stream("session_test").get_final_result
    end

    assert_equal(:requires_action, error.reason)
    assert_equal(:environment_connection, error.required_actions.first.type)
  end

  def test_unknown_replayed_call_stops_result_getter_without_waiting_for_a_status_marker
    configure_attachment(events: [function_call])
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
      @sessions.stream("session_test").get_final_result
    end

    assert_equal(:requires_action, error.reason)
    assert_equal("call_test", error.required_actions.first.call_id)
    assert_equal(1, @server.body.reads)
    assert_empty(@server.submissions)
  end

  def test_distinct_root_completed_during_idle_subscription_is_recovered
    configure_attachment(events: [], initial: "idle")
    @server.turns["old"] = turn("completed", id: "old")[:turn]
    @server.on_subscribe = -> { @server.turns["turn_root"] = turn("completed")[:turn] }
    result = @sessions.stream("session_test").get_final_result
    assert_equal("turn_root", result.turn_id)
    assert_equal("Answer", result.output_text)
    assert_equal(0, @server.body.reads)
  end

  def test_read_failure_reconciles_only_the_selected_completed_turn
    configure_attachment(events: [answer_event])
    @server.body.error = IOError.new("connection lost")
    @server.before_event = -> (_event) { @server.turns["turn_root"] = turn("completed")[:turn] }
    result = @sessions.stream("session_test").get_final_result
    assert_equal("Answer", result.output_text)
    assert_equal("turn_root", result.turn_id)
    reads = @server.requests.count { _1.url.path.end_with?("/turns/turn_root") }
    assert_equal(2, reads)
  end

  def test_tool_submission_failure_is_not_recovered_as_a_successful_turn
    configure_attachment(events: [function_call])
    @server.before_event = -> (_event) { @server.turns["turn_root"] = turn("completed")[:turn] }
    server = @server
    original = server.method(:execute)
    server.define_singleton_method(:execute) do |request|
      raise IOError, "submission failed" if request.method == :post
      original.call(request)
    end

    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) do
      @sessions.stream("session_test", tool_handlers: {"lookup" => -> (_args) { "found" }}).get_final_result
    end

    assert_equal(:observation_error, error.reason)
    assert_empty(@server.requests.select { _1.url.path.end_with?("/items") })
  end

  def test_unregistered_selected_action_remains_caller_managed
    configure_attachment(events: [action(name: "unregistered")])
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) {
      @sessions.stream("session_test").get_final_result
    }
    assert_equal(:requires_action, error.reason)
    assert_equal("turn_root", error.turn_id)
    assert_empty(@server.submissions)
  end

  def test_progress_iteration_can_collect_the_recovered_result_afterward
    configure_attachment
    subject = @sessions.stream("session_test").with_result_collection
    subject.each { |_event| nil }
    result = subject.get_final_result
    assert_equal("Answer", result.output_text)
    assert_same(result, subject.get_final_result)
  end

  def test_repeated_attachment_does_not_need_a_process_lifetime_call_cache
    configure_attachment(events: [function_call])
    calls = []
    handlers = {
      "lookup" => -> (args) {
        calls << args
        "found"
      }
    }
    assert_raises(RuntimeError) { @sessions.stream("session_test", tool_handlers: handlers).until_done }
    assert_equal(1, @server.submissions.length)
    configure_attachment(events: [turn("completed")])
    result = @sessions.stream("session_test", tool_handlers: handlers).get_final_result
    assert_equal("Answer", result.output_text)
    assert_equal(1, calls.length)
  end

  def test_handler_errors_use_existing_generic_tool_error_submission
    configure_attachment(events: [function_call, turn("completed")])
    handlers = {"lookup" => -> (_args) { raise "synthetic private tool detail" }}
    @sessions.stream("session_test", tool_handlers: handlers).until_done
    assert_equal(false, @server.submissions.last["success"])
    assert_equal("Tool handler failed.", @server.submissions.last["error"])
  end

  def test_already_answered_calls_are_not_executed_from_session_snapshot
    configure_attachment
    @server.required_actions = action[:session][:required_actions]
    calls = []
    @sessions.stream("session_test", tool_handlers: {"lookup" => -> (args) { calls << args }}).until_done
    assert_empty(calls)
    assert_empty(@server.submissions)
  end

  def test_completion_during_subscription_recovers_selected_turn_without_waiting_for_sse
    configure_attachment(events: [])
    @server.on_subscribe = -> {
      @server.status = "idle"
      @server.turns["turn_root"] = turn("completed")[:turn]
    }
    result = @sessions.stream("session_test").get_final_result
    assert_equal("Answer", result.output_text)
    assert_equal(0, @server.body.reads)
  end

  def test_idle_attachment_does_not_select_an_old_answer
    configure_attachment(events: [], initial: "idle")
    @server.turns["older"] = turn("completed", id: "older")[:turn]
    @sessions.stream("session_test").until_done
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) {
      @sessions.stream("session_test").get_final_result
    }
    assert_equal(:no_turn, error.reason)
    assert_nil(error.turn_id)
    refute(@server.requests.any? { _1.url.path.end_with?("/items") })
  end

  def test_durable_output_paginates_and_filters_the_exact_root_turn
    items = [
      answer_event("Old", id: "old", turn_id: "old")[:item],
      answer_event("First", id: "one")[:item],
      answer_event("Thinking", id: "comment", phase: "commentary")[:item],
      answer_event("Second", id: "two")[:item]
    ]
    configure_attachment(items: items)
    result = @sessions
      .stream("session_test", request_options: {extra_headers: {"X-Test" => "preserved"}})
      .get_final_result
    assert_equal("FirstSecond", result.output_text)
    requests = @server.requests.select { _1.url.path.end_with?("/items") }
    assert_equal(4, requests.size)
    assert(requests.all? { _1.headers["x-test"] == "preserved" || _1.headers["X-Test"] == "preserved" })
  end

  def test_raw_attachment_never_fetches_or_retains_output_history
    configure_attachment(events: [answer_event, turn("completed"), idle])
    subject = @sessions.stream("session_test")
    subject.until_done
    assert_empty(subject.instance_variable_get(:@collector).instance_variable_get(:@messages))
    refute(@server.requests.any? { _1.url.path.end_with?("/items") })
    assert_raises(ArgumentError) { subject.get_final_result }
  end

  def test_durable_read_failure_is_an_observation_error_not_a_partial_success
    configure_attachment
    @server.item_error = RuntimeError.new("synthetic history read failure")
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) {
      @sessions.stream("session_test").get_final_result
    }
    assert_equal(:observation_error, error.reason)
    assert_same(@server.item_error, error.cause)
  end
end
