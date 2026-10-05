# frozen_string_literal: true

require_relative "agent_session_stream_test"

class OpenAI::Test::AgentTurnResultTest < Minitest::Test
  class Body < OpenAI::Test::AgentSessionStreamTest::Body
    attr_accessor :error

    def each(&block)
      super
      raise @error if @error
    end
  end

  class Server < OpenAI::Test::AgentSessionStreamTest::Server
    def initialize(events)
      super
      @body = Body.new(events)
    end

    def execute(request)
      if request.method == :post && request.url.path.end_with?("/agents/sessions")
        @requests << request
        return response(200, @body, "text/event-stream")
      end

      super
    end
  end

  def configure(events)
    @server = Server.new(events)
    @sessions = OpenAI::Client
      .new(
        api_key: "fake-key",
        base_url: "https://sdk-test.example/v1",
        http_client: @server
      )
      .beta
      .agents
      .sessions
  end

  def stream(creation: false, handlers: {})
    if creation
      @sessions.create_streaming(agent: {model: "test-model"}, environment: {type: :none}, input: "Hello")
    else
      @sessions.stream("session_test", input: "Hello", tool_handlers: handlers)
    end
  end

  def turn(kind, id: "turn_root", subagent: nil)
    {
      type: "agent.session.turn.#{kind}",
      session_id: "session_test",
      turn_id: id,
      turn: {
        id: id,
        session_id: "session_test",
        status: kind == "created" ? "in_progress" : kind,
        subagent_id: subagent,
        created_at: 1,
        agent_id: "agent_test",
        completed_at: nil,
        started_at: 1,
        error: nil,
        usage: {input_tokens: 5, output_tokens: 8, total_tokens: 13}
      }
    }
  end

  def answer_event(
    text = "Answer",
    id: "message_test",
    index: 0,
    phase: "final_answer",
    done: true,
    turn_id: "turn_root"
  )
    {
      type: "agent.session.turn.item.#{done ? "done" : "added"}",
      session_id: "session_test",
      turn_id: turn_id,
      output_index: index,
      item: {
        id: id,
        type: "message",
        role: "assistant",
        turn_id: turn_id,
        phase: phase,
        status: done ? "completed" : "in_progress",
        content: [{type: "output_text", text: text, annotations: []}]
      }
    }
  end

  def idle = {type: "agent.session.idle", session: {id: "session_test", status: "idle"}}

  def complete = [turn("created"), answer_event, turn("completed"), idle]

  def action(name: "lookup", type: "function_call")
    {
      type: "agent.session.requires_action",
      session: {
        id: "session_test",
        status: "requires_action",
        required_actions: [{type: type, name: name, arguments: "{}", call_id: "call_test", turn_id: "turn_root"}]
      }
    }
  end

  def test_both_entrypoints_collect_the_same_result_and_cache_it
    [false, true].each do |creation|
      configure(complete)
      subject = stream(creation: creation)
      result = subject.get_final_result
      assert_instance_of(OpenAI::Helpers::Beta::Agents::TurnResult, result)
      assert_equal("Answer", result.output_text)
      assert_equal("session_test", result.session_id)
      assert_equal("turn_root", result.turn_id)
      assert_equal(:completed, result.turn.status)
      assert_instance_of(OpenAI::Models::Beta::AgentSessionMessage, result.messages.first)
      assert_equal(13, result.turn.usage.total_tokens)
      requests = @server.requests.size
      assert_same(result, subject.get_final_result)
      assert_equal(requests, @server.requests.size)
      assert(@server.body.closed)
    end
  end

  def test_iteration_then_getter_and_drain_then_getter
    [false, true].product([:each, :until_done]).each do |creation, mode|
      configure(complete)
      subject = stream(creation: creation).with_result_collection
      if mode == :each || creation
        subject.each { |event| assert(event.type) }
      else
        subject.until_done
      end

      assert_equal("Answer", subject.get_final_result.output_text)
    end
  end

  def test_external_iteration_then_getter_uses_remaining_events
    [false, true].each do |creation|
      configure(complete)
      subject = stream(creation: creation).with_result_collection
      external = creation ? subject.to_enum : subject.each
      assert_equal(:"agent.session.turn.created", external.next.type)
      assert_equal("Answer", subject.get_final_result.output_text)
      assert_equal(4, @server.body.reads)
      assert_raises(StopIteration) { external.next }
    end
  end

  def test_creation_getter_stops_at_selected_turn_idle_preserving_metadata_and_base_type
    configure(complete + [turn("created", id: "later")])
    subject = stream(creation: true)
    assert_kind_of(OpenAI::Internal::Stream, subject)
    assert_equal(200, subject.status)
    assert_equal("text/event-stream", subject.headers["content-type"])
    assert(subject.last_response)
    assert_equal("Answer", subject.get_final_result.output_text)
    assert_equal(4, @server.body.reads)
  end

  def test_selection_order_duplicates_commentary_children_and_later_turns
    events = [
      idle,
      turn("created", id: "child", subagent: "subagent"),
      turn("created"),
      answer_event("Child", turn_id: "child"),
      answer_event("thinking", id: "comment", phase: "commentary"),
      answer_event("B", id: "second", index: 2),
      answer_event("A", index: 1, done: false),
      answer_event("A", index: 1),
      answer_event("A", index: 1),
      turn("completed", id: "child"),
      idle,
      turn("completed"),
      idle,
      turn("created", id: "later"),
      answer_event("later", turn_id: "later")
    ]
    [false, true].each do |creation|
      configure(events)
      result = stream(creation: creation).get_final_result
      assert_equal("AB", result.output_text)
      assert_equal(%w[message_test second], result.messages.map(&:id))
    end
  end

  def test_collector_isolates_snapshots_before_returning_events
    [false, true].each do |creation|
      configure(complete)
      subject = stream(creation: creation).with_result_collection
      subject.each do |event|
        if event.type == :"agent.session.turn.item.done"
          event.item.content.first.text.replace("Changed")
        elsif event.type == :"agent.session.turn.completed"
          event.turn.id.replace("changed")
        end
      end

      result = subject.get_final_result
      assert_equal("Answer", result.output_text)
      assert_equal("turn_root", result.turn_id)
    end
  end

  def test_empty_success_and_legacy_message_phase
    [false, true].each do |creation|
      configure([turn("created"), turn("completed"), idle])
      assert_equal("", stream(creation: creation).get_final_result.output_text)
      configure([turn("created"), answer_event(phase: nil), turn("completed"), idle])
      result = stream(creation: creation).get_final_result
      assert_equal("Answer", result.output_text)
      assert_nil(result.messages.first.phase)
    end
  end

  def test_failed_and_cancelled_results_preserve_partial_answer
    [false, true].product(%w[failed cancelled]).each do |creation, status|
      configure([turn("created"), answer_event, turn(status), idle])
      subject = stream(creation: creation)
      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { subject.get_final_result }
      assert_equal(status.to_sym, error.reason)
      assert_equal("Answer", error.messages.first.output_text)
      assert_same(error, assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { subject.get_final_result })
      assert(@server.body.closed)
    end
  end

  def test_unhandled_action_stops_without_waiting_for_another_event
    [false, true].each do |creation|
      configure([turn("created"), action, turn("completed"), idle])
      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { stream(creation: creation).get_final_result }
      assert_equal(:requires_action, error.reason)
      assert_equal("call_test", error.required_actions.first.call_id)
      assert_equal(2, @server.body.reads)
      assert(@server.body.closed)
    end
  end

  def test_getter_continues_after_a_manually_resolved_action_resumes
    resumed = {type: "agent.session.in_progress", session: {id: "session_test", status: "in_progress"}}
    [false, true].each do |creation|
      configure([turn("created"), action, resumed, answer_event, turn("completed"), idle])
      subject = stream(creation: creation).with_result_collection
      events = subject.to_enum
      events.next
      assert_equal(:"agent.session.requires_action", events.next.type)
      @sessions.events.create(
        "session_test",
        events: [
          {
            type: :"agent.session.input.tool_result",
            turn_id: "turn_root",
            call_id: "call_test",
            success: true,
            output: "ok"
          }
        ]
      )
      assert_equal(:"agent.session.in_progress", events.next.type)

      result = subject.get_final_result
      assert_equal("Answer", result.output_text)
      assert_equal(:completed, result.turn.status)
      assert_equal(6, @server.body.reads)
      assert(@server.body.closed)
    end
  end

  def test_another_session_resuming_does_not_clear_pending_actions
    resumed = {type: "agent.session.in_progress", session: {id: "other_session", status: "in_progress"}}
    [false, true].each do |creation|
      configure([turn("created"), action, resumed, answer_event, turn("completed"), idle])
      subject = stream(creation: creation).with_result_collection
      events = subject.to_enum
      3.times { events.next }

      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { subject.get_final_result }
      assert_equal(:requires_action, error.reason)
      assert_equal("call_test", error.required_actions.first.call_id)
      assert_equal(3, @server.body.reads)
    end
  end

  def test_getter_keeps_existing_handlers_running_once
    call = {
      type: "agent.session.turn.item.added",
      session_id: "session_test",
      turn_id: "turn_root",
      output_index: 0,
      item: {
        type: "function_call",
        id: "function",
        name: "lookup",
        call_id: "call_test",
        arguments: "{}",
        status: "in_progress",
        turn_id: "turn_root"
      }
    }
    configure([turn("created"), call, action, answer_event, turn("completed"), idle])
    calls = 0
    subject = stream(
      handlers: {
        "lookup" => -> (_arguments) {
          calls += 1
          "ok"
        }
      }
    )
    assert_equal("Answer", subject.get_final_result.output_text)
    assert_equal("Answer", subject.get_final_result.output_text)
    assert_equal(1, calls)
    assert_equal(2, @server.submissions.size)
  end

  def test_eof_and_explicit_close_are_not_success
    [false, true].each do |creation|
      configure([turn("created"), answer_event, turn("completed")])
      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { stream(creation: creation).get_final_result }
      assert_includes([:incomplete, :observation_error], error.reason)
      assert_equal(:completed, error.turn.status)
      configure(complete)
      subject = stream(creation: creation)
      subject.close
      assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { subject.get_final_result }
      assert_equal(0, @server.body.reads)
    end
  end

  def test_completed_items_are_authoritative_instead_of_text_deltas
    delta = {
      type: "agent.session.turn.output_text.delta",
      session_id: "session_test",
      turn_id: "turn_root",
      item_id: "message_test",
      output_index: 0,
      content_index: 0,
      delta: "Partial"
    }
    [false, true].each do |creation|
      configure([turn("created"), delta, answer_event, turn("completed"), idle])
      assert_equal("Answer", stream(creation: creation).get_final_result.output_text)
    end
  end

  def test_sse_errors_preserve_cause_identity_and_available_output
    [false, true].each do |creation|
      configure([turn("created"), answer_event, {type: "error", error: {message: "fixture transport error"}}])
      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { stream(creation: creation).get_final_result }
      assert_equal(:observation_error, error.reason)
      assert_kind_of(OpenAI::Errors::APIStatusError, error.cause)
      assert_equal("turn_root", error.turn_id)
      assert_equal("Answer", error.messages.first.output_text)
      assert(@server.body.closed)
    end
  end

  def test_raw_iteration_failure_is_retained_for_a_later_getter
    configure([turn("created"), {type: "error", error: {message: "fixture error"}}])
    subject = stream(creation: true).with_result_collection
    original = assert_raises(OpenAI::Errors::APIStatusError) { subject.each { |_event| nil } }
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { subject.get_final_result }
    assert_same(original, error.cause)
    assert_equal("turn_root", error.turn_id)
  end

  def test_creation_raw_iteration_remains_open_past_the_collected_turn
    configure(complete + [turn("created", id: "later")])
    subject = stream(creation: true).with_result_collection
    assert_equal(5, subject.to_a.size)
    assert_equal("Answer", subject.get_final_result.output_text)
  end

  def test_replayed_added_item_does_not_replace_completed_output
    configure([turn("created"), answer_event, answer_event("Partial", done: false), turn("completed"), idle])
    assert_equal("Answer", stream(creation: true).get_final_result.output_text)
  end

  def test_nullable_added_envelope_does_not_affect_completed_item_collection
    [false, true].each do |creation|
      added = answer_event("Partial", done: false).merge(turn_id: nil, output_index: nil)
      configure([turn("created"), added, answer_event, turn("completed"), idle])
      assert_equal("Answer", stream(creation: creation).get_final_result.output_text)
    end
  end

  def test_timeout_preserves_partial_state_and_original_cause
    [false, true].each do |creation|
      configure([turn("created"), answer_event])
      timeout = OpenAI::Errors::APITimeoutError.new(url: URI("https://sdk-test.example/v1"))
      @server.body.error = timeout
      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { stream(creation: creation).get_final_result }
      assert_equal(:observation_error, error.reason)
      assert_same(timeout, error.cause)
      assert_equal("Answer", error.messages.first.output_text)
      assert(@server.body.closed)
    end
  end

  def test_later_transport_failure_does_not_poison_completed_selected_result
    configure(complete + [turn("created", id: "later")])
    timeout = OpenAI::Errors::APITimeoutError.new(url: URI("https://sdk-test.example/v1"))
    @server.body.error = timeout
    subject = stream(creation: true).with_result_collection
    assert_raises(OpenAI::Errors::APITimeoutError) { subject.each { |_event| nil } }
    assert_equal("Answer", subject.get_final_result.output_text)
  end

  def test_action_without_a_turn_preserves_created_session_identity
    created = {type: "agent.session.created", session: {id: "session_test", status: "requires_action"}}
    pending = {
      type: "agent.session.requires_action",
      session: {id: "session_test", required_actions: [{type: "environment_connection", environment_id: "env_test"}]}
    }
    configure([created, pending])
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { stream(creation: true).get_final_result }
    assert_equal(:requires_action, error.reason)
    assert_equal("session_test", error.session_id)
    assert_nil(error.turn)
    assert_equal(:environment_connection, error.required_actions.first.type)
  end

  def test_unknown_added_phase_resolves_to_completed_commentary
    [false, true].each do |creation|
      configure(
        [
          turn("created"),
          answer_event("Working", phase: nil, done: false),
          answer_event("Working", phase: "commentary"),
          turn("completed"),
          idle
        ]
      )
      assert_equal("", stream(creation: creation).get_final_result.output_text)
    end
  end

  def test_collector_discards_nonfinal_messages_and_releases_completed_state
    collector = OpenAI::Helpers::Beta::Agents::ResultCollector.new
    collector.enable
    events = [
      turn("created"),
      answer_event("pending" * 100_000, phase: nil, done: false),
      answer_event("commentary" * 100_000, phase: "commentary"),
      answer_event("partial final" * 100_000, id: "answer", done: false)
    ]
    events.each_with_index do |raw, index|
      event = OpenAI::Internal::Type::Converter.coerce(OpenAI::Beta::AgentSessionEvent, raw.merge(event_id: index.to_s))
      collector.observe(event)
    end

    assert_empty(collector.instance_variable_get(:@messages))
    [answer_event(id: "answer"), turn("completed"), idle].each_with_index do |raw, index|
      event = OpenAI::Internal::Type::Converter.coerce(
        OpenAI::Beta::AgentSessionEvent,
        raw.merge(event_id: (index + 10).to_s)
      )
      collector.observe(event)
    end

    result = collector.result
    assert_equal("Answer", result.output_text)
    assert_empty(collector.instance_variable_get(:@messages))
    assert_same(result, collector.result)
  end

  def test_error_transfers_final_messages_and_releases_accumulator_state
    %w[failed cancelled transport].each do |outcome|
      collector = OpenAI::Helpers::Beta::Agents::ResultCollector.new
      collector.enable
      events = [turn("created"), answer_event("final" * 100_000)]
      events << turn(outcome) unless outcome == "transport"
      events.each_with_index do |raw, index|
        event = OpenAI::Internal::Type::Converter.coerce(
          OpenAI::Beta::AgentSessionEvent,
          raw.merge(event_id: index.to_s)
        )
        collector.observe(event)
      end

      original = collector.instance_variable_get(:@messages).values.first.last
      collector.observe_error(RuntimeError.new("fixture interruption")) if outcome == "transport"
      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { collector.result }
      assert_same(original, error.messages.first)
      assert_equal("final" * 100_000, error.messages.first.output_text)
      assert_empty(collector.instance_variable_get(:@messages))
      assert_same(error, assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { collector.result })
    end
  end

  def test_raw_iteration_and_aliases_retain_no_result_payloads
    answers = Array.new(80) { |index| answer_event("payload" * 4096, id: "message_#{index}", index: index) }
    [false, true].product([:each, :enum]).each do |creation, mode|
      configure([turn("created"), *answers, turn("completed"), idle])
      subject = stream(creation: creation)
      count = 0
      if mode == :each
        subject.each { |_event| count += 1 }
      else
        subject.to_enum.each { |_event| count += 1 }
      end

      assert_equal(83, count)
      collector = subject.instance_variable_get(:@collector)
      assert_empty(collector.instance_variable_get(:@messages))
      assert_empty(collector.instance_variable_get(:@required_actions))
      assert_nil(collector.instance_variable_get(:@turn))
      assert_raises(ArgumentError) { subject.get_final_result }
    end
  end

  def test_plain_followup_until_done_does_not_collect_output
    configure(complete)
    subject = stream
    subject.until_done
    assert_empty(subject.instance_variable_get(:@collector).instance_variable_get(:@messages))
    assert_raises(ArgumentError) { subject.get_final_result }
  end

  def test_enabling_collection_after_consumption_fails_before_reading_more
    [false, true].each do |creation|
      configure(complete)
      subject = stream(creation: creation)
      events = creation ? subject.to_enum : subject.each
      events.next
      reads = @server.body.reads
      error = assert_raises(ArgumentError) { subject.with_result_collection }
      assert_match(/before consuming events/, error.message)
      assert_equal(reads, @server.body.reads)
      assert_raises(ArgumentError) { subject.get_final_result }
      assert_equal(reads, @server.body.reads)
      assert(@server.body.closed)
    end
  end

  def test_collection_opt_in_is_fluent_and_idempotent
    [false, true].each do |creation|
      configure(complete)
      subject = stream(creation: creation)
      assert_same(subject, subject.with_result_collection)
      subject.each { |_event| nil }
      assert_same(subject, subject.with_result_collection)
      assert_equal("Answer", subject.get_final_result.output_text)
    end
  end

  def test_unknown_top_level_and_item_variants_remain_visible_and_do_not_break_collection
    unknown = {type: "agent.session.future", payload: {example: "future event"}}
    items = %w[added done].map do |kind|
      {
        type: "agent.session.turn.item.#{kind}",
        session_id: "session_test",
        turn_id: "turn_root",
        output_index: 0,
        item: {type: "future_item", id: "future", turn_id: "turn_root"}
      }
    end

    [false, true].product([false, true]).each do |creation, collecting|
      configure([unknown, turn("created"), *items, answer_event, turn("completed"), idle])
      subject = stream(creation: creation)
      subject.with_result_collection if collecting
      events = subject.to_a
      assert_equal("agent.session.future", events.first.fetch(:type))
      assert_equal("future_item", events[2].item.fetch(:type))
      assert_equal("future_item", events[3].item.fetch(:type))
      if collecting
        assert_equal("Answer", subject.get_final_result.output_text)
      else
        assert_empty(subject.instance_variable_get(:@collector).instance_variable_get(:@messages))
      end
    end
  end

  def test_unknown_required_action_is_returned_as_an_unhandled_action
    pending = {
      type: "agent.session.requires_action",
      session: {
        id: "session_test",
        status: "requires_action",
        required_actions: [{type: "future_action", details: "example"}]
      }
    }
    [false, true].each do |creation|
      configure([turn("created"), pending])
      error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { stream(creation: creation).get_final_result }
      assert_equal(:requires_action, error.reason)
      assert_equal("future_action", error.required_actions.first.fetch(:type))
      assert_equal("example", error.required_actions.first.fetch(:details))
      assert(@server.body.closed)
    end
  end

  def creation_tool_events
    [
      {type: "agent.session.created", session: {id: "session_test", status: "in_progress"}},
      turn("created"),
      {
        type: "agent.session.turn.item.added",
        session_id: "session_test",
        turn_id: "turn_root",
        item: {
          type: "function_call",
          id: "item_tool",
          name: "lookup",
          arguments: "{\"query\":\"A123\"}",
          call_id: "call_test",
          turn_id: "turn_root",
          status: "in_progress"
        }
      }
    ]
  end

  def test_creation_dispatches_initial_tools_with_shared_retry_and_result_collection
    events = creation_tool_events
    configure(events + [events.last, action, answer_event, turn("completed"), idle])
    @server.tool_errors = ["Unknown pending tool call: call_test"]
    calls = []
    arguments = Class.new(OpenAI::BaseModel) { required(:query, String) }
    tool = OpenAI::Helpers::Beta::Agents::FunctionTool.new(name: "lookup", arguments: arguments) do |args|
      calls << args.query
      {value: "found"}
    end

    options = {extra_headers: {"IDEMPOTENCY-KEY" => "creation-key", "x-test" => "yes"}, timeout: 4}
    subject = @sessions
      .create_streaming(
        agent: {model: "test-model", tools: [tool.definition]},
        environment: {type: :none},
        input: "Find A123",
        tool_handlers: tool.handlers,
        request_options: options
      )
      .with_result_collection
    subject.each do |event|
      event.session.id.replace("changed") if event.type == :"agent.session.created"
      event.item.arguments.replace("invalid") if event.type == :"agent.session.turn.item.added"
    end

    assert_equal(["A123"], calls)
    assert_equal("Answer", subject.get_final_result.output_text)
    assert_equal([:post, :post, :post], @server.requests.map(&:method))
    creation, *submissions = @server.requests
    refute(JSON.parse(creation.body).key?("tool_handlers"))
    assert_equal("creation-key", creation.headers["idempotency-key"])
    assert_equal(1, submissions.map { |r| r.headers["idempotency-key"] }.uniq.size)
    refute_equal("creation-key", submissions.first.headers["idempotency-key"])
    submissions.each do |request|
      assert_equal("/v1/agents/sessions/session_test/events", request.url.path)
      assert_equal(4.0, request.timeout)
      assert_equal("yes", request.headers["x-test"])
      assert_equal("agents=v1", request.headers["openai-beta"])
      assert_equal("{\"value\":\"found\"}", JSON.parse(request.body).fetch("events").first.fetch("output"))
    end

    assert_equal("creation-key", options[:extra_headers]["IDEMPOTENCY-KEY"])
    assert(@server.body.closed)
  end

  def test_creation_close_at_tool_event_does_not_run_the_handler
    configure(creation_tool_events + [action])
    calls = []
    subject = @sessions.create_streaming(
      agent: {model: "test-model"},
      environment: {type: :none},
      input: "Find A123",
      tool_handlers: {"lookup" => -> (args) { calls << args }}
    )
    subject.each do |event|
      subject.close if event.type == :"agent.session.turn.item.added"
    end

    assert_empty(calls)
    assert_equal(1, @server.requests.size)
    assert(@server.body.closed)
  end

  def test_creation_handler_failures_are_sanitized_and_unknown_tools_remain_blocked
    configure(creation_tool_events + [answer_event, turn("completed"), idle])
    subject = @sessions.create_streaming(
      agent: {model: "test-model"},
      environment: {type: :none},
      input: "Find A123",
      tool_handlers: {"lookup" => -> (_) { raise "private callback details" }}
    )
    assert_equal("Answer", subject.get_final_result.output_text)
    assert_equal("agents=v1", @server.requests.last.headers["openai-beta"])
    result = JSON.parse(@server.requests.last.body).fetch("events").first
    assert_equal(false, result.fetch("success"))
    refute_includes(JSON.generate(result), "private callback details")

    configure(creation_tool_events + [action])
    subject = @sessions.create_streaming(
      agent: {model: "test-model"},
      environment: {type: :none},
      input: "Find A123",
      tool_handlers: {}
    )
    error = assert_raises(OpenAI::Helpers::Beta::Agents::ResultError) { subject.get_final_result }
    assert_equal(:requires_action, error.reason)
    assert_equal(1, @server.requests.size)
    assert(@server.body.closed)
  end

end
