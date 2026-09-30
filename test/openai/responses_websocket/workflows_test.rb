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

  def test_multiplex_example_fails_on_connection_error_without_waiting_for_eof
    peer_closed = Async::Queue.new
    handler = lambda do |socket|
      2.times { read_event(socket) }
      write_event(socket, type: "error", error: {type: "server_error", message: "synthetic private prompt"})
      # Keep the connection open until the example handles the error.
      begin
        assert_nil(socket.read)
      rescue EOFError, Protocol::WebSocket::ClosedError
        nil
      ensure
        peer_closed.enqueue(true)
      end
    end

    with_server(handler) do |client|
      error = assert_raises(RuntimeError) { Workflows.multiplex(client: client, model: "example-model") }
      assert_equal("Responses WebSocket operation did not complete.", error.message)
      refute_includes(error.full_message, "synthetic private prompt")
      assert(peer_closed.dequeue)
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

  def test_bounded_receive_counts_utf8_fragments_allows_ping_and_resets_between_messages
    data = JSON.generate(delta_event("hello 🌍", lane: "main"))
    handler = lambda do |socket|
      read_event(socket)
      midpoint = data.b.index("🌍".b) + 1
      2.times do
        socket.write_frame(Protocol::WebSocket::TextFrame.new(false).pack(data.byteslice(0, midpoint)))
        # Control frames must work even when they exceed the remaining message bytes.
        socket.write_frame(Protocol::WebSocket::PingFrame.new.pack("p" * 125))
        socket.write_frame(Protocol::WebSocket::ContinuationFrame.new(true).pack(data.byteslice(midpoint..)))
        socket.flush
      end

      2.times do
        pong = socket.read_frame
        assert_instance_of(Protocol::WebSocket::PongFrame, pong)
        assert_equal("p" * 125, pong.unpack)
      end
    end

    with_server(handler) do |client|
      client
        .responses
        .connect(
          transport_options: {max_message_bytes: data.bytesize, max_message_frames: 2}
        ) do |connection|
          connection.response.create(model: "example-model", input: "test", stream_id: "main")
          2.times do
            event = connection.receive
            assert_kind_of(OpenAI::Responses::ResponseTextDeltaEvent, event)
            assert_equal("hello 🌍", event.delta)
          end
          # Native pongs flush on the next read. The server then closes after both.
          assert_nil(connection.receive)
        end
    end
  end

  def test_compressed_wire_and_decoded_limits_reset_without_losing_small_inflate_tail
    text = "Hola 🌍 " * 25
    data = JSON.generate(delta_event(text, lane: "main"))
    handler = lambda do |socket|
      read_event(socket)
      assert_instance_of(Protocol::WebSocket::Extension::Compression::Deflate, socket.writer)
      2.times do
        compressed = socket.writer.pack_text_frame(data).unpack
        split = compressed.bytesize / 2
        first = Protocol::WebSocket::TextFrame.new(false).pack(compressed.byteslice(0, split))
        first.flags |= Protocol::WebSocket::Frame::RSV1
        socket.write_frame(first)
        socket.write_frame(Protocol::WebSocket::PingFrame.new.pack("p" * 125))
        socket.write_frame(Protocol::WebSocket::ContinuationFrame.new(true).pack(compressed.byteslice(split..)))
        socket.flush
      end

      2.times do
        pong = socket.read_frame
        assert_instance_of(Protocol::WebSocket::PongFrame, pong)
        assert_equal("p" * 125, pong.unpack)
      end
    end

    with_server(handler) do |client|
      client
        .responses
        .connect(
          transport_options: {
            max_wire_message_bytes: data.bytesize,
            max_message_bytes: data.bytesize,
            max_message_frames: 2
          }
        ) do |connection|
          connection.response.create(model: "example-model", input: "test")
          2.times do
            event = connection.receive
            assert_kind_of(OpenAI::Responses::ResponseTextDeltaEvent, event)
            assert_equal(text, event.delta)
          end

          assert_nil(connection.receive)
        end
    end
  end

  def test_compressed_wire_limit_does_not_imply_a_decoded_limit
    text = "kept 🌍 " * 10_000
    handler = lambda do |socket|
      read_event(socket)
      assert_instance_of(Protocol::WebSocket::Extension::Compression::Deflate, socket.writer)
      write_delta(socket, text, lane: "main")
    end

    with_server(handler) do |client|
      client.responses.connect(transport_options: {max_wire_message_bytes: 4_096}) do |connection|
        connection.response.create(model: "example-model", input: "test")
        assert_equal(text, connection.receive.delta)
      end
    end
  end

  def test_compressed_limits_reset_after_server_declares_no_context_takeover
    text = "Separate windows 🌍 " * 10
    data = JSON.generate(delta_event(text, lane: "main"))
    compression = Protocol::WebSocket::Extension::Compression
    extensions = Protocol::WebSocket::Extensions::Server.new([[compression, {server_no_context_takeover: true}]])
    # The gem's server options set its deflater but aren't included in the response
    # header unless the client asked first. Advertise the chosen server behavior.
    def extensions.accept(headers)
      super do |header|
        header << "server_no_context_takeover"
        yield header
      end
    end

    handler = lambda do |socket|
      read_event(socket)
      assert_instance_of(Protocol::WebSocket::Extension::Compression::Deflate, socket.writer)
      refute(socket.writer.context_takeover)
      2.times { write_delta(socket, text, lane: "main") }
    end

    with_server(handler, extensions: extensions) do |client|
      client
        .responses
        .connect(
          transport_options: {max_wire_message_bytes: data.bytesize, max_message_bytes: data.bytesize}
        ) do |connection|
          connection.response.create(model: "example-model", input: "test")
          2.times { assert_equal(text, connection.receive.delta) }
        end
    end
  end

  def test_small_compressed_tail_is_rejected_one_decoded_byte_over_budget
    data = JSON.generate(delta_event("short 🌍", lane: "main"))
    handler = lambda do |socket|
      read_event(socket)
      assert_instance_of(Protocol::WebSocket::Extension::Compression::Deflate, socket.writer)
      socket.write(Protocol::WebSocket::TextMessage.new(data))
      socket.flush
    end

    with_server(handler) do |client|
      client
        .responses
        .connect(
          transport_options: {max_wire_message_bytes: 1_024, max_message_bytes: data.bytesize - 1}
        ) do |connection|
          connection.response.create(model: "example-model", input: "test")
          assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive }
          assert_predicate(connection, :closed?)
        end
    end
  end

  def test_finished_deflate_trailing_input_obeys_decoded_limit
    [true, false].each do |context_takeover|
      assert_finished_deflate_limit(context_takeover: context_takeover)
    end
  end

  def test_reused_finished_inflater_obeys_decoded_limit
    assert_finished_deflate_limit(context_takeover: true, prime_finished_inflater: true)
  end

  def test_compressed_decoded_limit_aborts_before_peer_teardown_and_rejects_later_write
    text = "synthetic response content " * 50_000
    peer_closed = Async::Queue.new
    handler = lambda do |socket|
      read_event(socket)
      assert_instance_of(Protocol::WebSocket::Extension::Compression::Deflate, socket.writer)
      write_delta(socket, text, lane: "main")
      begin
        assert_nil(socket.read)
      rescue EOFError, Protocol::WebSocket::ClosedError
        nil
      ensure
        peer_closed.enqueue(true)
      end
    end

    with_server(handler) do |client|
      client
        .responses
        .connect(
          transport_options: {max_wire_message_bytes: 64_000, max_message_bytes: 512}
        ) do |connection|
          connection.response.create(model: "example-model", input: "test")
          Async::Task.current.with_timeout(2, Minitest::Assertion) do
            error = assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive }
            refute_includes(error.full_message, "synthetic response content")
            assert(peer_closed.dequeue)
          end

          assert_predicate(connection, :closed?)
          assert_raises(OpenAI::Errors::ResponsesConnectionError) do
            connection.response.create(model: "example-model", input: "must not replay")
          end
        end
    end
  end

  def test_plain_messages_obey_decoded_limit_even_when_compression_was_negotiated
    data = JSON.generate(delta_event("uncompressed 🌍", lane: "main"))
    handler = lambda do |socket|
      read_event(socket)
      assert_instance_of(Protocol::WebSocket::Extension::Compression::Deflate, socket.writer)
      # RSV1 is deliberately clear: servers need not compress every message.
      split = data.bytesize / 2
      socket.write_frame(Protocol::WebSocket::TextFrame.new(false).pack(data.byteslice(0, split)))
      socket.write_frame(Protocol::WebSocket::ContinuationFrame.new(true).pack(data.byteslice(split..)))
      socket.flush
    end

    with_server(handler) do |client|
      client
        .responses
        .connect(
          transport_options: {max_wire_message_bytes: data.bytesize + 500, max_message_bytes: data.bytesize - 1}
        ) do |connection|
          connection.response.create(model: "example-model", input: "test")
          assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive }
          assert_predicate(connection, :closed?)
        end
    end
  end

  def test_both_byte_limits_apply_when_server_declines_compression
    data = JSON.generate(delta_event("plain 🌍", lane: "main"))
    handler = lambda do |socket|
      read_event(socket)
      refute_kind_of(Protocol::WebSocket::Extension::Compression::Deflate, socket.writer)
      write_delta(socket, "plain 🌍", lane: "main")
      write_delta(socket, "plain 🌍!", lane: "main")
    end

    with_server(handler, extensions: nil) do |client|
      client
        .responses
        .connect(
          transport_options: {max_wire_message_bytes: data.bytesize + 500, max_message_bytes: data.bytesize}
        ) do |connection|
          connection.response.create(model: "example-model", input: "test")
          assert_equal("plain 🌍", connection.receive.delta)
          assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive }
          assert_predicate(connection, :closed?)
        end
    end
  end

  def test_plain_header_obeys_smaller_decoded_cap_before_first_or_continued_body
    [false, true].each do |compression|
      [false, true].each do |continued|
        peer_closed = Async::Queue.new
        handler = lambda do |socket|
          read_event(socket)
          assert_equal(compression, socket.writer.is_a?(Protocol::WebSocket::Extension::Compression::Deflate))
          if continued
            socket.write_frame(Protocol::WebSocket::TextFrame.new(false).pack("{"))
            socket.write_frame(Protocol::WebSocket::PingFrame.new.pack("p" * 125))
          end
          # This uncompressed header fits the wire cap but not the decoded cap.
          # Leave the peer open without a body; waiting for it isn't bounded receive.
          header = continued ? 0x80 : 0x81
          socket.framer.instance_variable_get(:@stream).write([header, 0x7F, 1_048_576].pack("CCQ>"))
          socket.flush
          begin
            assert_nil(socket.read)
          rescue EOFError, Protocol::WebSocket::ClosedError
            nil
          ensure
            peer_closed.enqueue(true)
          end
        end

        extensions = compression ? Protocol::WebSocket::Extensions::Server.default : nil
        with_server(handler, extensions: extensions) do |client|
          client
            .responses
            .connect(
              transport_options: {max_wire_message_bytes: 2_097_152, max_message_bytes: 1_024}
            ) do |connection|
              connection.response.create(model: "example-model", input: "test")
              Async::Task.current.with_timeout(2, Minitest::Assertion) do
                assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive }
                assert(peer_closed.dequeue)
              end

              assert_predicate(connection, :closed?)
            end
        end
      end
    end
  end

  def test_wire_budget_can_fit_a_valid_compressed_message_larger_than_its_decoded_budget
    text = "full wire block 🌍 " * 20
    data = JSON.generate(delta_event(text, lane: "main"))
    compression = Protocol::WebSocket::Extension::Compression
    extensions = Protocol::WebSocket::Extensions::Server.new([[compression, {level: Zlib::NO_COMPRESSION}]])
    handler = lambda do |socket|
      read_event(socket)
      frame = socket.writer.pack_text_frame(data)
      # A valid stored DEFLATE block can exceed decoded size, above the control
      # frame allowance too. A blanket min(wire, decoded) would reject it.
      assert_operator(frame.length, :>, data.bytesize)
      socket.write_frame(frame)
      socket.flush
    end

    with_server(handler, extensions: extensions) do |client|
      client
        .responses
        .connect(
          transport_options: {max_wire_message_bytes: 1_024, max_message_bytes: data.bytesize}
        ) do |connection|
          connection.response.create(model: "example-model", input: "test")
          assert_equal(text, connection.receive.delta)
        end
    end
  end

  def test_new_wire_limit_rejects_oversized_header_without_reading_an_unavailable_payload
    peer_closed = Async::Queue.new
    handler = lambda do |socket|
      read_event(socket)
      # FIN + RSV1 + text, unmasked 64-bit length, no advertised body.
      # Send literal wire bytes: versions 0.20 and 0.21 serialize frame metadata differently.
      socket.framer.instance_variable_get(:@stream).write([0xC1, 0x7F, 1_048_576].pack("CCQ>"))
      socket.flush
      begin
        assert_nil(socket.read)
      rescue EOFError, Protocol::WebSocket::ClosedError
        nil
      ensure
        peer_closed.enqueue(true)
      end
    end

    with_server(handler) do |client|
      client
        .responses
        .connect(
          transport_options: {max_wire_message_bytes: 1_024, max_message_bytes: 4_000}
        ) do |connection|
          connection.response.create(model: "example-model", input: "test")
          Async::Task.current.with_timeout(2, Minitest::Assertion) do
            assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive }
            assert(peer_closed.dequeue)
          end

          assert_predicate(connection, :closed?)
        end
    end
  end

  def test_bounded_receive_rejects_truncated_oversized_frame_before_waiting_for_payload
    peer_closed = Async::Queue.new
    handler = lambda do |socket|
      read_event(socket)
      # Write a real extended-length header with no body, leaving the peer open.
      # An unbounded reader waits for data that will never arrive.
      socket.framer.instance_variable_get(:@stream).write([0x81, 0x7F, 1_048_576].pack("CCQ>"))
      socket.flush
      begin
        assert_nil(socket.read)
      rescue EOFError, Protocol::WebSocket::ClosedError
        nil
      ensure
        peer_closed.enqueue(true)
      end
    end

    with_server(handler) do |client|
      client.responses.connect(transport_options: {max_message_bytes: 1_024}) do |connection|
        connection.response.create(model: "example-model", input: "test")
        # An assertion cannot be sanitized as a transport error if this times out.
        Async::Task.current.with_timeout(2, Minitest::Assertion) do
          assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive }
          assert(peer_closed.dequeue)
        end

        assert_predicate(connection, :closed?)
        assert_raises(OpenAI::Errors::ResponsesConnectionError) do
          connection.response.create(model: "example-model", input: "must not replay")
        end
      end
    end
  end

  def test_bounded_receive_rejects_message_one_byte_past_budget
    data = JSON.generate(delta_event("synthetic private text 🌍", lane: "main"))
    handler = lambda do |socket|
      read_event(socket)
      midpoint = data.b.index("🌍".b) + 1
      socket.write_frame(Protocol::WebSocket::TextFrame.new(false).pack(data.byteslice(0, midpoint)))
      socket.write_frame(Protocol::WebSocket::ContinuationFrame.new(true).pack(data.byteslice(midpoint..)))
      socket.flush
    end

    with_server(handler) do |client|
      client.responses.connect(transport_options: {max_message_bytes: data.bytesize - 1}) do |connection|
        connection.response.create(model: "example-model", input: "test")
        error = assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive }
        refute_includes(error.full_message, "synthetic private text")
        assert_predicate(connection, :closed?)
      end
    end
  end

  def test_bounded_receive_rejects_empty_continuations_before_unbounded_frame_buffering
    peer_closed = Async::Queue.new
    handler = lambda do |socket|
      read_event(socket)
      socket.write_frame(Protocol::WebSocket::TextFrame.new(false).pack("{"))
      3.times { socket.write_frame(Protocol::WebSocket::ContinuationFrame.new(false).pack("")) }
      socket.flush
      begin
        assert_nil(socket.read)
      rescue EOFError, Protocol::WebSocket::ClosedError
        nil
      ensure
        peer_closed.enqueue(true)
      end
    end

    with_server(handler) do |client|
      client.responses.connect(transport_options: {max_message_bytes: 1_024, max_message_frames: 3}) do |connection|
        connection.response.create(model: "example-model", input: "test")
        Async::Task.current.with_timeout(2, Minitest::Assertion) do
          assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive }
          assert(peer_closed.dequeue)
        end

        assert_predicate(connection, :closed?)
      end
    end
  end

  def test_frame_only_limit_rejects_large_fourth_frame_before_reading_its_body
    peer_closed = Async::Queue.new
    handler = lambda do |socket|
      read_event(socket)
      socket.write_frame(Protocol::WebSocket::TextFrame.new(false).pack("{"))
      2.times { socket.write_frame(Protocol::WebSocket::ContinuationFrame.new(false).pack("")) }
      frame = Protocol::WebSocket::ContinuationFrame.new(false).pack("")
      def frame.length = 1_048_576
      socket.write_frame(frame)
      socket.flush
      begin
        assert_nil(socket.read)
      rescue EOFError, Protocol::WebSocket::ClosedError
        nil
      ensure
        peer_closed.enqueue(true)
      end
    end

    with_server(handler) do |client|
      client.responses.connect(transport_options: {max_message_frames: 3}) do |connection|
        connection.response.create(model: "example-model", input: "test")
        Async::Task.current.with_timeout(2, Minitest::Assertion) do
          assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive }
          assert(peer_closed.dequeue)
        end

        assert_predicate(connection, :closed?)
      end
    end
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

  private def assert_finished_deflate_limit(context_takeover:, prime_finished_inflater: false)
    deflater = Zlib::Deflate.new(Zlib::DEFAULT_COMPRESSION, -Zlib::MAX_WBITS)
    # Cross a native output chunk as well as exercising the uncounted tail.
    finished = deflater.deflate("x" * 20_000, Zlib::FINISH)
    deflater.close
    payload = finished + ("synthetic unused input " * 50_000)
    peer_closed = Async::Queue.new
    compression = Protocol::WebSocket::Extension::Compression
    extensions = Protocol::WebSocket::Extensions::Server.new(
      [[compression, {server_no_context_takeover: !context_takeover}]]
    )
    unless context_takeover
      def extensions.accept(headers)
        super do |header|
          header << "server_no_context_takeover"
          yield header
        end
      end
    end

    handler = lambda do |socket|
      read_event(socket)
      assert_instance_of(compression::Deflate, socket.writer)
      assert_equal(context_takeover, socket.writer.context_takeover)
      if prime_finished_inflater
        first = Protocol::WebSocket::BinaryFrame.new.pack(finished)
        first.flags |= Protocol::WebSocket::Frame::RSV1
        socket.write_frame(first)
        socket.flush
      end

      split = payload.bytesize / 2
      first = Protocol::WebSocket::BinaryFrame.new(false).pack(payload.byteslice(0, split))
      first.flags |= Protocol::WebSocket::Frame::RSV1
      socket.write_frame(first)
      socket.write_frame(Protocol::WebSocket::ContinuationFrame.new(true).pack(payload.byteslice(split..)))
      socket.flush
      # A budget violation must abort, not send a close frame and await a reply.
      begin
        assert_nil(socket.read_frame)
      rescue EOFError, Protocol::WebSocket::ClosedError
        nil
      ensure
        peer_closed.enqueue(true)
      end
    end

    with_server(handler, extensions: extensions) do |client|
      client
        .responses
        .connect(
          transport_options: {max_wire_message_bytes: payload.bytesize, max_message_bytes: 32_768}
        ) do |connection|
          connection.response.create(model: "example-model", input: "test")
          assert_operator(connection.receive_raw.bytesize, :<=, 32_768) if prime_finished_inflater
          # Binary messages and receive_raw avoid a later UTF-8/JSON rejection
          # masking the decoded-budget bypass after the oversized allocation.
          Async::Task.current.with_timeout(2, Minitest::Assertion) do
            assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive_raw }
            assert(peer_closed.dequeue)
          end

          assert_predicate(connection, :closed?)
          assert_raises(OpenAI::Errors::ResponsesConnectionError) do
            connection.response.create(model: "example-model", input: "must not replay")
          end
        end
    end
  end

  private def with_server(handler, **server_options)
    Sync do |task|
      task.with_timeout(10) do
        endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:0")
        bound = endpoint.bound
        port = bound.sockets.first.local_address.ip_port
        fallback = -> (_request) { Protocol::HTTP::Response[404, {}, []] }
        errors = []
        websocket = Async::WebSocket::Server.new(fallback, **server_options) do |socket|
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
