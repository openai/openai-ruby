# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../responses_websocket/connection_test_support"
require "async/http/endpoint"
require "async/http/server"
require "async/websocket/adapters/http"
require "async/websocket/server"
require "io/endpoint/bound_endpoint"

class OpenAI::Test::LiveWebSocketReaderTest < Minitest::Test
  extend Minitest::Serial
  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  %i[primary sideband fork].each do |role|
    define_method("test_#{role}_one_pending_receive_rejects_other_readers_without_losing_events") do
      with_live_peer(role) do |task, connection, entered, release, received|
        # An idle enumerator does not own reads or prevent the caller's startup.
        enum = connection.each
        assert_instance_of(Enumerator, enum)

        first = task.async { connection.receive }
        assert_equal(true, entered.pop(timeout: 1), "first read must enter the actual SDK socket")
        assert(first.alive?)
        assert_reader_rejected(task) { connection.receive }
        assert_reader_rejected(task) { connection.receive_raw }
        assert_reader_rejected(task) { enum.each { flunk("The competing reader received an event") } }
        assert(first.alive?, "rejected readers must not stop the pending receiver")
        refute(connection.closed?)

        release << :first
        assert_equal(:first, task.with_timeout(1) { first.wait }.data.fetch(:marker).to_sym)
        release << :second
        assert_equal("second", JSON.parse(connection.receive_raw).fetch("marker"))
        refute(connection.closed?)
        connection.close
        connection.close
        assert_predicate(connection, :closed?)
        assert_equal(role == :sideband ? [] : ["session.start"], received)
      end
    end

    define_method("test_#{role}_iteration_excludes_other_reads_until_it_yields_and_releases_after_break") do
      with_live_peer(role) do |task, connection, entered, release, received|
        yielded = Queue.new
        finish = Queue.new
        iterator = task.async do
          connection.each do |event|
            yielded << event
            finish.pop(timeout: 2)
            break :early if event.data.fetch(:marker) == "first"
          end
        end

        assert_equal(true, entered.pop(timeout: 1))
        assert_reader_rejected(task) { connection.receive }
        assert_reader_rejected(task) { connection.receive_raw }
        assert_reader_rejected(task) { connection.each { flunk("Competing read yielded") } }
        release << :first
        assert_equal(:first, yielded.pop(timeout: 1).data.fetch(:marker).to_sym)
        assert(iterator.alive?)

        # The callback has its event and is not reading. A caller may hand
        # ownership to a direct receive, but a second physical read must fail.
        second = task.async { connection.receive }
        assert_equal(true, entered.pop(timeout: 1))
        assert_reader_rejected(task) { connection.each { flunk("Competing read yielded") } }
        release << :second
        assert_equal(:second, task.with_timeout(1) { second.wait }.data.fetch(:marker).to_sym)
        finish << :done
        assert_equal(:early, task.with_timeout(1) { iterator.wait })
        refute(connection.closed?)
        assert_equal(role == :sideband ? [] : ["session.start"], received)
      end
    end

    define_method("test_#{role}_external_rewind_restarts_against_remaining_socket_events") do
      with_live_peer(role) do |_task, connection, entered, release, _received|
        events = connection.each
        assert_instance_of(Enumerator, events)
        assert_same(events, events.rewind)
        release << :first
        assert_equal(:first, events.next.data.fetch(:marker).to_sym)
        assert_equal(true, entered.pop(timeout: 1))
        assert_same(events, events.rewind)
        release << :second
        assert_equal(:second, events.next.data.fetch(:marker).to_sym)
        assert_equal(true, entered.pop(timeout: 1))
        assert_same(events, events.rewind)
        refute_predicate(connection, :closed?)
      end
    end

    define_method("test_#{role}_stale_rewind_does_not_release_a_later_physical_reader") do
      with_live_peer(role) do |task, connection, entered, release, _received|
        events = connection.each
        release << :first
        assert_equal(:first, events.next.data.fetch(:marker).to_sym)
        assert_equal(true, entered.pop(timeout: 1))
        assert_same(events, events.rewind)
        next_read = task.async { connection.receive }
        assert_equal(true, entered.pop(timeout: 1))
        assert(next_read.alive?)
        assert_same(events, events.rewind)
        assert_reader_rejected(task) { connection.receive_raw }
        assert_reader_rejected(task) { events.each { flunk("Competing read yielded") } }
        release << :second
        assert_equal(:second, task.with_timeout(1) { next_read.wait }.data.fetch(:marker).to_sym)
        refute_predicate(connection, :closed?)
      end
    end

    define_method("test_#{role}_abandoned_enumerator_does_not_retain_physical_read_ownership") do
      with_live_peer(role) do |_task, connection, entered, release, _received|
        release << :first
        assert_equal(:first, connection.each.next.data.fetch(:marker).to_sym)
        assert_equal(true, entered.pop(timeout: 1))
        release << :second
        assert_equal(:second, connection.receive.data.fetch(:marker).to_sym)
        assert_equal(true, entered.pop(timeout: 1))
        refute_predicate(connection, :closed?)
      end
    end
  end

  def test_read_lease_releases_on_callback_and_decode_errors_without_changing_the_original_failure
    expected = RuntimeError.new("synthetic application exception")
    socket = FakeSocket.new(
      JSON.generate(type: "session.future", marker: "before_error"),
      "invalid private-synthetic-event",
      JSON.generate(type: "session.future", marker: "after_error")
    )
    client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      actual = assert_raises(RuntimeError) do
        connection.each { |event| raise expected if event.type == :"session.future" }
      end

      assert_same(expected, actual)
      refute_predicate(connection, :closed?)
      protocol_error = assert_raises(OpenAI::Errors::LiveProtocolError) { connection.receive }
      assert_nil(protocol_error.cause)
      refute_includes(protocol_error.full_message, "private-synthetic-event")
      refute_predicate(connection, :closed?)
      assert_equal(:after_error, connection.receive.data.fetch(:marker).to_sym)
    end

    refute_predicate(socket, :aborted?)
    assert_predicate(socket, :closed?)
  end

  def test_read_lease_releases_on_cancel_and_does_not_hide_a_later_transport_failure
    Sync do |task|
      entered = Queue.new
      socket = FakeSocket.new
      socket.define_singleton_method(:read) do
        entered << true
        Queue.new.pop
      end

      client.live.connect(transport: FakeTransport.new(socket)) do |connection|
        reader = task.async { connection.receive }
        assert_equal(true, entered.pop(timeout: 1))
        assert_reader_rejected(task) { connection.receive_raw }
        reader.stop
        socket.define_singleton_method(:read) { raise IOError, "private-synthetic-transport" }
        error = assert_raises(OpenAI::Errors::LiveConnectionError) { connection.receive }
        assert_equal("Live WebSocket connection error.", error.message)
        assert_nil(error.cause)
        refute_includes(error.full_message, "private-synthetic-transport")
        assert_predicate(connection, :closed?)
        # An actual transport failure still prevents sending and retires the socket.
        assert_raises(OpenAI::Errors::LiveConnectionError) do
          connection.send_event(type: "session.start", session: {model: "gpt-live-1", store: false})
        end
      end

      assert_predicate(socket, :aborted?)
    end
  end

  private def assert_reader_rejected(task)
    error = assert_raises(OpenAI::Errors::LiveConnectionError) do
      task.with_timeout(0.5) { yield }
    end

    assert_equal("Live WebSocket already has an active reader.", error.message)
    assert_nil(error.cause)
  end

  private def with_live_peer(role)
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:0")
    bound = endpoint.bound
    port = bound.sockets.first.local_address.ip_port
    release = Queue.new
    entered = Queue.new
    received = []
    upgrades = 0
    peer_closed = Queue.new
    server = Async::HTTP::Server.new(
      Async::WebSocket::Server.new(-> (_) { Protocol::HTTP::Response[404, {}, []] }) do |socket|
        upgrades += 1
        unless role == :sideband
          received << JSON.parse(socket.read.to_str).fetch("type")
          socket.write(
            JSON.generate(
              type: "session.started",
              event_id: "start_1",
              session: {id: "sess_test", model: "gpt-live-1", expires_at: 2_000_000_000, status: "active"}
            )
          )
          socket.flush
        end

        %w[first second].each do |marker|
          release.pop(timeout: 2)
          socket.write(JSON.generate(type: "session.future", marker: marker))
          socket.flush
        end

        socket.read
        peer_closed << true
      end,
      bound,
      protocol: endpoint.protocol,
      scheme: endpoint.scheme
    )
    Sync do |task|
      server_task = task.async { server.run.wait }
      api = OpenAI::Client.new(api_key: "sk-test-local", base_url: "http://127.0.0.1:#{port}/v1", timeout: 4)
      task.with_timeout(5) do
        open_connection = lambda do |connection|
          # Blockless each is allowed even before startup; it must acquire only
          # when it begins iterating.
          assert_instance_of(Enumerator, connection.each)
          unless role == :sideband
            start = role == :primary ? {model: "gpt-live-1", store: false} : {store: false}
            connection.send_event(type: "session.start", session: start)
            assert_instance_of(OpenAI::Live::SessionStartedEvent, connection.receive)
          end
          # Observe this real SDK socket after startup. Delegate its actual read
          # unchanged; do not serialize it or replace its values/errors.
          socket = connection.instance_variable_get(:@socket)
          native_read = socket.method(:read)
          socket.define_singleton_method(:read) do
            entered << true
            native_read.call
          end

          yield task, connection, entered, release, received
        end

        case role
        when :primary
          api.live.connect(&open_connection)
        when :sideband
          api.live.sideband.connect("sess_test", &open_connection)
        when :fork
          api.live.forks.connect("sess_test", &open_connection)
        end
      end

      assert_equal(true, peer_closed.pop(timeout: 1))
      assert_equal(1, upgrades, "rejecting a reader must not reconnect or replay")
    ensure
      server_task&.stop
      bound.close
    end
  end
end
