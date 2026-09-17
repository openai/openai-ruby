# frozen_string_literal: true

require "async/http/server"
require "async/websocket/adapters/http"
require "async/queue"
require "io/endpoint/bound_endpoint"

require_relative "../test_helper"

class OpenAI::Test::ResponsesWebSocketSessionTest < Minitest::Test
  extend Minitest::Serial

  class UncertainWriteTransport
    class Socket
      def initialize(socket)
        @socket = socket
      end

      def read = @socket.read
      def closed? = @socket.closed?
      def close(**options) = @socket.close(**options)
      def abort = @socket.abort

      def write(data)
        @socket.write(data)
        raise IOError, "Synthetic failure after an accepted write."
      end
    end

    def open(**options)
      OpenAI::Responses::Transports::AsyncWebSocket.new.open(**options) do |socket|
        yield(Socket.new(socket))
      end
    end
  end

  def test_interleaved_lanes_continuation_and_raw_unknown_events
    handler = lambda do |socket, _request|
      first, second = [read(socket), read(socket)]
      assert_equal(%w[left right], [first["stream_id"], second["stream_id"]])
      assert_equal("resp_prior", second["previous_response_id"])
      write(socket, type: "response.future", stream_id: "right", nested: {value: 7})
      terminal(socket, "left")
      write(socket, type: "response.future", marker: "default")
      assert_equal("response.create", read(socket)["type"])
      terminal(socket, "right")
      terminal(socket, nil)
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        left = session.lane("left")
        right = session.lane("right")
        left.send_event(type: "response.create", input: "synthetic")
        right.send_event(type: "response.create", previous_response_id: "resp_prior")
        assert_equal({value: 7}, right.receive.to_h[:nested])
        assert_equal("resp_left", left.get_final_response.id)
        left.close
        left.close
        assert_equal("default", session.default.receive.to_h[:marker])
        session.default.send_event(type: "response.create")
        assert_equal("resp_right", right.get_final_response.id)
        assert_equal("resp_default", session.default.get_final_response.id)
      end
    end
  end

  def test_named_lane_steering_and_automatic_successor
    command = {type: "response.steer", previous_response_id: "resp_parent", input: "Change course"}
    handler = lambda do |socket, _request|
      assert_equal(command.transform_keys(&:to_s), read(socket))
      terminal(socket, "steering", status: "incomplete", id: "resp_parent")
      write(
        socket,
        type: "response.created",
        sequence_number: 2,
        stream_id: "steering",
        response: {id: "resp_successor", status: "in_progress", output: []}
      )
      terminal(socket, "steering", id: "resp_successor")
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        lane = session.lane("steering")
        lane.send_event(command)
        assert_equal("resp_parent", lane.get_final_response.id)
        assert_equal("response.created", lane.receive.type.to_s)
        error = assert_raises(OpenAI::Responses::SessionError) do
          lane.send_event(type: "response.create", input: "Too early")
        end

        assert_match(/Consume the current response/, error.message)
        assert_equal("resp_successor", lane.get_final_response.id)
        refute(command.key?(:stream_id))
      end
    end
  end

  def test_cached_final_response_remains_owned_by_the_session_thread
    handler = lambda do |socket, _request|
      read(socket)
      terminal(socket, nil)
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        lane = session.default
        lane.send_event(type: "response.create")
        assert_equal("response.completed", lane.receive.type.to_s)
        result = Thread
          .new do
            lane.get_final_response
          rescue OpenAI::Responses::SessionError => error
            error
          end
          .value

        assert_instance_of(OpenAI::Responses::SessionError, result)
        assert_match(/single-thread owned/, result.message)
        assert_equal("resp_default", lane.get_final_response.id)
      end
    end
  end

  def test_get_final_response_consumes_queued_automatic_successor
    handler = lambda do |socket, _request|
      read(socket)
      terminal(socket, "steering", status: "incomplete", id: "resp_parent")
      write(
        socket,
        type: "response.created",
        stream_id: "steering",
        response: {id: "resp_successor", status: "in_progress", output: []}
      )
      terminal(socket, "steering", id: "resp_successor")
      write(socket, type: "response.future", marker: "successor queued")
      assert_equal("response.create", read(socket)["type"])
      terminal(socket, "steering", id: "resp_next")
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        lane = session.lane("steering")
        lane.send_event(type: "response.steer", previous_response_id: "resp_parent", input: "Change course")
        assert_equal("successor queued", session.default.receive.to_h[:marker])
        assert_equal("resp_parent", lane.get_final_response.id)
        assert_raises(OpenAI::Responses::SessionError) { lane.send_event(type: "response.create") }
        assert_equal("resp_successor", lane.get_final_response.id)
        lane.send_event(type: "response.create")
        assert_equal("resp_next", lane.get_final_response.id)
      end
    end
  end

  def test_get_final_response_waits_for_delayed_automatic_successor
    release = Async::Queue.new
    handler = lambda do |socket, _request|
      read(socket)
      terminal(socket, nil, id: "resp_parent")
      release.dequeue
      write(
        socket,
        type: "response.created",
        response: {id: "resp_successor", status: "in_progress", output: []}
      )
      terminal(socket, nil, id: "resp_successor")
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        lane = session.default
        lane.send_event(type: "response.steer", previous_response_id: "resp_parent", input: "Change course")
        parent = lane.get_final_response
        assert_equal("resp_parent", parent.id)
        parent.id.replace("caller_mutation")
        assert_raises(OpenAI::Responses::SessionError) do
          lane.send_event(type: "response.create", input: "Must not overlap the successor")
        end

        waiter = Async::Task.current.async { lane.get_final_response }
        refute_predicate(waiter, :finished?)
        release.enqueue(true)
        assert_equal("resp_successor", waiter.wait.id)
      end
    end
  end

  def test_typed_create_preserves_discriminator_and_lane_state
    handler = lambda do |socket, _request|
      [nil, "typed"].each do |stream_id|
        command = read(socket)
        assert_equal("response.create", command["type"])
        if stream_id
          assert_equal(stream_id, command["stream_id"])
        else
          assert_nil(command["stream_id"])
        end

        assert_equal("example-model", command["model"])
        terminal(socket, stream_id)
      end
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        [session.default, session.lane("typed")].each do |lane|
          command = OpenAI::Responses::ResponsesClientEvent::ResponseCreate.new(model: "example-model")
          lane.send_event(command)
          assert_raises(OpenAI::Responses::SessionError) { lane.send_event(command) }
          assert_equal("resp_#{lane.stream_id || "default"}", lane.get_final_response.id)
          refute(command.to_h.key?(:stream_id))
        end
      end
    end
  end

  def test_steering_outcomes_release_admission_after_all_submissions_are_resolved
    %w[response.steer.failed response.steer.pending].each do |outcome|
      release = Async::Queue.new
      handler = lambda do |socket, _request|
        assert_equal("response.create", read(socket)["type"])
        write(
          socket,
          type: "response.created",
          stream_id: "steering",
          response: {id: "resp_parent", status: "in_progress", output: []}
        )
        2.times { assert_equal("response.steer", read(socket)["type"]) }
        terminal(socket, "steering", id: "resp_parent")
        2.times do |index|
          release.dequeue
          details = if outcome == "response.steer.pending"
            {reason: "waiting_for_required_input", required_input: []}
          else
            {error: {type: "invalid_request_error", code: "steering_not_supported", message: "Synthetic"}}
          end

          write(
            socket,
            type: outcome,
            stream_id: "steering",
            sequence_number: index + 2,
            steer: {id: "steer_#{index}", previous_response_id: "resp_parent", input: "Change course"},
            **details
          )
          if outcome == "response.steer.pending" && index.zero?
            write(
              socket,
              type: "response.steer.failed",
              stream_id: "steering",
              sequence_number: 3,
              steer: {id: "steer_0", previous_response_id: "resp_parent", input: "Change course"},
              error: {type: "invalid_request_error", code: "successor_creation_failed", message: "Synthetic"}
            )
          end
        end

        assert_equal("resp_parent", read(socket)["previous_response_id"])
        terminal(socket, "steering", id: "resp_next")
      end

      with_server(handler) do |client|
        OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
          lane = session.lane("steering")
          lane.send_event(type: "response.create")
          [lane, session.default].each do |sender|
            sender.send_event(type: "response.steer", previous_response_id: "resp_parent", input: "Change course")
          end

          assert_equal("resp_parent", lane.get_final_response.id)
          2.times do |index|
            assert_raises(OpenAI::Responses::SessionError) { lane.send_event(type: "response.create") }
            release.enqueue(true)
            assert_equal(outcome, lane.receive.type.to_s)
            if outcome == "response.steer.pending" && index.zero?
              assert_equal("response.steer.failed", lane.receive.type.to_s)
            end

            if index.zero?
              # The other submission is unresolved; completed IDs must not accumulate behind it.
              assert_empty(session.instance_variable_get(:@pending_steers).fetch("resp_parent").fetch(:outcomes))
            end
          end

          lane.send_event(type: "response.create", previous_response_id: "resp_parent", input: [])
          assert_equal("resp_next", lane.get_final_response.id)
        end
      end
    end
  end

  def test_pending_failure_after_later_submission
    handler = lambda do |socket, _request|
      assert_equal("response.create", read(socket)["type"])
      write(socket, type: "response.created", response: {id: "resp_parent", status: "in_progress", output: []})
      assert_equal("response.steer", read(socket)["type"])
      terminal(socket, nil, id: "resp_parent")
      write(
        socket,
        type: "response.steer.pending",
        sequence_number: 2,
        steer: {id: "steer_a", previous_response_id: "resp_parent"},
        reason: "waiting_for_required_input",
        required_input: []
      )
      assert_equal("response.steer", read(socket)["type"])
      write(
        socket,
        type: "response.steer.failed",
        sequence_number: 3,
        steer: {id: "steer_a", previous_response_id: "resp_parent", input: "first"},
        error: {type: "invalid_request_error", code: "successor_creation_failed", message: "Synthetic"}
      )
      socket.read
    end

    with_server(handler, wait_for_close: false) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        lane = session.default
        lane.send_event(type: "response.create")
        assert_equal("response.created", lane.receive.type.to_s)
        lane.send_event(type: "response.steer", previous_response_id: "resp_parent", input: "first")
        assert_equal("resp_parent", lane.get_final_response.id)
        assert_equal("response.steer.pending", lane.receive.type.to_s)
        lane.send_event(type: "response.steer", previous_response_id: "resp_parent", input: "second")
        assert_equal("response.steer.failed", lane.receive.type.to_s)
        assert_raises(OpenAI::Responses::SessionError) do
          lane.send_event(type: "response.create", previous_response_id: "resp_parent", input: [])
        end
      end
    end
  end

  def test_detached_lane_events_remain_visible_without_changing_default_response
    release = Async::Queue.new
    handler = lambda do |socket, _request|
      2.times { read(socket) }
      release.dequeue
      write(
        socket,
        type: "response.created",
        sequence_number: 0,
        response: {id: "resp_default", status: "in_progress", output: []}
      )
      write(
        socket,
        type: "response.created",
        sequence_number: 1,
        stream_id: "detached",
        response: {id: "resp_detached", status: "in_progress", output: []}
      )
      terminal(socket, "detached")
      terminal(socket, nil)
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        detached = session.lane("detached")
        session.default.send_event(type: "response.create")
        detached.send_event(type: "response.create")
        detached.close
        release.enqueue(true)
        assert_equal("resp_default", session.default.receive.response.id)
        assert_equal("resp_detached", session.default.receive.response.id)
        assert_equal("resp_detached", session.default.receive.response.id)
        assert_raises(OpenAI::Responses::SessionError) { session.default.send_event(type: "response.create") }
        assert_equal("resp_default", session.default.get_final_response.id)
      end
    end
  end

  def test_canceled_wait_does_not_steal_a_later_event
    release = Async::Queue.new
    handler = lambda do |socket, _request|
      release.dequeue
      terminal(socket, "waiting")
      terminal(socket, "other")
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        lane = session.lane("waiting")
        other = session.lane("other")
        waiter = Async::Task.current.async { lane.get_final_response }
        waiter.stop
        release.enqueue(true)
        assert_equal("resp_waiting", lane.get_final_response.id)
        lane.close
        assert_equal("resp_other", other.get_final_response.id)
      end
    end
  end

  def test_detached_lane_ids_remain_reserved_through_terminals_and_automatic_successors
    %w[completed incomplete].each do |status|
      release = Async::Queue.new
      handler = lambda do |socket, _request|
        read(socket)
        release.dequeue
        write(
          socket,
          type: "response.#{status}",
          stream_id: "same",
          response: {id: "resp_prior", status: status, output: [], incomplete_details: {reason: "steered"}}
        )
        release.dequeue
        write(
          socket,
          type: "response.created",
          stream_id: "same",
          response: {id: "resp_successor", status: "in_progress", output: []}
        )
        terminal(socket, "same", id: "resp_successor")
      end

      with_server(handler) do |client|
        OpenAI::Responses::Session.open(client: client, limits: limits(max_lanes: 2)) do |session|
          prior = session.lane("same")
          prior.send_event(type: "response.create")
          prior.close
          assert_raises(ArgumentError) { session.lane("same") }
          release.enqueue(true)
          assert_equal("resp_prior", session.default.receive.response.id)
          assert_raises(ArgumentError) { session.lane("same") }
          release.enqueue(true)
          assert_equal("resp_successor", session.default.receive.response.id)
          assert_equal("resp_successor", session.default.receive.response.id)
          assert_raises(ArgumentError) { session.lane("same") }
          assert_raises(OpenAI::Responses::BufferError) { session.lane("another") }
        end
      end
    end
  end

  def test_closed_default_accessor_cannot_be_replaced_before_reconnect
    with_server(-> (_socket, _request) { nil }) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        prior = session.default
        prior.close
        assert_raises(ArgumentError) { session.lane(nil) }
        assert_same(prior, session.default)
        assert_raises(OpenAI::Responses::SessionError) { session.default.receive }
      end
    end
  end

  def test_headers_and_explicit_recovery_refresh_without_replay
    requests = []
    handler = lambda do |socket, request|
      headers = request.headers
      assert_equal(["retained"], headers["x-client-only"])
      if headers["authorization"] == "Bearer fresh-key"
        assert_equal(["fresh connection"], headers["x-override"])
        assert_equal(["fresh"], headers["x-new-header"])
      else
        assert_equal("Bearer fake-key", headers["authorization"])
        assert_equal(["connection"], headers["x-override"])
      end

      requests << read(socket)
      terminal(socket, nil, id: "resp_#{requests.length}")
    end

    with_server(handler, headers: {"x-override" => "client", "X-Client-Only" => "retained"}) do |client|
      OpenAI::Responses::Session
        .open(
          client: client,
          limits: limits,
          request_options: {extra_headers: {"X-Override" => "connection"}}
        ) do |session|
          old = session.default
          old.send_event(type: "response.create", input: "first")
          assert_equal("resp_1", old.get_final_response.id)
          fresh = OpenAI::Client.new(
            api_key: "fresh-key",
            base_url: client.base_url,
            default_headers: {"X-Client-Only" => "retained", "x-override" => "new client"}
          )
          session.reconnect(
            client: fresh,
            request_options: {extra_headers: {"X-Override" => "fresh connection", "X-New-Header" => "fresh"}},
            restore: -> (current) {
              current.default.send_event(type: "response.create", input: "explicit restoration")
            }
          )
          assert_raises(OpenAI::Responses::StateLostError) { old.receive }
          assert_raises(OpenAI::Responses::StateLostError) { old.send_event(type: "response.create") }
          assert_equal("resp_2", session.default.get_final_response.id)
        end
    end

    assert_equal(["first", "explicit restoration"], requests.map { |request| request["input"] })
  end

  def test_reconnect_releases_detached_lane_ids_without_replaying_pending_work
    requests = []
    handler = lambda do |socket, _request|
      request = read(socket)
      requests << request["input"]
      if request["input"] == "restored"
        terminal(socket, "same", id: "resp_replacement")
      else
        write(socket, type: "response.future", marker: "accepted")
      end
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        prior = session.lane("same")
        prior.send_event(type: "response.create", input: "pending")
        assert_equal("accepted", session.default.receive.to_h[:marker])
        prior.close
        replacement = nil
        session.reconnect(
          restore: -> (current) {
            replacement = current.lane("same")
            replacement.send_event(type: "response.create", input: "restored")
          }
        )
        assert_equal("resp_replacement", replacement.get_final_response.id)
      end
    end

    assert_equal(%w[pending restored], requests)
  end

  def test_terminal_states_and_nested_errors_leave_connection_usable
    handler = lambda do |socket, _request|
      %w[failed incomplete completed].each do |status|
        read(socket)
        terminal(socket, nil, status: status)
      end

      read(socket)
      write(
        socket,
        type: "error",
        status: 400,
        error: {type: "invalid_request_error", code: "bad_input", message: "synthetic private text"}
      )
      read(socket)
      terminal(socket, nil)
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        %w[failed incomplete completed].each do |status|
          session.default.send_event(type: "response.create")
          assert_equal(status, session.default.get_final_response.status.to_s)
        end

        session.default.send_event(type: "response.create")
        error = assert_raises(OpenAI::Responses::RequestError) { session.default.get_final_response }
        assert_equal("bad_input", error.event.error.code)
        refute_includes(error.message, "synthetic private text")
        session.default.send_event(type: "response.create")
        assert_equal("completed", session.default.get_final_response.status.to_s)
      end
    end
  end

  def test_ambiguous_unscoped_error_fails_only_the_default_lane
    [false, true].product([false, true]).each do |created, send_on_neighbor|
      handler = lambda do |socket, _request|
        assert_equal("response.create", read(socket)["type"])
        if created
          write(
            socket,
            type: "response.created",
            response: {id: "resp_parent", status: "in_progress", output: []}
          )
        end

        assert_equal("response.steer", read(socket)["type"])
        write(
          socket,
          type: "error",
          status: 400,
          error: {type: "invalid_request_error", code: "bad_command", message: "Synthetic raw command"}
        )
        terminal(socket, nil, id: "resp_parent")
        assert_equal("neighbor", read(socket)["stream_id"])
        terminal(socket, "neighbor")
      end

      with_server(handler) do |client|
        OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
          lane = session.default
          neighbor = session.lane("neighbor")
          lane.send_event(type: "response.create", input: "first")
          assert_equal("response.created", lane.receive.type.to_s) if created
          sender = send_on_neighbor ? neighbor : lane
          sender.send_event(type: "response.steer", input: "Missing parent")
          event = lane.receive
          assert_equal("error", event.type.to_s)
          error = assert_raises(OpenAI::Responses::RequestError) do
            lane.send_event(type: "response.create", input: "Must not overlap")
          end

          assert_same(event, error.event)
          assert_same(error, assert_raises(OpenAI::Responses::RequestError) { lane.get_final_response })
          assert_same(error, assert_raises(OpenAI::Responses::RequestError) { lane.receive })
          neighbor.send_event(type: "response.create")
          assert_equal("resp_neighbor", neighbor.get_final_response.id)
        end
      end
    end
  end

  def test_failed_default_lane_discards_unclaimed_traffic_before_shared_budgets
    release = Async::Queue.new
    handler = lambda do |socket, _request|
      read(socket)
      read(socket)
      write(
        socket,
        type: "error",
        status: 400,
        error: {type: "invalid_request_error", code: "bad_command", message: "Synthetic raw rejection"}
      )
      release.dequeue
      assert_equal("neighbor", read(socket)["stream_id"])
      write(socket, type: "response.future", payload: "x" * 1024)
      terminal(socket, "neighbor")
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits(max_bytes: 512)) do |session|
        lane = session.default
        neighbor = session.lane("neighbor")
        lane.send_event(type: "response.create")
        lane.send_event(type: "response.steer", input: "Missing parent")
        event = lane.receive
        assert_equal("error", event.type.to_s)
        error = assert_raises(OpenAI::Responses::RequestError) { lane.receive }
        assert_same(event, error.event)
        assert_same(lane, session.default)
        assert_raises(ArgumentError) { session.lane(nil) }
        neighbor.send_event(type: "response.create")
        release.enqueue(true)
        assert_equal("resp_neighbor", neighbor.get_final_response.id)
        assert_same(error, assert_raises(OpenAI::Responses::RequestError) { lane.get_final_response })
      end
    end
  end

  def test_raw_command_before_create_keeps_uncertainty_until_reconnect
    handler = lambda do |socket, _request|
      command = read(socket)
      if command["type"] == "response.steer"
        assert_equal("first", read(socket)["input"])
        write(
          socket,
          type: "error",
          status: 400,
          error: {type: "invalid_request_error", code: "bad_command", message: "Synthetic missing parent"}
        )
      else
        assert_equal("restored", command["input"])
        write(
          socket,
          type: "error",
          status: 400,
          error: {type: "invalid_request_error", code: "bad_input", message: "Synthetic rejected create"}
        )
        assert_equal("corrected", read(socket)["input"])
        terminal(socket, nil, id: "resp_corrected")
      end
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        lane = session.default
        lane.send_event(type: "response.steer", input: "Missing parent")
        lane.send_event(type: "response.create", input: "first")
        event = lane.receive
        assert_equal("error", event.type.to_s)
        error = assert_raises(OpenAI::Responses::RequestError) do
          lane.send_event(type: "response.create", input: "Must not overlap")
        end

        assert_same(event, error.event)
        session.reconnect(
          restore: -> (current) {
            current.default.send_event(type: "response.create", input: "restored")
          }
        )
        fresh = session.default
        error = assert_raises(OpenAI::Responses::RequestError) { fresh.get_final_response }
        assert_equal("bad_input", error.event.error.code)
        fresh.send_event(type: "response.create", input: "corrected")
        assert_equal("resp_corrected", fresh.get_final_response.id)
      end
    end
  end

  def test_queued_rejection_predates_later_raw_command
    handler = lambda do |socket, _request|
      assert_equal("response.create", read(socket)["type"])
      write(
        socket,
        type: "error",
        status: 400,
        error: {type: "invalid_request_error", code: "bad_input", message: "Synthetic rejected create"}
      )
      write(socket, type: "response.future", stream_id: "neighbor", marker: "rejection already queued")
      assert_equal("response.steer", read(socket)["type"])
      write(
        socket,
        type: "response.steer.failed",
        stream_id: "neighbor",
        sequence_number: 1,
        steer: {id: "steer_neighbor", previous_response_id: "resp_neighbor", input: "Synthetic steer"},
        error: {type: "invalid_request_error", code: "steering_not_supported", message: "Synthetic steer rejection"}
      )
      assert_equal("corrected", read(socket)["input"])
      terminal(socket, nil, id: "resp_corrected")
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        lane = session.default
        neighbor = session.lane("neighbor")
        lane.send_event(type: "response.create", input: "bad input")
        assert_equal("rejection already queued", neighbor.receive.to_h[:marker])
        neighbor.send_event(type: "response.steer", previous_response_id: "resp_neighbor", input: "Synthetic steer")
        assert_equal("response.steer.failed", neighbor.receive.type.to_s)
        assert_raises(OpenAI::Responses::RequestError) { lane.get_final_response }
        lane.send_event(type: "response.create", input: "corrected")
        assert_equal("resp_corrected", lane.get_final_response.id)
      end
    end
  end

  def test_raw_command_after_successor_queued_preserves_admission
    handler = lambda do |socket, _request|
      assert_equal("response.steer", read(socket)["type"])
      terminal(socket, nil, id: "resp_parent")
      write(socket, type: "response.created", response: {id: "resp_successor", status: "in_progress", output: []})
      write(socket, type: "response.future", stream_id: "neighbor", marker: "successor already queued")
      assert_equal("response.steer", read(socket)["type"])
      write(
        socket,
        type: "error",
        status: 400,
        error: {type: "invalid_request_error", code: "bad_command", message: "Synthetic malformed raw command"}
      )
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        lane = session.default
        neighbor = session.lane("neighbor")
        lane.send_event(type: "response.steer", previous_response_id: "resp_parent", input: "Make successor")
        assert_equal("successor already queued", neighbor.receive.to_h[:marker])
        assert_equal("resp_parent", lane.get_final_response.id)
        neighbor.send_event(type: "response.steer", input: "Missing parent")
        assert_equal("resp_successor", lane.receive.response.id)
        assert_equal("error", lane.receive.type.to_s)
        assert_raises(OpenAI::Responses::SessionError) do
          lane.send_event(type: "response.create", input: "Must not overlap successor")
        end
      end
    end
  end

  def test_sequenced_response_error_preserves_create_retry_after_raw_command
    handler = lambda do |socket, _request|
      read(socket)
      read(socket)
      write(
        socket,
        type: "error",
        sequence_number: 1,
        error: {type: "server_error", code: "response_failed", message: "Synthetic response failure"}
      )
      assert_equal("corrected", read(socket)["input"])
      terminal(socket, nil, id: "resp_corrected")
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        lane = session.default
        lane.send_event(type: "response.create")
        lane.send_event(type: "response.steer", input: "Missing parent")
        error = assert_raises(OpenAI::Responses::RequestError) { lane.get_final_response }
        assert_equal("response_failed", error.event.error.code)
        lane.send_event(type: "response.create", input: "corrected")
        assert_equal("resp_corrected", lane.get_final_response.id)
      end
    end
  end

  def test_receiving_successor_created_advances_final_response_collection
    release = Async::Queue.new
    handler = lambda do |socket, _request|
      read(socket)
      terminal(socket, "steering", id: "resp_parent")
      write(
        socket,
        type: "response.created",
        stream_id: "steering",
        response: {id: "resp_successor", status: "in_progress", output: []}
      )
      release.dequeue
      terminal(socket, "steering", id: "resp_successor")
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        lane = session.lane("steering")
        lane.send_event(type: "response.steer", previous_response_id: "resp_parent", input: "Change course")
        parent = lane.receive
        assert_equal("resp_parent", parent.response.id)
        assert_equal("resp_successor", lane.receive.response.id)
        waiter = Async::Task.current.async { lane.get_final_response }
        refute_predicate(waiter, :finished?)
        release.enqueue(true)
        assert_equal("resp_successor", waiter.wait.id)
        assert_equal("resp_parent", parent.response.id)
      end
    end
  end

  def test_all_queue_budgets_fail_explicitly
    %i[max_events max_events_per_lane max_bytes max_bytes_per_lane].each do |limit|
      sent = Async::Queue.new
      handler = lambda do |socket, _request|
        write(socket, type: "response.future", data: "x" * 100)
        write(socket, type: "response.future", data: "y" * 100)
        sent.enqueue(true)
      end

      with_server(handler) do |client|
        OpenAI::Responses::Session.open(client: client, limits: limits(**{limit => 1})) do |session|
          sent.dequeue
          Async::Task.current.sleep(0.01)
          assert_raises(OpenAI::Responses::BufferError) { loop { session.default.receive } }
        end
      end
    end
  end

  def test_closed_default_lane_discards_unclaimed_events_before_global_budgets
    [{max_events: 1}, {max_bytes: 128}].each do |budget|
      handler = lambda do |socket, _request|
        read(socket)
        write(socket, type: "response.future", stream_id: "kept", marker: "accepted")
        write(socket, type: "response.future", stream_id: "unclaimed", payload: "x" * 512)
      end

      with_server(handler, wait_for_close: false) do |client|
        OpenAI::Responses::Session.open(client: client, limits: limits(**budget)) do |session|
          session.default.close
          lane = session.lane("kept")
          lane.send_event(type: "response.create")
          # Wait for EOF so the accepted event still occupies the queue while
          # the reader handles the unclaimed event. No timing sleeps are needed.
          session.instance_variable_get(:@reader).wait
          assert_equal("accepted", lane.receive.to_h[:marker])
          error = assert_raises(OpenAI::Responses::SessionError) { lane.receive }
          refute_kind_of(OpenAI::Responses::BufferError, error)
        end
      end
    end
  end

  def test_response_budget_preserves_raw_events_and_other_lanes
    handler = lambda do |socket, _request|
      read(socket)
      terminal(socket, "large")
      read(socket)
      write(socket, type: "response.future", stream_id: "small", value: 9)
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits(max_response_bytes: 1)) do |session|
        large = session.lane("large")
        small = session.lane("small")
        large.send_event(type: "response.create")
        assert_equal("response.completed", large.receive.type.to_s)
        assert_raises(OpenAI::Responses::BufferError) { large.get_final_response }
        large.close
        small.send_event(type: "response.create")
        assert_equal(9, small.receive.to_h[:value])
      end
    end
  end

  def test_finalized_multipart_and_tool_items_fill_omitted_output
    message = {
      id: "msg_1",
      type: "message",
      role: "assistant",
      status: "completed",
      content: [
        {type: "output_text", text: "one", annotations: [], logprobs: []},
        {type: "output_text", text: "two", annotations: [], logprobs: []}
      ]
    }
    tool = {id: "fc_1", type: "function_call", call_id: "call_1", name: "lookup", arguments: "{\"x\":1}"}
    unknown = {type: "future_tool", id: "future_1", metadata: {values: ["original"]}}
    handler = lambda do |socket, _request|
      read(socket)
      write(socket, type: "response.output_item.done", sequence_number: 1, output_index: 0, item: message)
      write(socket, type: "response.output_item.done", sequence_number: 2, output_index: 1, item: tool)
      write(socket, type: "response.output_item.done", sequence_number: 3, output_index: 2, item: unknown)
      write(socket, type: "response.completed", sequence_number: 4, response: {id: "resp_items", status: "completed"})
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        lane = session.default
        lane.send_event(type: "response.create")
        2.times { lane.receive }
        unknown_event = lane.receive
        unknown_event.item[:metadata][:values][0].replace("caller mutation")
        raw = lane.receive
        refute(raw.response.to_h.key?(:output))
        response = lane.get_final_response
        assert_equal(%w[one two], response.output[0].content.map(&:text))
        assert_equal("{\"x\":1}", response.output[1].arguments)
        assert_equal(unknown, response.output[2])
      end
    end
  end

  def test_received_output_item_mutation_does_not_change_final_response
    item = {
      id: "fc_1",
      type: "function_call",
      call_id: "call_1",
      name: "lookup",
      arguments: "{\"x\":1}",
      metadata: {values: ["original"]}
    }
    handler = lambda do |socket, _request|
      read(socket)
      write(socket, type: "response.output_item.done", sequence_number: 1, output_index: 0, item: item)
      write(socket, type: "response.completed", sequence_number: 2, response: {id: "resp_items", status: "completed"})
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits(max_response_bytes: 1024)) do |session|
        lane = session.default
        lane.send_event(type: "response.create")
        raw = lane.receive
        raw.item.arguments.replace("x" * 2048)
        raw.item.to_h[:metadata][:values][0].replace("changed")
        raw.item.to_h[:metadata][:values] << "extra"
        response = lane.get_final_response
        assert_equal("{\"x\":1}", response.output[0].arguments)
        assert_equal(["original"], response.output[0].to_h[:metadata][:values])
        response.output[0].arguments.replace("final mutation")
        assert_equal("x" * 2048, raw.item.arguments)
      end
    end
  end

  def test_received_terminal_mutation_does_not_change_final_response
    %w[completed failed incomplete].each do |status|
      response = {
        id: "resp_terminal",
        status: status,
        output: [
          {
            id: "msg_1",
            type: "message",
            role: "assistant",
            status: "completed",
            content: [{type: "output_text", text: "original text", annotations: [], logprobs: []}]
          }
        ],
        future_details: {values: ["original"]}
      }
      handler = lambda do |socket, _request|
        read(socket)
        write(socket, type: "response.#{status}", sequence_number: 1, response: response)
      end

      with_server(handler) do |client|
        OpenAI::Responses::Session.open(client: client, limits: limits(max_response_bytes: 1024)) do |session|
          lane = session.default
          lane.send_event(type: "response.create")
          raw = lane.receive
          raw.response.id.replace("caller id")
          raw.response.output[0].content[0].text.replace("caller text")
          raw.response.to_h[:future_details][:values][0].replace("caller value")
          raw.response.to_h[:future_details][:values] << "extra"

          final = lane.get_final_response
          assert_equal(
            ["resp_terminal", status, "original text", {values: ["original"]}],
            [final.id, final.status.to_s, final.output[0].content[0].text, final.to_h[:future_details]]
          )
          final.id.replace("final id")
          final.output[0].content[0].text.replace("final text")
          final.to_h[:future_details][:values][0].replace("final value")
          assert_equal("caller id", raw.response.id)
          assert_equal("caller text", raw.response.output[0].content[0].text)
          assert_equal(["caller value", "extra"], raw.response.to_h[:future_details][:values])
        end
      end
    end
  end

  def test_large_payload_uses_caller_budget_without_changing_transport_defaults
    # Keep the existing >32 MiB compatibility probe; this is not an API maximum.
    size = (32 * 1024 * 1024) + 1
    handler = lambda do |socket, _request|
      read(socket)
      write(socket, type: "response.future", payload: "x" * size)
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session
        .open(client: client, limits: limits(max_bytes: size * 2, max_bytes_per_lane: size * 2)) do |session|
          session.default.send_event(type: "response.create")
          assert_equal(size, session.default.receive.to_h[:payload].bytesize)
        end
    end

  ensure
    GC.start
  end

  def test_failed_restoration_closes_new_connection
    handler = -> (socket, _request) { assert_nil(socket.read) }
    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        assert_raises(ArgumentError) do
          session.reconnect(restore: -> (_current) { raise ArgumentError, "synthetic restore failure" })
        end

        assert_raises(OpenAI::Responses::SessionError) { session.lane("closed") }
      end
    end
  end

  def test_early_eof_is_not_a_final_response
    handler = -> (_socket, _request) { nil }
    with_server(handler, wait_for_close: false) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        assert_raises(OpenAI::Responses::SessionError) { session.default.get_final_response }
      end
    end
  end

  def test_uncertain_write_fails_the_session_without_replay
    requests = []
    handler = lambda do |socket, _request|
      requests << read(socket)
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session
        .open(client: client, limits: limits, transport: UncertainWriteTransport.new) do |session|
          assert_raises(OpenAI::Errors::ResponsesSendError) do
            session.default.send_event(type: "response.create", input: "accepted once")
          end

          assert_raises(OpenAI::Errors::ResponsesSendError) { session.default.receive }
        end
    end

    assert_equal(1, requests.length)
  end

  def test_known_unsent_validation_failure_allows_corrected_request
    handler = lambda do |socket, _request|
      assert_equal("corrected", read(socket)["input"])
      terminal(socket, nil)
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        cycle = []
        cycle << cycle
        assert_raises(OpenAI::Errors::ResponsesClientEventError) do
          session.default.send_event(type: "response.create", input: cycle)
        end

        assert_raises(OpenAI::Errors::ResponsesClientEventError) do
          session.default.send_event(type: "response.steer", previous_response_id: "resp_parent", input: cycle)
        end

        session.default.send_event(type: "response.create", input: "corrected")
        assert_equal("completed", session.default.get_final_response.status.to_s)
      end
    end
  end

  def test_invalid_raw_steering_does_not_block_fresh_lanes
    [{}, {previous_response_id: nil}].each do |fields|
      handler = lambda do |socket, _request|
        assert_equal("response.steer", read(socket)["type"])
        write(socket, type: "error", status: 400, error: {type: "invalid_request_error", message: "Missing parent"})
        assert_equal("response.create", read(socket)["type"])
        terminal(socket, "fresh")
      end

      with_server(handler) do |client|
        OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
          session.default.send_event(type: "response.steer", input: "synthetic", **fields)
          assert_equal("error", session.default.receive.type.to_s)
          fresh = session.lane("fresh")
          fresh.send_event(type: "response.create")
          assert_equal("completed", fresh.get_final_response.status.to_s)
        end
      end
    end
  end

  def test_canceled_restoration_closes_the_replacement
    handler = -> (_socket, _request) { nil }
    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        restoring = Async::Queue.new
        blocker = Async::Queue.new
        task = Async::Task.current.async do
          session.reconnect(
            restore: -> (_current) {
              restoring.enqueue(true)
              blocker.dequeue
            }
          )
        end

        restoring.dequeue
        task.stop
        task.wait
        assert_raises(OpenAI::Responses::SessionError) { session.lane("closed") }
      end
    end
  end

  def test_lane_budget_counts_reserved_ids_until_reconnect
    with_server(-> (_socket, _request) { nil }) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits(max_lanes: 2)) do |session|
        lane = session.lane("one")
        assert_raises(OpenAI::Responses::BufferError) { session.lane("two") }
        assert_raises(ArgumentError) { session.lane("one") }
        lane.close
        assert_raises(OpenAI::Responses::BufferError) { session.lane("two") }
      end
    end
  end

  def test_invalid_lane_ids_do_not_consume_reserved_capacity
    with_server(-> (_socket, _request) { nil }) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits(max_lanes: 2)) do |session|
        [123, :named, "", "has space", "line\nbreak", "a" * 257].each do |stream_id|
          assert_raises(ArgumentError) { session.lane(stream_id) }
        end

        valid = ("a" * 253) + "_.-"
        assert_equal(valid, session.lane(valid).stream_id)
      end
    end
  end

  def test_lane_copies_mutable_caller_stream_id
    handler = lambda do |socket, _request|
      2.times do
        assert_equal("stable", read(socket)["stream_id"])
        terminal(socket, "stable")
      end
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits(max_lanes: 2)) do |session|
        stream_id = +"stable"
        lane = session.lane(stream_id)
        stream_id.replace("changed by caller")
        assert_equal("stable", lane.stream_id)
        lane.send_event(type: "response.create")
        assert_equal("resp_stable", lane.get_final_response.id)
        lane.send_event(type: "response.create")
        assert_equal("resp_stable", lane.get_final_response.id)
        lane.close
        assert_raises(ArgumentError) { session.lane("stable") }
      end
    end
  end

  def test_lane_stream_id_cannot_be_mutated_through_accessor
    handler = lambda do |socket, _request|
      assert_equal("stable", read(socket)["stream_id"])
      terminal(socket, "stable")
    end

    with_server(handler) do |client|
      OpenAI::Responses::Session.open(client: client, limits: limits) do |session|
        lane = session.lane(+"stable")
        assert_raises(FrozenError) { lane.stream_id.replace("changed through accessor") }
        lane.send_event(type: "response.create")
        assert_equal("resp_stable", lane.get_final_response.id)
      end
    end
  end

  private def limits(**overrides)
    OpenAI::Responses::SessionLimits.new(
      **{
        max_lanes: 8,
        max_events_per_lane: 32,
        max_events: 64,
        max_bytes_per_lane: 256_000,
        max_bytes: 512_000,
        max_response_bytes: 512_000
      }.merge(overrides)
    )
  end

  private def with_server(handler, headers: {}, wait_for_close: true)
    Sync do |task|
      task.with_timeout(15) do
        endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:0")
        bound = endpoint.bound
        port = bound.sockets.first.local_address.ip_port
        failures = []
        app = lambda do |request|
          Async::WebSocket::Adapters::HTTP.open(request) do |socket|
            handler.call(socket, request)
            assert_nil(socket.read) if wait_for_close
          rescue EOFError, Protocol::WebSocket::ClosedError
            # The session aborts its owned reader when its block exits.
            nil
          rescue StandardError, Minitest::Assertion => error
            failures << error
          end
        end

        server = Async::HTTP::Server.new(app, bound, protocol: endpoint.protocol, scheme: endpoint.scheme)
        server_task = server.run
        client = OpenAI::Client.new(
          api_key: "fake-key",
          base_url: "http://127.0.0.1:#{port}/v1",
          default_headers: headers
        )
        yield(client)
        task.yield
      ensure
        server_task&.stop
        bound&.close
        raise failures.first if failures && !failures.empty?
      end
    end
  end

  private def read(socket) = JSON.parse(socket.read.to_str)

  private def write(socket, **event)
    socket.write(Protocol::WebSocket::TextMessage.generate(event))
    socket.flush
  end

  private def terminal(socket, lane, status: "completed", id: "resp_#{lane || "default"}")
    event = {type: "response.#{status}", sequence_number: 1, response: {id: id, status: status, output: []}}
    event[:stream_id] = lane if lane
    write(socket, **event)
  end
end
