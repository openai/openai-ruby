# frozen_string_literal: true

require_relative "connection_test_support"
require "protocol/websocket/error"

class OpenAI::Test::RealtimeReconnectTest < Minitest::Test
  include OpenAI::Test::RealtimeConnectionTestSupport

  # Concrete socket/transport protocol objects allow deterministic I/O failures
  # and blocked handshakes without relying on timing or a real network.
  class Socket < FakeSocket
    attr_accessor :write_action

    def read
      value = super
      value = value.call if value.respond_to?(:call)
      raise value if value.is_a?(Exception)

      value
    end

    def write(message)
      @write_action&.call(message)
      super
    end
  end

  class Transport
    attr_reader :requests, :active, :max_active

    def initialize(*steps)
      @steps = steps
      @requests = []
      @active = 0
      @max_active = 0
    end

    def open(**request)
      @requests << request
      value = @steps.shift
      value = value.call if value.respond_to?(:call)
      raise value if value.is_a?(Exception)
      raise "unexpected connection attempt" unless value

      @active += 1
      @max_active = [@max_active, @active].max
      begin
        yield(value)
      ensure
        @active -= 1
      end
    end
  end

  class ChildTaskTransport < Transport
    def open(**request, &block)
      Async::Task.current.async { super(**request, &block) }.wait
    end
  end

  def around
    Thread.current.thread_variable_set(:mock_sleep, [])
    Timeout.timeout(10) { super }
  ensure
    Thread.current.thread_variable_set(:mock_sleep, nil)
  end

  def test_reconnect_is_disabled_by_default
    error = disconnected
    transport = Transport.new(Socket.new(error))
    raised = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      client.realtime.connect(model: "test-model", transport: transport, &:receive)
    end

    assert_same(error, raised)
    assert_equal(1, transport.requests.length)
  end

  def test_receive_recovers_without_rerunning_the_block
    first = Socket.new(disconnected)
    second = Socket.new(text_delta("recovered"))
    transport = Transport.new(first, second)
    calls = 0
    connection = nil
    result = connect(transport) do |value|
      calls += 1
      connection = value
      assert_equal("recovered", value.receive.delta)
      :result
    end

    assert_equal(:result, result)
    assert_equal(1, calls)
    assert_equal(2, transport.requests.length)
    assert_equal(1, transport.max_active)
    assert_equal(0, transport.active)
    assert_predicate(first, :aborted?)
    assert_predicate(second, :closed?)
    assert_predicate(connection, :closed?)
  end

  def test_each_recovers_and_normal_close_is_terminal
    transport = Transport.new(Socket.new(text_delta("first"), disconnected), Socket.new(text_delta("second")))
    values = connect(transport) { |connection| connection.map(&:delta) }
    assert_equal(%w[first second], values)
    assert_equal(2, transport.requests.length)
  end

  def test_permanent_close_and_tls_failures_are_not_retried
    [disconnected(1008), connection_error(OpenSSL::SSL::SSLError.new("untrusted"))].each do |error|
      transport = Transport.new(Socket.new(error))
      assert_raises(OpenAI::Errors::RealtimeReconnectError) { connect(transport, &:receive) }
      assert_equal(1, transport.requests.length)
    end
  end

  def test_retry_budget_bounds_flapping_connections
    sockets = Array.new(4) { Socket.new(disconnected) }
    transport = Transport.new(*sockets)
    assert_raises(OpenAI::Errors::RealtimeReconnectError) do
      connect(transport, max_reconnect_attempts: 3, &:receive)
    end

    assert_equal(4, transport.requests.length)
    delays = Thread.current.thread_variable_get(:mock_sleep)
    assert_equal(3, delays.length)
    delays.zip([0.5, 1.0, 2.0]).each do |delay, maximum|
      assert_operator(delay, :<=, maximum)
      assert_operator(delay, :>=, maximum * 0.75)
    end
  end

  def test_transient_handshake_failure_can_recover
    transport = Transport.new(connection_error(Errno::ECONNREFUSED.new), Socket.new(text_delta("ready")))
    assert_equal("ready", connect(transport, &:receive).delta)
    assert_equal(2, transport.requests.length)
  end

  def test_permanent_handshake_failure_stops
    transport = Transport.new(
      OpenAI::Errors::RealtimeConnectionError.new(url: URI("wss://example.com"), http_status: 403)
    )
    assert_raises(OpenAI::Errors::RealtimeReconnectError) { connect(transport) { |_connection| nil } }
    assert_equal(1, transport.requests.length)
  end

  def test_user_exception_is_not_retried
    error = disconnected
    transport = Transport.new(Socket.new)
    raised = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      connect(transport) { |_connection| raise error }
    end

    assert_same(error, raised)
    assert_equal(1, transport.requests.length)
    assert_equal(0, transport.active)
  end

  def test_callbacks_are_optional_and_get_the_same_connection
    transport = Transport.new(Socket.new(disconnected), Socket.new(text_delta("ready")))
    original = nil
    callback = -> (connection) { assert_same(original, connection) }
    connect(transport, on_reconnected: callback) do |connection|
      original = connection
      assert_equal("ready", connection.receive.delta)
    end
  end

  def test_callback_uses_the_fiber_that_the_transport_yields_from
    replacement = Socket.new(text_delta("acknowledged"), text_delta("ready"))
    transport = ChildTaskTransport.new(Socket.new(disconnected), replacement)
    callback = lambda do |connection|
      connection.session.update(type: :realtime, instructions: "restored")
      assert_equal("acknowledged", connection.receive.delta)
      connection.flush_pending
    end

    assert_equal("ready", connect(transport, on_reconnected: callback, &:receive).delta)
    assert_equal("session.update", JSON.parse(replacement.writes.fetch(0)).fetch("type"))
    assert_equal(0, transport.active)
  end

  def test_callback_exception_stops_recovery
    transport = Transport.new(Socket.new(disconnected), Socket.new)
    error = disconnected
    callback = -> (_connection) { raise error }
    raised = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      connect(transport, on_reconnected: callback, &:receive)
    end

    assert_same(error, raised)
    assert_equal(2, transport.requests.length)
  end

  def test_close_inside_callback_stops_pending_receive
    transport = Transport.new(Socket.new(disconnected), Socket.new)
    assert_nil(connect(transport, on_reconnected: -> (connection) { connection.close }, &:receive))
    assert_equal(2, transport.requests.length)
  end

  def test_close_preserves_code_and_reason
    socket = Socket.new
    connect(Transport.new(socket)) { |connection| connection.close(code: 1001, reason: "leaving") }
    assert_equal({code: 1001, reason: "leaving"}, socket.close_args)
    assert_predicate(socket, :closed?)
  end

  def test_application_exception_aborts_without_a_close_frame
    socket = Socket.new
    assert_raises(RuntimeError) { connect(Transport.new(socket)) { raise "application failure" } }
    assert_nil(socket.close_args)
    assert_predicate(socket, :aborted?)
  end

  def test_close_interrupts_a_replacement_handshake
    started = Queue.new
    gate = Queue.new
    transport = Transport.new(
      Socket.new(disconnected),
      -> {
        started << true
        gate.pop
      }
    )
    connect(transport) do |connection|
      receiver = Async::Task.current.async { connection.receive }
      started.pop
      assert_predicate(connection, :reconnecting?)
      connection.close
      assert_nil(receiver.wait)
    end

    assert_equal(2, transport.requests.length)
    assert_equal(0, transport.active)
  end

  def test_queued_sends_wait_for_explicit_flush_and_restore_state_first
    started = Queue.new
    gate = Queue.new
    second = Socket.new(text_delta("new session"))
    transport = Transport.new(
      Socket.new(disconnected),
      -> {
        started << true
        gate.pop
        second
      }
    )
    callback = lambda do |connection|
      connection.session.update(type: :realtime, instructions: "restored")
      connection.flush_pending
    end

    connect(transport, max_queue_bytes: 4096, on_reconnected: callback) do |connection|
      receiver = Async::Task.current.async { connection.receive }
      started.pop
      connection.response.create(instructions: "queued")
      assert_equal(1, connection.pending_messages.length)
      gate << true
      assert_equal("new session", receiver.wait.delta)
      assert_empty(connection.pending_messages)
    end

    events = second.writes.map { JSON.parse(_1) }
    assert_equal(%w[session.update response.create], events.map { _1.fetch("type") })
  end

  def test_queue_is_not_automatically_flushed_without_a_callback
    started = Queue.new
    gate = Queue.new
    second = Socket.new(text_delta("ready"))
    transport = Transport.new(
      Socket.new(disconnected),
      -> {
        started << true
        gate.pop
        second
      }
    )
    connect(transport, max_queue_bytes: 4096) do |connection|
      receiver = Async::Task.current.async { connection.receive }
      started.pop
      connection.response.create
      connection.response.cancel
      gate << true
      receiver.wait
      assert_empty(second.writes)
      connection.session.update(type: :realtime, instructions: "restore before flush")
      assert_equal(2, connection.pending_messages.length)
      connection.flush_pending
      assert_equal(
        %w[session.update response.create response.cancel],
        second.writes.map { JSON.parse(_1).fetch("type") }
      )
    end
  end

  def test_overflow_preserves_accepted_events_and_encoded_bytes
    started = Queue.new
    gate = Queue.new
    transport = Transport.new(
      Socket.new(disconnected),
      -> {
        started << true
        gate.pop
      }
    )
    encoded = "{\"type\":\"response.create\",\"response\":{\"instructions\":\"é\"}}"
    connect(transport, max_queue_bytes: encoded.bytesize) do |connection|
      receiver = Async::Task.current.async { connection.receive }
      started.pop
      input = encoded.dup
      connection.send_raw(input)
      input.replace("mutated")
      assert_raises(OpenAI::Errors::RealtimeQueueFullError) { connection.response.cancel }
      assert_equal([encoded], connection.pending_messages)
      assert_equal([encoded], connection.take_pending_messages)
      assert_empty(connection.pending_messages)
      connection.close
      receiver.wait
    end
  end

  def test_queue_is_disabled_by_default_and_connected_payloads_are_not_limited
    started = Queue.new
    gate = Queue.new
    first = Socket.new(disconnected)
    transport = Transport.new(
      first,
      -> {
        started << true
        gate.pop
      }
    )
    connect(transport) do |connection|
      text = "x" * (2 * 1024 * 1024)
      connection.response.create(instructions: text)
      assert_equal(text, JSON.parse(first.writes.fetch(0)).fetch("response").fetch("instructions"))
      receiver = Async::Task.current.async { connection.receive }
      started.pop
      assert_raises(OpenAI::Errors::RealtimeQueueFullError) { connection.response.cancel }
      connection.close
      receiver.wait
    end
  end

  def test_failed_write_is_uncertain_and_never_replayed
    socket = Socket.new
    socket.write_action = -> (_message) { raise connection_error(Errno::EPIPE.new("private peer detail")) }
    transport = Transport.new(socket)
    error = assert_raises(OpenAI::Errors::RealtimeReconnectError) do
      connect(transport) { |connection| connection.response.create(instructions: "private prompt") }
    end

    assert_includes(error.uncertain_message, "private prompt")
    assert_empty(error.unsent_messages)
    refute_includes(error.full_message, "private prompt")
    refute_includes(error.full_message, "private peer detail")
    assert_equal(1, transport.requests.length)
  end

  def test_concurrent_send_errors_belong_to_their_originating_callers
    ["private second prompt", "private first prompt"].each do |second_prompt|
      writing = Queue.new
      gate = Queue.new
      attempted = []
      socket = Socket.new
      socket.write_action = lambda do |message|
        attempted << message
        writing << true
        gate.pop
        raise connection_error(Errno::EPIPE.new)
      end
      assert_raises(OpenAI::Errors::RealtimeReconnectError) do
        connect(Transport.new(socket)) do |connection|
          send_prompt = lambda do |prompt|
            connection.response.create(instructions: prompt)
          rescue OpenAI::Errors::RealtimeReconnectError => e
            e
          end

          first = Async::Task.current.async { send_prompt.call("private first prompt") }
          writing.pop
          second = Async::Task.current.async { send_prompt.call(second_prompt) }
          gate << true
          first_error = first.wait
          second_error = second.wait
          assert_equal(attempted.first, first_error.uncertain_message)
          assert_empty(first_error.unsent_messages)
          assert_nil(second_error.uncertain_message)
          assert_equal(1, second_error.unsent_messages.length)
          unsent = JSON.parse(second_error.unsent_messages.first)
          assert_equal(second_prompt, unsent.fetch("response").fetch("instructions"))
          refute_includes(second_error.full_message, "private first prompt")
          refute_includes(second_error.inspect, "private first prompt")
        end
      end

      assert_equal(1, attempted.length)
    end
  end

  def test_close_after_write_completion_does_not_report_the_event_as_unsent
    socket = Socket.new
    connect(Transport.new(socket)) do |connection|
      # Force close at the method boundary where delivery identity used to be
      # cleared before the waiting sender was acknowledged.
      trace = TracePoint.new(:return) do |event|
        next unless event.defined_class == OpenAI::Realtime::Recovery && event.method_id == :write_once
        trace.disable
        connection.close
      end

      trace.enable(target_thread: Thread.current) { connection.response.create }
    end

    assert_equal(1, socket.writes.length)
  end

  def test_send_entering_recovery_after_close_keeps_its_own_payload
    writing = Queue.new
    gate = Queue.new
    socket = Socket.new
    socket.write_action = -> (_message) {
      writing << true
      gate.pop
    }
    assert_raises(OpenAI::Errors::RealtimeReconnectError) do
      connect(Transport.new(socket)) do |connection|
        first = Async::Task.current.async do
          connection.response.create(instructions: "first")
        rescue OpenAI::Errors::RealtimeReconnectError => e
          e
        end

        writing.pop
        # The public closed? check has succeeded when Recovery#write is entered.
        trace = TracePoint.new(:call) do |event|
          next unless event.defined_class == OpenAI::Realtime::Recovery && event.method_id == :write
          trace.disable
          connection.close
        end

        second_error = assert_raises(OpenAI::Errors::RealtimeReconnectError) do
          trace.enable(target_thread: Thread.current) { connection.response.create(instructions: "second") }
        end

        assert_nil(second_error.uncertain_message)
        assert_equal(
          "second",
          JSON.parse(second_error.unsent_messages.fetch(0)).fetch("response").fetch("instructions")
        )
        assert_equal("first", JSON.parse(first.wait.uncertain_message).fetch("response").fetch("instructions"))
      end
    end
  end

  def test_callback_send_error_excludes_other_callers_retained_events
    started = Queue.new
    gate = Queue.new
    second = Socket.new
    second.write_action = -> (_message) { raise connection_error(Errno::EPIPE.new) }
    transport = Transport.new(
      Socket.new(disconnected),
      -> {
        started << true
        gate.pop
        second
      }
    )
    callback_error = nil
    callback = lambda do |connection|
      connection.response.create(instructions: "callback")
    rescue OpenAI::Errors::RealtimeReconnectError => e
      callback_error = e
    end

    global_error = assert_raises(OpenAI::Errors::RealtimeReconnectError) do
      connect(transport, max_queue_bytes: 4096, on_reconnected: callback) do |connection|
        receiver = Async::Task.current.async do
          connection.receive
        rescue OpenAI::Errors::RealtimeReconnectError => e
          e
        end

        started.pop
        connection.response.create(instructions: "queued by another caller")
        gate << true
        receiver.wait
      end
    end

    assert_empty(callback_error.unsent_messages)
    assert_equal("callback", JSON.parse(callback_error.uncertain_message).fetch("response").fetch("instructions"))
    assert_equal(
      "queued by another caller",
      JSON.parse(global_error.unsent_messages.fetch(0)).fetch("response").fetch("instructions")
    )
  end

  def test_failed_flush_separates_uncertain_and_never_attempted_events
    started = Queue.new
    gate = Queue.new
    second = Socket.new(text_delta("ready"))
    second.write_action = -> (_message) { raise connection_error(Errno::EPIPE.new) }
    transport = Transport.new(
      Socket.new(disconnected),
      -> {
        started << true
        gate.pop
        second
      }
    )
    connection = nil
    error = assert_raises(OpenAI::Errors::RealtimeReconnectError) do
      connect(transport, max_queue_bytes: 4096) do |value|
        connection = value
        receiver = Async::Task.current.async { connection.receive }
        started.pop
        connection.response.create
        connection.response.cancel
        gate << true
        receiver.wait
        connection.flush_pending
      end
    end

    assert_equal("response.create", JSON.parse(error.uncertain_message).fetch("type"))
    assert_equal(["response.cancel"], error.unsent_messages.map { JSON.parse(_1).fetch("type") })
    assert_equal(error.unsent_messages, connection.pending_messages)
    assert_equal(2, transport.requests.length)
  end

  def test_peer_close_cancels_a_blocked_flush_and_reports_uncertainty
    [nil, disconnected].each do |close_event|
      started = Queue.new
      handshake_gate = Queue.new
      peer_close = Queue.new
      writing = Queue.new
      write_gate = Queue.new
      second = Socket.new(
        text_delta("ready"),
        -> {
          peer_close.pop
        }
      )
      second.write_action = -> (_message) {
        writing << true
        write_gate.pop
      }
      transport = Transport.new(
        Socket.new(disconnected),
        -> {
          started << true
          handshake_gate.pop
          second
        }
      )
      error = assert_raises(OpenAI::Errors::RealtimeReconnectError) do
        connect(transport, max_queue_bytes: 4096) do |connection|
          receiver = Async::Task.current.async { connection.receive }
          started.pop
          connection.response.create
          connection.response.cancel
          handshake_gate << true
          receiver.wait
          receiver = Async::Task.current.async do
            connection.receive
          rescue OpenAI::Errors::RealtimeReconnectError => e
            e
          end

          flusher = Async::Task.current.async do
            connection.flush_pending
          rescue OpenAI::Errors::RealtimeReconnectError => e
            e
          end

          writing.pop
          peer_close << close_event
          failure = flusher.wait
          assert_same(failure, receiver.wait)
          assert_equal("response.create", JSON.parse(failure.uncertain_message).fetch("type"))
          assert_equal(["response.cancel"], failure.unsent_messages.map { JSON.parse(_1).fetch("type") })
          assert_equal(failure.unsent_messages, connection.pending_messages)
        end
      end

      assert_nil(error.cause)
      assert_predicate(second, :aborted?)
      assert_equal(0, transport.active)
      assert_equal(2, transport.requests.length)
    end
  end

  def test_options_are_validated_before_opening
    [
      {reconnect: nil},
      {reconnect: "yes"},
      {max_reconnect_attempts: -1},
      {max_queue_bytes: -1},
      {max_queue_bytes: 1.0},
      {on_reconnected: true}
    ].each do |options|
      transport = Transport.new
      assert_raises(ArgumentError) { connect(transport, **options) { |_connection| nil } }
      assert_empty(transport.requests)
    end
  end

  def test_thread_sends_are_dispatched_on_the_socket_owner_while_reading
    started = Queue.new
    gate = Queue.new
    owner = Thread.current
    socket = Socket.new(
      -> {
        started << true
        gate.pop
        text_delta("received")
      }
    )
    socket.write_action = -> (_message) { assert_same(owner, Thread.current) }
    transport = Transport.new(socket)
    connect(transport) do |connection|
      receiver = Async::Task.current.async { connection.receive }
      started.pop
      sender = Thread.new { connection.response.create }
      sender.value
      gate << true
      assert_equal("received", receiver.wait.delta)
    ensure
      connection.close
      sender&.join
    end

    assert_equal(1, socket.writes.length)
  end

  def test_close_during_a_write_reports_uncertainty
    started = Queue.new
    gate = Queue.new
    socket = Socket.new
    socket.write_action = -> (_message) {
      started << true
      gate.pop
    }
    transport = Transport.new(socket)
    error = assert_raises(OpenAI::Errors::RealtimeReconnectError) do
      connect(transport) do |connection|
        sender = Async::Task.current.async do
          connection.response.create
        rescue OpenAI::Errors::RealtimeReconnectError => e
          e
        end

        started.pop
        connection.close
        assert_includes(sender.wait.uncertain_message, "response.create")
      end
    end

    assert_includes(error.uncertain_message, "response.create")
    assert_equal(1, transport.requests.length)
  end

  def test_cancelled_receive_closes_its_socket
    started = Queue.new
    gate = Queue.new
    socket = Socket.new(
      -> {
        started << true
        gate.pop
      }
    )
    connect(Transport.new(socket)) do |connection|
      receiver = Async::Task.current.async { connection.receive }
      started.pop
      receiver.stop
      assert_predicate(connection, :closed?)
    end

    assert_predicate(socket, :aborted?)
  end

  def test_application_load_error_is_not_reported_as_a_missing_async_dependency
    error = LoadError.new("application dependency")
    raised = assert_raises(LoadError) do
      connect(Transport.new(Socket.new)) { |_connection| raise error }
    end

    assert_same(error, raised)
  end

  def test_invalid_server_json_is_not_retried
    transport = Transport.new(Socket.new("not json"))
    assert_raises(OpenAI::Errors::RealtimeProtocolError) { connect(transport, &:receive) }
    assert_equal(1, transport.requests.length)
  end

  def test_async_handshake_timeout_is_recoverable
    transport = Transport.new(connection_error(Async::TimeoutError.new), Socket.new(text_delta("ready")))
    assert_equal("ready", connect(transport, &:receive).delta)
    assert_equal(2, transport.requests.length)
  end

  def test_queue_budget_includes_a_write_in_progress
    started = Queue.new
    handshake_gate = Queue.new
    writing = Queue.new
    write_gate = Queue.new
    second = Socket.new(text_delta("ready"))
    second.write_action = -> (_message) {
      writing << true
      write_gate.pop
    }
    transport = Transport.new(
      Socket.new(disconnected),
      -> {
        started << true
        handshake_gate.pop
        second
      }
    )
    encoded = "{\"type\":\"response.cancel\"}"
    connect(transport, max_queue_bytes: encoded.bytesize) do |connection|
      receiver = Async::Task.current.async { connection.receive }
      started.pop
      connection.send_raw(encoded)
      handshake_gate << true
      receiver.wait
      flusher = Async::Task.current.async { connection.flush_pending }
      writing.pop
      assert_raises(OpenAI::Errors::RealtimeQueueFullError) { connection.response.cancel }
      assert_raises(OpenAI::Errors::RealtimeReconnectError) { connection.take_pending_messages }
      assert_equal([encoded], connection.pending_messages)
      write_gate << true
      flusher.wait
      assert_empty(connection.pending_messages)
    end
  end

  def test_failed_recovery_returns_retained_events_without_logging_them
    started = Queue.new
    gate = Queue.new
    transport = Transport.new(
      Socket.new(disconnected),
      -> {
        started << true
        gate.pop
        raise connection_error(Errno::ECONNREFUSED.new)
      }
    )
    error = assert_raises(OpenAI::Errors::RealtimeReconnectError) do
      connect(transport, max_queue_bytes: 4096, max_reconnect_attempts: 1) do |connection|
        receiver = Async::Task.current.async do
          connection.receive
        rescue OpenAI::Errors::RealtimeReconnectError => e
          e
        end

        started.pop
        connection.response.create(instructions: "private retained prompt")
        gate << true
        failure = receiver.wait
        assert_equal(1, failure.unsent_messages.length)
        assert_nil(failure.uncertain_message)
        refute_includes(failure.full_message, "private retained prompt")
      end
    end

    assert_includes(error.unsent_messages.first, "private retained prompt")
  end

  private def connect(transport, **options, &block)
    client.realtime.connect(model: "test-model", transport: transport, reconnect: true, **options, &block)
  end

  private def connection_error(cause)
    OpenAI::Errors::RealtimeConnectionError.new(url: URI("wss://example.com/v1/realtime"), cause: cause)
  end

  private def disconnected(code = 1011)
    connection_error(Protocol::WebSocket::ClosedError.new("service restart", code))
  end
end
