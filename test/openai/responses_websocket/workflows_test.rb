# frozen_string_literal: true

require "async/http/server"
require "async/queue"
require "async/websocket/adapters/http"
require "async/websocket/server"
require "io/endpoint/bound_endpoint"
require "stringio"

require_relative "../test_helper"
require_relative "../../../examples/responses/websocket_workflows"

class OpenAI::Test::ResponsesWebSocketWorkflowsTest < Minitest::Test
  extend Minitest::Serial

  Workflows = OpenAI::Examples::ResponsesWebSocketWorkflows

  # Cross 32 MiB without imposing an API maximum. Keep this probe large and
  # sequential; never shrink it or raise client limits merely to pass CI.
  PAYLOAD_BYTES = (32 * 1024 * 1024) + 1

  def test_multiplex_example_waits_for_both_interleaved_lanes
    handler = lambda do |socket|
      creates = [read_event(socket), read_event(socket)]
      assert_equal(%w[planner critic], creates.map { |event| event.fetch("stream_id") })
      assert_equal(["response.create"], creates.map { |event| event.fetch("type") }.uniq)
      write_event(socket, type: "response.future_event", stream_id: "critic", extra: "new field")
      write_completed(socket, id: "resp_critic", lane: "critic")
      write_delta(socket, "planner is still running", lane: "planner")
      write_completed(socket, id: "resp_planner", lane: "planner")
    end

    with_server(handler) do |client|
      responses = Workflows.multiplex(client: client, model: "example-model")
      assert_equal("resp_critic", responses.fetch("critic").id)
      assert_equal("resp_planner", responses.fetch("planner").id)
    end
  end

  def test_tool_example_continues_with_only_the_tool_result
    handler = lambda do |socket|
      first = read_event(socket)
      refute(first.key?("stream_id"))
      assert_equal(false, first.fetch("store"))
      assert_equal("get_delivery_day", first.fetch("tool_choice").fetch("name"))
      write_completed(
        socket,
        id: "resp_tool",
        output: [{type: "function_call", id: "fc_1", call_id: "call_1", name: "get_delivery_day", arguments: "{}"}]
      )
      second = read_event(socket)
      assert_equal("resp_tool", second.fetch("previous_response_id"))
      assert_equal(
        [{"type" => "function_call_output", "call_id" => "call_1", "output" => "Tuesday"}],
        second.fetch("input")
      )
      assert_equal(false, second.fetch("store"))
      write_completed(socket, id: "resp_answer")
    end

    with_server(handler) do |client|
      assert_equal("resp_answer", Workflows.tools(client: client, model: "example-model").fetch(nil).id)
    end
  end

  def test_runner_reports_success_only_after_both_lanes_finish
    handler = lambda do |socket|
      2.times { read_event(socket) }
      write_completed(socket, id: "resp_planner", lane: "planner")
      write_completed(socket, id: "resp_critic", lane: "critic")
    end

    with_server(handler) do |client|
      output = StringIO.new
      Workflows.run(client: client, model: "example-model", workflow: "multiplex", output: output)
      assert_equal("Responses WebSocket workflow completed.\n", output.string)
    end
  end

  def test_tool_example_rejects_an_unexpected_tool_name
    handler = lambda do |socket|
      read_event(socket)
      write_completed(
        socket,
        id: "resp_tool",
        output: [{type: "function_call", id: "fc_1", call_id: "call_1", name: "unknown_tool", arguments: "{}"}]
      )
    end

    with_server(handler) do |client|
      error = assert_raises(RuntimeError) { Workflows.tools(client: client, model: "example-model") }
      assert_equal("Expected the example delivery tool call.", error.message)
    end
  end

  def test_reconnect_examples_distinguish_stored_ids_from_full_stateless_history
    [true, false].each do |store|
      requests = []
      output = [
        {type: "reasoning", id: "rs_1", summary: [], encrypted_content: "synthetic-encrypted-state"},
        {
          type: "message",
          id: "msg_1",
          role: "assistant",
          status: "completed",
          content: [{type: "output_text", text: "Tuesday", annotations: []}]
        }
      ]
      handler = lambda do |socket|
        requests << read_event(socket)
        write_completed(socket, id: "resp_#{requests.length}", output: output)
      end

      with_server(handler) do |client|
        result = Workflows.reconnect(client: client, model: "example-model", store: store)
        assert_equal("resp_2", result.fetch(nil).id)
      end

      assert_equal(2, requests.length)
      first, second = requests
      assert_includes(first.fetch("include"), "reasoning.encrypted_content")
      assert_equal(store, second.fetch("store"))
      if store
        assert_equal("resp_1", second.fetch("previous_response_id"))
        assert_equal(1, second.fetch("input").length)
      else
        refute(second.key?("previous_response_id"))
        history = second.fetch("input")
        assert_equal(first.fetch("input").first, history.first)
        assert_equal("synthetic-encrypted-state", history.fetch(1).fetch("encrypted_content"))
        assert_equal("Tuesday", history.fetch(2).fetch("content").first.fetch("text"))
        assert_equal("user", history.last.fetch("role"))
        assert_equal(4, history.length)
      end
    end
  end

  def test_premature_eof_is_not_a_successful_workflow
    handler = lambda do |socket|
      2.times { read_event(socket) }
      write_completed(socket, id: "resp_critic", lane: "critic")
    end

    with_server(handler) do |client|
      output = StringIO.new
      error = assert_raises(RuntimeError) do
        Workflows.run(client: client, model: "example-model", workflow: "multiplex", output: output)
      end

      assert_equal("Responses WebSocket closed with unfinished work.", error.message)
      assert_empty(output.string)
    end
  end

  def test_failed_incomplete_and_error_events_fail_without_echoing_payloads
    %w[response.failed response.incomplete error].each do |type|
      handler = lambda do |socket|
        2.times { read_event(socket) }
        write_event(
          socket,
          type: type,
          stream_id: "planner",
          sequence_number: 1,
          response: {id: "resp_failed", status: "failed", output: []},
          error: {type: "server_error", message: "synthetic private prompt"}
        )
      end

      with_server(handler) do |client|
        error = assert_raises(RuntimeError) { Workflows.multiplex(client: client, model: "example-model") }
        assert_equal("Responses WebSocket operation did not complete.", error.message)
        refute_includes(error.full_message, "synthetic private prompt")
      end
    end
  end

  def test_fragmented_messages_are_typed_and_eof_prevents_further_writes
    handler = lambda do |socket|
      assert_equal("response.create", read_event(socket).fetch("type"))
      data = JSON.generate(delta_event("hello 🌍", lane: "main"))
      # Split inside a multi-byte codepoint, not just between JSON tokens.
      midpoint = data.index("🌍") + 1
      socket.write_frame(Protocol::WebSocket::TextFrame.new(false).pack(data.byteslice(0, midpoint)))
      socket.write_frame(Protocol::WebSocket::ContinuationFrame.new(true).pack(data.byteslice(midpoint..)))
      socket.flush
    end

    with_server(handler) do |client|
      client.responses.connect do |connection|
        connection.response.create(model: "example-model", input: "test", stream_id: "main")
        event = connection.receive
        assert_kind_of(OpenAI::Responses::ResponseTextDeltaEvent, event)
        assert_equal("hello 🌍", event.delta)
        assert_equal("main", event.stream_id)
        assert_nil(connection.receive)
        assert_predicate(connection, :closed?)
        assert_raises(OpenAI::Errors::ResponsesConnectionError) do
          connection.response.create(model: "example-model", input: "must not send")
        end
      end
    end
  end

  def test_large_event_is_preserved_by_the_default_responses_transport
    text = "x" * PAYLOAD_BYTES
    handler = lambda do |socket|
      read_event(socket)
      write_delta(socket, text, lane: "large")
    end

    with_server(handler) do |client|
      client.responses.connect do |connection|
        connection.response.create(model: "example-model", input: "Synthetic large event", stream_id: "large")
        event = connection.receive
        assert_equal(PAYLOAD_BYTES, event.delta.bytesize)
        assert_equal(Digest::SHA256.hexdigest(text), Digest::SHA256.hexdigest(event.delta))
        assert_equal("large", event.stream_id)
      end
    end

  ensure
    GC.start
  end

  def test_operation_deadline_interrupts_an_idle_read_and_does_not_replay
    requests = []
    peer_closed = Async::Queue.new
    ready = Async::Queue.new
    handler = lambda do |socket|
      requests << read_event(socket)
      requests << read_event(socket)
      ready.enqueue(true)
      # Stay idle until the client's operation deadline aborts the connection.
      begin
        assert_nil(socket.read)
      rescue EOFError, Protocol::WebSocket::ClosedError
        # Abort closes the underlying IO without a graceful WebSocket close.
        nil
      ensure
        peer_closed.enqueue(true)
      end
    end

    started_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    with_server(handler) do |client|
      client.responses.connect do |connection|
        %w[planner critic].each do |lane|
          connection.response.create(model: "example-model", input: "Hello", stream_id: lane)
        end

        ready.dequeue
        assert_raises(OpenAI::Errors::ResponsesConnectionError) do
          Async::Task.current.with_timeout(0.1) do
            Workflows.completed_responses(connection, lanes: %w[planner critic])
          end
        end

        assert_operator(
          Process.clock_gettime(Process::CLOCK_MONOTONIC) - started_at,
          :<,
          5,
          "The operation deadline must fire before the 10-second harness timeout."
        )
      end

      assert(peer_closed.dequeue)
      assert_equal(2, requests.length)
    end
  end

  private def with_server(handler)
    Sync do |task|
      task.with_timeout(10) do
        endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:0")
        bound = endpoint.bound
        port = bound.sockets.first.local_address.ip_port
        fallback = -> (_request) { Protocol::HTTP::Response[404, {}, []] }
        errors = []
        websocket = Async::WebSocket::Server.new(fallback) do |socket|
          handler.call(socket)
        rescue StandardError, Minitest::Assertion => e
          errors << e
        end

        server = Async::HTTP::Server.new(websocket, bound, protocol: endpoint.protocol, scheme: endpoint.scheme)
        server_task = server.run
        client = OpenAI::Client.new(api_key: "fake-test-key", base_url: "http://127.0.0.1:#{port}/v1")
        yield(client)
        raise errors.first unless errors.empty?
      ensure
        server_task&.stop
        bound&.close
      end
    end
  end

  private def read_event(socket) = JSON.parse(socket.read.to_str)

  private def write_event(socket, **event)
    socket.write(Protocol::WebSocket::TextMessage.generate(event))
    socket.flush
  end

  private def write_completed(socket, id:, lane: nil, output: [])
    event = {type: "response.completed", sequence_number: 1, response: {id: id, status: "completed", output: output}}
    event[:stream_id] = lane unless lane.nil?
    write_event(socket, **event)
  end

  private def delta_event(text, lane:)
    {
      type: "response.output_text.delta",
      item_id: "msg_1",
      output_index: 0,
      content_index: 0,
      sequence_number: 0,
      delta: text,
      stream_id: lane
    }
  end

  private def write_delta(socket, text, lane:) = write_event(socket, **delta_event(text, lane: lane))
end
