# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::AgentSessionStreamTest < Minitest::Test
  class Body
    attr_reader :closed, :reads

    def initialize(events)
      @events = events
      @reads = 0
    end

    def each
      @events.each_with_index do |event, index|
        @reads += 1
        yield "data: #{JSON.generate({event_id: index.to_s}.merge(event))}\n\n"
      end
    end

    def close = @closed = true
  end

  class Server < OpenAI::HTTPClient
    attr_accessor :status, :input_error, :tool_errors, :lost_responses
    attr_reader :body, :requests

    def initialize(events)
      super()
      @body = Body.new(events)
      @requests = []
      @status = "idle"
      @tool_errors = []
      @lost_responses = []
    end

    def execute(request)
      @requests << request
      if request.method == :get
        if request.url.path.end_with?("/events")
          return response(200, @body, "text/event-stream")
        end

        return response(200, JSON.generate(id: "session_test", status: @status))
      end

      input = JSON.parse(request.body).fetch("events").first
      kind = input.fetch("type")
      if @lost_responses.delete(kind)
        raise OpenAI::Errors::APIConnectionError.new(url: request.url)
      end

      error = kind == "agent.session.input.message" ? @input_error : @tool_errors.shift
      if error
        return response(
          400,
          JSON.generate(error: {type: "invalid_request_error", code: "invalid_request_error", message: error})
        )
      end

      response(204, "")
    end

    def response(status, body, content_type = "application/json")
      OpenAI::HTTPClient::Response.new(status: status, headers: {"content-type" => content_type}, body: body)
    end

    def submissions
      @requests.select { |r| r.method == :post }.map { |r| JSON.parse(r.body).fetch("events").first }
    end
  end

  def setup
    super
    configure
  end

  def configure(events = [turn("created"), turn("completed"), idle])
    @server = Server.new(events)
    @client = OpenAI::Client.new(
      api_key: "fake-key",
      base_url: "https://sdk-test.example/v1",
      http_client: @server,
      max_retries: 1
    )
    @sessions = @client.beta.agents.sessions
  end

  def test_lifecycle_selects_coordinator_and_waits_for_idle
    configure(
      [
        idle,
        turn("created", "child", "subagent"),
        turn("created"),
        turn("completed", "child"),
        idle,
        turn("completed", "other"),
        idle,
        turn("completed"),
        idle,
        turn("created", "later")
      ]
    )
    events = @sessions.stream("session_test", input: "Hello").to_a
    assert_equal(9, events.size)
    assert_instance_of(OpenAI::Models::Beta::AgentSessionTurnCreatedEvent, events[2])
    assert_equal(9, @server.body.reads)
    assert(@server.body.closed)
    assert_equal([:get, :get, :post], @server.requests.map(&:method))
    assert_equal("/v1/agents/sessions/session_test/events", @server.requests[1].url.path)
    assert_equal(
      [{"role" => "user", "content" => [{"type" => "input_text", "text" => "Hello"}]}],
      @server.submissions.first["input"]
    )
  end

  def test_failed_and_cancelled_turns_remain_visible
    %w[failed cancelled].each do |kind|
      configure([turn("created"), turn(kind), idle])
      assert_equal("agent.session.turn.#{kind}", @sessions.stream("session_test", input: "Hi").to_a[1].type.to_s)
      assert(@server.body.closed)
    end

    configure([{type: "agent.session.failed", session: {id: "session_test", status: "failed"}}])
    assert_equal(1, @sessions.stream("session_test", input: "Hi").to_a.size)
    assert(@server.body.closed)
  end

  def test_cleanup_on_break_exception_explicit_close_and_block_exit
    @sessions.stream("session_test", input: "Hi").each { |event| break if event }
    assert(@server.body.closed)
    configure
    assert_raises(RuntimeError) {
      @sessions.stream("session_test", input: "Hi").each { |event| raise "consumer" if event }
    }
    assert(@server.body.closed)
    configure
    @sessions.stream("session_test", input: "Hi").close
    assert(@server.body.closed)
    configure
    @sessions.stream("session_test", input: "Hi") { |_stream| nil }
    assert(@server.body.closed)
    assert_equal(1, @server.submissions.size)
  end

  def test_until_done_consumes_remaining_events_after_external_iteration
    configure([turn("created"), call("{}"), turn("completed"), idle])
    handled = 0
    stream = @sessions.stream(
      "session_test",
      input: "Hi",
      tool_handlers: {
        "search" => -> (_args) {
          handled += 1
          "ok"
        }
      }
    )
    events = stream.each
    assert_instance_of(OpenAI::Models::Beta::AgentSessionTurnCreatedEvent, events.next)
    stream.until_done
    assert_equal(1, handled)
    assert(@server.body.closed)
    assert_raises(StopIteration) { events.next }
  end

  def test_rejects_active_empty_and_failed_input_and_unexpected_eof
    @server.status = "in_progress"
    assert_raises(ArgumentError) { @sessions.stream("session_test", input: "Hi") }
    assert_equal(1, @server.requests.size)
    ["", []].each { |input| assert_raises(ArgumentError) { @sessions.stream("session_test", input: input) } }
    configure
    @server.input_error = "rejected"
    assert_raises(OpenAI::Errors::BadRequestError) { @sessions.stream("session_test", input: "Hi") }
    assert(@server.body.closed)
    configure([turn("created"), turn("completed")])
    assert_raises(RuntimeError) { @sessions.stream("session_test", input: "Hi").until_done }
    assert(@server.body.closed)
  end

  def test_handlers_are_sequential_deduplicate_calls_and_preserve_events
    first = call({nested: {values: ["original"]}}).merge(event_id: "duplicate")
    configure(
      [
        turn("created"),
        first,
        first,
        call({nested: {values: ["original"]}}),
        call("{}", "call_two"),
        call("{}", "manual", "unknown"),
        turn("completed"),
        idle
      ]
    )
    seen = []
    events = []
    @sessions
      .stream(
        "session_test",
        input: "Hi",
        tool_handlers: {
          "search" => lambda { |args|
            seen << events.last.item.call_id
            args["nested"]&.fetch("values")&.push("changed")
            {ok: true}
          }
        }
      )
      .each { |event| events << event }
    assert_equal(%w[call_test call_two], seen)
    assert_equal(["original"], events[1].item.arguments[:nested][:values])
    assert_equal(7, events.size)
    assert_equal(["{\"ok\":true}", "{\"ok\":true}"], @server.submissions.drop(1).map { |e| e["output"] })
  end

  def test_consumer_mutation_does_not_change_selected_handler_arguments_or_result_routing
    configure([turn("created"), call({nested: {values: ["original"]}}), call("{}"), turn("completed"), idle])
    seen = []
    @sessions
      .stream(
        "session_test",
        input: "Hi",
        tool_handlers: {
          "search" => -> (args) {
            seen << args
            "ok"
          }
        }
      )
      .each do |event|
        event.turn_id.replace("mutated_coordinator") if event.type == :"agent.session.turn.created"
        next unless event.type == :"agent.session.turn.item.added"

        event.item.name.replace("unregistered")
        event.item.call_id.replace("different_call")
        event.item.turn_id.replace("different_turn")
        event.item.arguments[:nested][:values] << "changed" if event.item.arguments.is_a?(Hash)
        event.item.arguments = {changed: true}
      end

    assert_equal([{"nested" => {"values" => ["original"]}}], seen)
    assert_equal("call_test", @server.submissions.last["call_id"])
    assert_equal("turn_root", @server.submissions.last["turn_id"])
    assert_equal(2, @server.submissions.size)
  end

  def test_full_call_dedup_outlives_bounded_event_cache_and_uses_turn_id
    first = call("{}").merge(event_id: "old")
    configure(
      [turn("created"), first] +
        Array.new(1025) { idle } +
        [first, call("{}").merge(item: call("{}")[:item].merge(turn_id: "child")), turn("completed"), idle]
    )
    count = 0
    stream = @sessions.stream(
      "session_test",
      input: "Hi",
      tool_handlers: {
        "search" => -> (_args) {
          count += 1
          nil
        }
      }
    )
    stream.until_done
    assert_equal(2, count)
    assert_operator(stream.instance_variable_get(:@recent_events).size, :<=, 1024)
  end

  def test_invalid_arguments_and_handler_errors_submit_generic_failures
    ["{", "[]", "null", [], 1, nil, "{}"].each do |args|
      configure([turn("created"), call(args), turn("completed"), idle])
      @sessions
        .stream("session_test", input: "Hi", tool_handlers: {"search" => -> (_input) { raise "fake-secret" }})
        .until_done
      result = @server.submissions.last
      assert_equal(false, result["success"])
      assert_equal("Tool handler failed.", result["error"])
      refute_includes(JSON.generate(@server.submissions), "fake-secret")
    end
  end

  def test_malformed_content_outputs_submit_generic_failures
    [[1], [{type: :input_text}], [{type: :input_text, text: 1}], [{type: :input_image, image_url: nil}]].each do |
        output
      |
      configure([turn("created"), call("{}"), turn("completed"), idle])
      @sessions.stream("session_test", input: "Hi", tool_handlers: {"search" => -> (_args) { output }}).until_done
      assert_equal(false, @server.submissions.last["success"])
      assert_equal("Tool handler failed.", @server.submissions.last["error"])
    end
  end

  def test_protocol_errors_preserve_raw_stream_exceptions_and_cleanup
    events = [
      turn("created"),
      {
        type: "error",
        session_id: "session_test",
        error: {type: "server_error", code: "server_error", message: "fake failure"}
      },
      turn("failed"),
      idle
    ]
    configure(events)
    helper_error = assert_raises(OpenAI::Errors::APIStatusError) do
      @sessions.stream("session_test", input: "Hi").until_done
    end

    assert(@server.body.closed)
    assert_equal(2, @server.body.reads)
    configure(events)
    assert_raises(helper_error.class) { @sessions.events.stream_streaming("session_test").to_a }
    assert(@server.body.closed)
  end

  def test_string_null_and_content_outputs
    [
      "answer",
      nil,
      [{type: "input_text", text: "answer"}],
      [OpenAI::Beta::InputContentParam::InputImage.new(image_url: "https://example.com/image.png")]
    ].each do |output|
      configure([turn("created"), call("{}"), turn("completed"), idle])
      @sessions
        .stream(
          "session_test",
          input: [{role: :user, content: [{type: :input_text, text: "Hi"}]}],
          tool_handlers: {"search" => -> (_args) { output }}
        )
        .until_done
      if output.nil?
        assert_nil(@server.submissions.last["output"])
      else
        assert_equal(JSON.parse(JSON.generate(output)), @server.submissions.last["output"])
      end

      assert_equal(true, @server.submissions.last["success"])
    end
  end

  def test_explicit_input_key_precedes_request_options_and_tool_keys_are_distinct
    configure([turn("created"), call("{}"), call("{}", "other_call"), turn("completed"), idle])
    @sessions
      .stream(
        "session_test",
        input: "Hi",
        idempotency_key: "method-key",
        request_options: {idempotency_key: "options-key"},
        tool_handlers: {"search" => -> (_args) { "ok" }}
      )
      .until_done
    keys = @server.requests.select { |request| request.method == :post }.map { |request|
      request.headers["idempotency-key"]
    }
    assert_equal("method-key", keys.first)
    assert_equal(3, keys.uniq.size)
    refute_includes(keys, "options-key")
    configure
    @sessions.stream("session_test", input: "Hi", request_options: {idempotency_key: "options-key"}).until_done
    assert_equal("options-key", @server.requests.last.headers["idempotency-key"])
  end

  def test_retry_keys_options_and_narrow_pending_call_race
    configure([turn("created"), call("{}"), turn("completed"), idle])
    @server.lost_responses = %w[agent.session.input.message agent.session.input.tool_result]
    @server.tool_errors = ["Unknown pending tool call: call_test"]
    options = OpenAI::RequestOptions.new(
      timeout: 4.0,
      extra_headers: {"IDEMPOTENCY-KEY" => "input-key", "X-Test" => "yes"}
    )
    @sessions
      .stream(
        "session_test",
        input: "Hi",
        idempotency_key: "ignored",
        request_options: options,
        tool_handlers: {"search" => -> (_args) { "ok" }}
      )
      .until_done
    posts = @server.requests.select { |r| r.method == :post }
    assert_equal(["input-key"], posts.take(2).map { |r| r.headers["idempotency-key"] }.uniq)
    keys = posts.drop(2).map { |r| r.headers["idempotency-key"] }.uniq
    assert_equal(1, keys.size)
    refute_equal("input-key", keys.first)
    assert_equal(5, posts.size)
    @server.requests.each do |request|
      assert_equal(4.0, request.timeout)
      assert_equal("yes", request.headers["x-test"])
      assert_equal("agents=v1", request.headers["openai-beta"])
    end

    assert_equal("input-key", options.extra_headers["IDEMPOTENCY-KEY"])
    configure([turn("created"), call("{}")])
    @server.tool_errors = ["Unknown pending tool call: different_call"]
    assert_raises(OpenAI::Errors::BadRequestError) do
      @sessions.stream("session_test", input: "Hi", tool_handlers: {"search" => -> (_args) { "ok" }}).until_done
    end

    assert_equal(2, @server.submissions.size)
    assert(@server.body.closed)
  end

  def test_output_text_is_pure_and_independent_of_phase
    [nil, :commentary, :final_answer].each do |phase|
      message = OpenAI::Models::Beta::AgentSessionMessage.new(
        id: "message_test",
        role: :assistant,
        phase: phase,
        status: :completed,
        turn_id: "turn_root",
        content: [
          {type: :output_text, text: "Hello"},
          {type: :input_text, text: "ignored"},
          {type: :input_image, image_url: "https://example.com/image.png"},
          {type: :output_text, text: " world"}
        ]
      )
      original = message.to_json
      assert_equal("Hello world", message.output_text)
      assert_equal(original, message.to_json)
      message.content = []
      assert_equal("", message.output_text)
    end
  end

  private

  def turn(kind, id = "turn_root", subagent_id = nil)
    {
      type: "agent.session.turn.#{kind}",
      session_id: "session_test",
      turn_id: id,
      turn: {
        id: id,
        object: "agent.session.turn",
        agent_id: "agent_test",
        session_id: "session_test",
        created_at: 1,
        status: kind == "created" ? "in_progress" : kind,
        subagent_id: subagent_id
      }
    }
  end

  def idle = {type: "agent.session.idle", session: {id: "session_test", status: "idle"}}

  def call(arguments, call_id = "call_test", name = "search")
    {
      type: "agent.session.turn.item.added",
      session_id: "session_test",
      turn_id: "turn_root",
      item: {
        id: "item_test",
        type: "function_call",
        name: name,
        call_id: call_id,
        arguments: arguments,
        status: "in_progress",
        turn_id: "turn_root"
      }
    }
  end
end
