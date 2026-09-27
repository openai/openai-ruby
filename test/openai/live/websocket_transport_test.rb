# frozen_string_literal: true

require_relative "../test_helper"
require "async/http/endpoint"
require "async/http/server"
require "async/websocket/adapters/http"
require "async/websocket/server"
require "socket"

class OpenAI::Test::LiveWebSocketTransportTest < Minitest::Test
  extend Minitest::Serial

  def test_live_primary_handshake_start_ready_flow_on_local_socket
    accept = Queue.new
    wire = Queue.new
    listener = TCPServer.new("127.0.0.1", 0)
    port = listener.local_address.ip_port
    listener.close
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    fallback = -> (_) { Protocol::HTTP::Response[404, {}, []] }
    websocket = Async::WebSocket::Server.new(fallback) do |connection|
      message = JSON.parse(connection.read.to_str)
      wire << message
      connection.write(
        JSON.generate(type: "session.started", event_id: "start_1", session: {id: "sess_local", model: "gpt-live-1"})
      )
      connection.flush
      wire << JSON.parse(connection.read.to_str)
      connection.write(
        JSON.generate(
          type: "session.closed",
          event_id: "close_1",
          session: {id: "sess_local", model: "gpt-live-1"},
          reason: "client_requested"
        )
      )
      connection.flush
    end

    app = lambda do |request|
      accept << [request.path, request.headers["authorization"], request.headers["x-live-test"]]
      websocket.call(request)
    end

    server = Async::HTTP::Server.new(app, endpoint)
    Sync do |task|
      server_task = task.async { server.run.wait }
      api = OpenAI::Client.new(api_key: "sk-test-local", base_url: "http://127.0.0.1:#{port}/v1", timeout: 5)
      task.with_timeout(5) do
        result = api.live.connect(request_options: {extra_headers: {"X-Live-Test" => "value"}}) do |connection|
          assert_equal(["/v1/live/sessions", "Bearer sk-test-local", ["value"]], accept.pop(timeout: 1))
          assert(wire.empty?, "the SDK must not send startup before the caller chooses to")
          connection.send_event(type: "session.start", session: {model: "gpt-live-1", store: false})
          ready = connection.receive
          assert_instance_of(OpenAI::Live::SessionStartedEvent, ready)
          assert_equal("sess_local", ready.session.id)
          connection.send_event(type: "session.close")
          closed = connection.receive
          assert_instance_of(OpenAI::Live::SessionClosedEvent, closed)
          :finished
        end

        assert_equal(:finished, result)
      end

      assert_equal("session.start", wire.pop(timeout: 1).fetch("type"))
      assert_equal("session.close", wire.pop(timeout: 1).fetch("type"))
    ensure
      server_task&.stop
    end
  end
end
