# frozen_string_literal: true

require "async/http/server"
require "async/queue"
require "async/websocket/adapters/http"
require "async/websocket/server"
require "socket"
require "traces/backend/capture"
require "traces"
Traces.extend(Traces::Backend::Capture::Interface)
require "traces/provider/protocol/http1"

require_relative "../test_helper"

class OpenAI::Test::RealtimeNetworkInvariantsTest < Minitest::Test
  extend Minitest::Serial

  def test_protocol_http1_traces_redact_handshake_credentials_but_wire_receives_them
    wire_headers = nil
    Traces::Backend::Capture.spans.clear
    handler = lambda do |connection|
      connection.write(Protocol::WebSocket::TextMessage.generate(type: "session.created"))
      connection.flush
    end

    with_server(handler, wrap: lambda { |websocket|
      lambda do |request|
        wire_headers = request.headers.to_h
        websocket.call(request)
      end
    }) do |url|
      transport = OpenAI::Realtime::Transports::AsyncWebSocket.new
      transport.open(
        url: url,
        headers: {
          "authorization" => "Bearer origin-secret",
          "api-key" => "azure-secret",
          "proxy-authorization" => "Basic proxy-secret",
          "x-observable" => "visible"
        },
        timeout: 2
      ) { |socket| socket.read }
    end

    assert_equal("Bearer origin-secret", Array(wire_headers.fetch("authorization")).first)
    assert_equal("azure-secret", Array(wire_headers.fetch("api-key")).first)
    traced = traced_request_headers(method: "GET")
    assert_equal("[REDACTED]", traced.fetch("authorization"))
    assert_equal("[REDACTED]", traced.fetch("api-key"))
    assert_equal("[REDACTED]", traced.fetch("proxy-authorization"))
    assert_equal("visible", traced.fetch("x-observable"))
  end

  def test_binary_encoded_json_is_sent_as_a_text_frame
    message_class = nil
    handler = lambda do |connection|
      message = connection.read
      message_class = message.class
    end

    with_server(handler) do |url|
      transport = OpenAI::Realtime::Transports::AsyncWebSocket.new
      socket = nil
      transport.open(url: url, headers: {}, timeout: 2) do |opened|
        socket = opened
        connection = OpenAI::Realtime::Connection.new(socket: socket, url: url)
        connection.send_raw(JSON.generate(type: "session.update").b)
      end
    end

    assert_equal(Protocol::WebSocket::TextMessage, message_class)
  end

  def test_ipv6_websocket_handshake_uses_a_bracketed_authority
    authority = nil
    handler = ->(_connection) { nil }
    port = available_port("::1")
    endpoint = Async::HTTP::Endpoint.parse("http://[::1]:#{port}")
    server = nil

    Sync do |task|
      fallback = ->(_request) { Protocol::HTTP::Response[404, {}, []] }
      websocket = Async::WebSocket::Server.new(fallback, &handler)
      app = lambda do |request|
        authority = request.authority
        websocket.call(request)
      end
      server = Async::HTTP::Server.new(app, endpoint)
      server_task = task.async { server.run.wait }
      client = OpenAI::Client.new(
        api_key: "test-key",
        base_url: "http://[::1]:#{port}/v1",
        timeout: 2
      )

      client.realtime.connect(model: "gpt-realtime-2.1") { |_connection| nil }
      assert_equal("[::1]:#{port}", authority)
    ensure
      server_task&.stop
    end
  rescue SocketError, Errno::EADDRNOTAVAIL
    skip("IPv6 loopback is unavailable")
  end

  def test_http_proxy_uses_connect_and_isolates_proxy_and_origin_credentials
    Traces::Backend::Capture.spans.clear
    origin_headers = nil
    connect_request = nil
    handler = lambda do |connection|
      connection.write(Protocol::WebSocket::TextMessage.generate(type: "session.created"))
      connection.flush
    end

    with_server(handler, wrap: lambda { |websocket|
      lambda do |request|
        origin_headers = request.headers.to_h
        websocket.call(request)
      end
    }) do |target_url|
      proxy = TCPServer.new("127.0.0.1", 0)
      proxy_thread = Thread.new do
        downstream = proxy.accept
        connect_request = read_http_headers(downstream)
        upstream = TCPSocket.new("127.0.0.1", target_url.port)
        downstream.write("HTTP/1.1 200 Connection Established\r\n\r\n")
        relay(downstream, upstream)
      ensure
        downstream&.close
        upstream&.close
      end
      env = {
        "http_proxy" => "http://proxy-user:proxy-pass@127.0.0.1:#{proxy.local_address.ip_port}",
        "HTTP_PROXY" => nil,
        "no_proxy" => "",
        "NO_PROXY" => ""
      }
      with_env(env) do
        url = target_url.dup
        url.host = "realtime-proxy-test.invalid"
        transport = OpenAI::Realtime::Transports::AsyncWebSocket.new
        transport.open(
          url: url,
          headers: {"authorization" => "Bearer origin-secret"},
          timeout: 2
        ) { |socket| socket.read }
      end

      proxy_thread.join(2)
      refute_predicate(proxy_thread, :alive?)
      assert_match(%r{\ACONNECT realtime-proxy-test\.invalid:\d+ HTTP/1\.1\r\n}, connect_request)
      assert_includes(connect_request.downcase, "proxy-authorization: basic ")
      refute_includes(connect_request.downcase, "authorization: bearer origin-secret")
      assert_equal("Bearer origin-secret", origin_headers.fetch("authorization"))
      refute(origin_headers.key?("proxy-authorization"))
      assert_equal(
        "[REDACTED]",
        traced_request_headers(method: "CONNECT").fetch("proxy-authorization")
      )
      assert_equal("[REDACTED]", traced_request_headers(method: "GET").fetch("authorization"))
    ensure
      proxy&.close
      proxy_thread&.kill
      proxy_thread&.join
    end
  end

  def test_no_proxy_bypasses_the_configured_proxy
    handler = lambda do |connection|
      connection.write(Protocol::WebSocket::TextMessage.generate(type: "session.created"))
      connection.flush
    end

    with_server(handler) do |url|
      with_env(
        "http_proxy" => "http://127.0.0.1:1",
        "HTTP_PROXY" => nil,
        "no_proxy" => "127.0.0.1",
        "NO_PROXY" => nil
      ) do
        transport = OpenAI::Realtime::Transports::AsyncWebSocket.new
        message = transport.open(url: url, headers: {}, timeout: 2, &:read)
        assert_equal('{"type":"session.created"}', message.to_str)
      end
    end
  end

  def test_exceptional_cleanup_hard_closes_a_congested_websocket
    release = Async::Queue.new
    handler = ->(_connection) { release.dequeue }
    writer = nil

    with_server(handler) do |url|
      client = OpenAI::Client.new(
        api_key: "test-key",
        base_url: "http://127.0.0.1:#{url.port}/v1",
        timeout: 2
      )

      error = assert_raises(RuntimeError) do
        Async::Task.current.with_timeout(1) do
          client.realtime.connect(model: "gpt-realtime-2.1") do |connection|
            writer = Async::Task.current.async do
              connection.send_raw("x" * (16 * 1_024 * 1_024))
            rescue Async::Stop, OpenAI::Errors::RealtimeConnectionError
              nil
            end
            sleep(0.05)
            raise "application failed"
          end
        end
      end

      assert_equal("application failed", error.message)
      assert_predicate(writer, :finished?)
      release.enqueue(true)
    end
  ensure
    release&.enqueue(true)
  end

  def test_workload_identity_retries_one_real_upgrade_after_a_401
    attempts = []
    invalidations = 0
    tokens = ["stale-token", "fresh-token"]
    handler = ->(_connection) { nil }

    with_server(handler, wrap: lambda { |websocket|
      lambda do |request|
        attempts << request.headers["authorization"]
        if attempts.one?
          Protocol::HTTP::Response[401, {"content-type" => "text/plain"}, ["expired"]]
        else
          websocket.call(request)
        end
      end
    }) do |url|
      client = workload_identity_client(url)
      client.workload_identity_auth.stub(:get_token, -> { tokens.shift }) do
        client.workload_identity_auth.stub(:invalidate_token, -> { invalidations += 1 }) do
          client.realtime.connect(model: "gpt-realtime-2.1") { |_connection| nil }
        end
      end
    end

    assert_equal(["Bearer stale-token", "Bearer fresh-token"], attempts)
    assert_equal(1, invalidations)
  end

  private def with_server(handler, wrap: nil)
    port = available_port("127.0.0.1")
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    server = nil
    Sync do |task|
      fallback = ->(_request) { Protocol::HTTP::Response[404, {}, []] }
      websocket = Async::WebSocket::Server.new(fallback, &handler)
      app = wrap ? wrap.call(websocket) : websocket
      server = Async::HTTP::Server.new(app, endpoint)
      server_task = task.async { server.run.wait }
      yield(URI("ws://127.0.0.1:#{port}/v1/realtime"))
    ensure
      server_task&.stop
    end
  end

  private def workload_identity_client(url)
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: "/not-read-by-this-test"
    )
    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp_123",
      service_account_id: "sa_123",
      provider: provider
    )
    OpenAI::Client.new(
      api_key: nil,
      workload_identity: config,
      organization: "org_123",
      base_url: "http://127.0.0.1:#{url.port}/v1",
      timeout: 2
    )
  end

  private def available_port(host)
    socket = TCPServer.new(host, 0)
    socket.local_address.ip_port
  ensure
    socket&.close
  end

  private def traced_request_headers(method:)
    span = Traces::Backend::Capture.spans.reverse.find do |candidate|
      candidate.name == "protocol.http1.connection.write_request" &&
        candidate.attributes[:method] == method
    end
    refute_nil(span)
    span.attributes.fetch(:headers)
  end

  private def read_http_headers(io)
    buffer = +""
    buffer << io.readpartial(1_024) until buffer.include?("\r\n\r\n")
    buffer
  end

  private def relay(left, right)
    threads = [
      Thread.new { IO.copy_stream(left, right) },
      Thread.new { IO.copy_stream(right, left) }
    ]
    threads.each(&:join)
  rescue IOError, SystemCallError
    nil
  ensure
    left.close unless left.closed?
    right.close unless right.closed?
  end

  private def with_env(values)
    previous = values.to_h { |name, _value| [name, ENV[name]] }
    values.each { |name, value| value.nil? ? ENV.delete(name) : ENV[name] = value }
    yield
  ensure
    previous&.each { |name, value| value.nil? ? ENV.delete(name) : ENV[name] = value }
  end
end
