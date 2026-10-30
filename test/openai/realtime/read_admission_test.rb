# frozen_string_literal: true

require_relative "../test_helper"
require "async/http/endpoint"
require "async/http/server"
require "async/websocket/server"
require "async/websocket/adapters/http"
require "io/endpoint/bound_endpoint"

class OpenAI::Test::RealtimeReadAdmissionTest < Minitest::Test
  extend Minitest::Serial

  def test_realtime_rejects_overlapping_physical_reads_without_losing_the_active_event
    %i[typed raw iteration].each do |contender|
      with_peer do |task, client, trigger, entered, counts|
        client.realtime.connect(model: "gpt-realtime-2.1") do |connection|
          assert_read_admission(
            task,
            connection,
            trigger,
            entered,
            counts,
            contender,
            OpenAI::Errors::RealtimeConnectionError
          )
        end
      end
    end
  end

  def test_translation_rejects_overlapping_physical_reads_without_losing_the_active_event
    %i[typed raw iteration].each do |contender|
      with_peer do |task, client, trigger, entered, counts|
        client.realtime.connect_translation(model: "gpt-realtime-translate") do |connection|
          assert_read_admission(
            task,
            connection,
            trigger,
            entered,
            counts,
            contender,
            OpenAI::Errors::TranslationConnectionError
          )
        end
      end
    end
  end

  def test_recovery_keeps_two_queued_waiters_behind_its_one_physical_reader
    with_peer do |task, client, trigger, entered, counts|
      client.realtime.connect(model: "gpt-realtime-2.1", reconnect: true) do |connection|
        physical = connection.instance_variable_get(:@recovery).instance_variable_get(:@physical)
        observe_reads(physical, entered, counts)
        first = task.async { connection.receive }
        assert_equal(true, entered.pop(timeout: 1))
        assert(first.alive?)
        second = task.async { connection.receive_raw }
        assert(second.alive?, "recovery still accepts another queued waiter")
        trigger << :first
        assert_equal("first", task.with_timeout(2) { first.wait }.data[:marker])
        assert_equal(true, entered.pop(timeout: 1))
        trigger << :second
        assert_equal("second", JSON.parse(task.with_timeout(2) { second.wait }).fetch("marker"))
        assert_equal([1, 1], counts)
        refute_predicate(connection, :closed?)
      end
    end
  end

  private def assert_read_admission(task, connection, trigger, entered, counts, contender, error_class)
    observe_reads(connection, entered, counts)
    first = task.async do
      connection.receive
    rescue StandardError => error
      error
    end

    assert_equal(true, entered.pop(timeout: 1), "first receive entered the native socket")
    assert(first.alive?, "the first receive must still be pending")
    second = task.async do
      case contender
      when :typed
        connection.receive
      when :raw
        connection.receive_raw
      when :iteration
        connection.each.next
      end

    rescue StandardError => error
      error
    end

    trigger << :first
    admitted = task.with_timeout(2) { first.wait }
    assert_respond_to(admitted, :data, "first reader keeps its event")
    assert_equal("first", admitted.data[:marker])
    rejected = task.with_timeout(2) { second.wait }
    assert_instance_of(error_class, rejected)
    assert_equal([1], counts, "rejection happens before a second physical read")
    refute_predicate(connection, :closed?)
    # A rejected read must not release another read's lease or poison the socket.
    last = task.async { connection.receive_raw }
    assert_equal(true, entered.pop(timeout: 1))
    trigger << :second
    assert_equal("second", JSON.parse(task.with_timeout(2) { last.wait }).fetch("marker"))
    assert_equal([1, 1], counts)
    refute_predicate(connection, :closed?)
  end

  private def observe_reads(connection, entered, counts)
    socket = connection.instance_variable_get(:@socket)
    native_read = socket.method(:read)
    active = 0
    socket.define_singleton_method(:read) do
      active += 1
      counts << active
      entered << true
      native_read.call
    ensure
      active -= 1
    end
  end

  private def with_peer
    trigger = Queue.new
    entered = Queue.new
    counts = []
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:0")
    bound = endpoint.bound
    port = bound.sockets.first.local_address.ip_port
    websocket = Async::WebSocket::Server.new(-> (_) { Protocol::HTTP::Response[404, {}, []] }) do |socket|
      %w[first second].each do |marker|
        trigger.pop(timeout: 2)
        socket.write(JSON.generate(type: "future.server.event", marker: marker))
        socket.flush
      end

      socket.read
    rescue StandardError
      # A failing client can close while the local peer is writing its second event.
      nil
    end

    server = Async::HTTP::Server.new(websocket, bound, protocol: endpoint.protocol, scheme: endpoint.scheme)
    Sync do |task|
      server_task = task.async { server.run.wait }
      client = OpenAI::Client.new(api_key: "sk-test-local", base_url: "http://127.0.0.1:#{port}/v1", timeout: 4)
      task.with_timeout(5) { yield(task, client, trigger, entered, counts) }
    ensure
      trigger << :stop
      trigger << :stop
      server_task&.stop
      bound.close
    end
  end
end
