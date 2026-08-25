# frozen_string_literal: true

require "async/http/server"
require "async/websocket/adapters/http"
require "async/websocket/client"
require "async/websocket/server"
require "socket"

require_relative "../test_helper"

class OpenAI::Test::AsyncWebSocketTransportTest < Minitest::Test
  extend Minitest::Serial

  def test_documented_text_lifecycle_over_a_real_local_websocket
    with_websocket_server(method(:serve_text_lifecycle)) do |client|
      client.realtime.connect(model: "gpt-realtime-2.1") do |connection|
        assert_instance_of(OpenAI::Realtime::SessionCreatedEvent, connection.receive)
        connection.session.update(type: :realtime, output_modalities: [:text])
        assert_instance_of(OpenAI::Realtime::SessionUpdatedEvent, connection.receive)

        connection.conversation.items.create(
          type: :message,
          role: :user,
          content: [{type: :input_text, text: "Say hello."}]
        )
        connection.response.create

        delta = connection.receive
        done = connection.receive
        assert_instance_of(OpenAI::Realtime::ResponseTextDeltaEvent, delta)
        assert_equal("hello from the local service", delta.delta)
        assert_instance_of(OpenAI::Realtime::ResponseDoneEvent, done)
        assert_equal(:completed, done.response.status)
        assert_nil(connection.receive)
      end
    end
  end

  def test_sideband_connections_work_without_loading_a_trace_provider
    handler = lambda do |connection|
      write_event(connection, **JSON.parse(text_delta("sideband connected"), symbolize_names: true))
    end

    with_websocket_server(handler) do |client|
      event = client.realtime.connect_to_call(call_id: "rtc_example", &:receive)

      assert_instance_of(OpenAI::Realtime::ResponseTextDeltaEvent, event)
      assert_equal("sideband connected", event.delta)
    end
  end

  def test_default_tls_rejects_an_untrusted_certificate
    key = OpenSSL::PKey::RSA.new(2_048)
    certificate = issue_certificate(
      subject: "/CN=localhost",
      key: key,
      extended_key_usage: "serverAuth",
      subject_alt_name: "DNS:localhost"
    )
    context = server_tls_context(certificate, key)

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      with_secure_websocket_server(-> (_connection) { nil }, ssl_context: context, host: "localhost") do |client|
        client.realtime.connect(model: "gpt-realtime-2.1") { |_connection| nil }
      end
    end

    assert_instance_of(OpenSSL::SSL::SSLError, error.cause)
    assert_match(/certificate verify failed/, error.cause.message)
  end

  def test_custom_tls_trust_and_client_identity_work_with_a_private_ca
    root_key = OpenSSL::PKey::RSA.new(2_048)
    root = issue_certificate(subject: "/CN=realtime-test-root", key: root_key, ca: true)
    server_key = OpenSSL::PKey::RSA.new(2_048)
    server_certificate = issue_certificate(
      subject: "/CN=127.0.0.1",
      key: server_key,
      issuer: root,
      issuer_key: root_key,
      extended_key_usage: "serverAuth",
      subject_alt_name: "IP:127.0.0.1"
    )
    client_key = OpenSSL::PKey::RSA.new(2_048)
    client_certificate = issue_certificate(
      subject: "/CN=realtime-test-client",
      key: client_key,
      issuer: root,
      issuer_key: root_key,
      extended_key_usage: "clientAuth"
    )
    trust_store = OpenSSL::X509::Store.new
    trust_store.add_cert(root)
    server_context = server_tls_context(server_certificate, server_key)
    server_context.cert_store = trust_store
    server_context.client_ca = [root]
    server_context.verify_mode = OpenSSL::SSL::VERIFY_PEER | OpenSSL::SSL::VERIFY_FAIL_IF_NO_PEER_CERT
    transport = OpenAI::Realtime::Transports::AsyncWebSocket.new do |context|
      context.cert_store = trust_store
      context.cert = client_certificate
      context.key = client_key
    end

    handler = lambda do |connection|
      write_event(connection, **JSON.parse(text_delta("mutual TLS connected"), symbolize_names: true))
    end

    with_secure_websocket_server(handler, ssl_context: server_context) do |client|
      event = client.realtime.connect(
        model: "gpt-realtime-2.1",
        transport: transport,
        &:receive
      )

      assert_instance_of(OpenAI::Realtime::ResponseTextDeltaEvent, event)
      assert_equal("mutual TLS connected", event.delta)

      sideband_event = client.realtime.connect_to_call(
        call_id: "rtc_example",
        transport: transport,
        &:receive
      )

      assert_instance_of(OpenAI::Realtime::ResponseTextDeltaEvent, sideband_event)
      assert_equal("mutual TLS connected", sideband_event.delta)
    end
  end

  def test_tls_configurator_cannot_disable_verification_or_install_a_callback
    connection = Class
      .new do
        def read = nil
        def closed? = true
        def close(*) = nil
      end
      .new
    client = Class
      .new do
        attr_reader(:closed)

        def initialize(connection) = @connection = connection
        def connect(*) = @connection
        def close = @closed = true
      end
      .new(connection)
    parsed_endpoint = nil
    parse = Async::HTTP::Endpoint.method(:parse)
    parser = lambda do |url, **options|
      parse.call(url, **options).tap do |endpoint|
        parsed_endpoint = endpoint if url.to_s.start_with?("wss://example.com/")
      end
    end

    transport = OpenAI::Realtime::Transports::AsyncWebSocket.new do |context|
      context.verify_mode = OpenSSL::SSL::VERIFY_NONE
      context.verify_hostname = false
    end

    url = URI("wss://example.com/v1/realtime?model=gpt-realtime-2.1")

    Async::HTTP::Endpoint.stub(:parse, parser) do
      Async::WebSocket::Client.stub(:open, client) do
        transport.open(url: url, headers: {}, timeout: nil) { |_socket| nil }
      end
    end

    assert_equal(OpenSSL::SSL::VERIFY_PEER, parsed_endpoint.ssl_context.verify_mode)
    assert_predicate(parsed_endpoint.ssl_context, :verify_hostname)
    assert_predicate(client, :closed)

    callback_transport = OpenAI::Realtime::Transports::AsyncWebSocket.new do |context|
      context.verify_callback = -> (_verified, _store_context) { true }
    end

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      callback_transport.open(url: url, headers: {}, timeout: nil) { |_socket| nil }
    end

    assert_includes(error.cause.message, "verify_callback")
  end

  def test_tls_configuration_rejects_a_plaintext_websocket
    transport = OpenAI::Realtime::Transports::AsyncWebSocket.new { |_context| nil }
    url = URI("ws://example.com/v1/realtime?model=gpt-realtime-2.1")

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      transport.open(url: url, headers: {}, timeout: nil) { |_socket| nil }
    end

    assert_instance_of(ArgumentError, error.cause)
    assert_includes(error.cause.message, "wss://")
  end

  def test_fragmented_text_messages_are_reassembled
    handler = lambda do |connection|
      payload = text_delta("fragmented")
      midpoint = payload.bytesize / 2
      first = Protocol::WebSocket::TextFrame.new(false).pack(payload.byteslice(0, midpoint))
      second = Protocol::WebSocket::ContinuationFrame.new(true).pack(payload.byteslice(midpoint..))
      connection.write_frame(first)
      connection.write_frame(second)
      connection.flush
    end

    with_websocket_server(handler) do |client|
      event = client.realtime.connect(model: "gpt-realtime-2.1", &:receive)

      assert_instance_of(OpenAI::Realtime::ResponseTextDeltaEvent, event)
      assert_equal("fragmented", event.delta)
    end
  end

  def test_abnormal_remote_close_is_a_connection_error
    peer_detail = "customer prompt: do not log this"
    handler = -> (connection) { connection.close(1011, peer_detail) }

    with_websocket_server(handler) do |client|
      error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
        client.realtime.connect(model: "gpt-realtime-2.1", &:receive)
      end

      assert_instance_of(Protocol::WebSocket::ClosedError, error.cause)
      assert_includes(error.cause.message, peer_detail)
      assert_equal("Realtime WebSocket connection error.", error.message)
      refute_includes(error.message, peer_detail)
    end
  end

  def test_handshake_failures_preserve_the_target_and_cause
    port = available_port
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "http://127.0.0.1:#{port}/v1",
      timeout: 0.5
    )

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      client.realtime.connect(model: "gpt-realtime-2.1") { |_connection| nil }
    end

    assert_equal(
      "ws://127.0.0.1:#{port}/v1/realtime?model=gpt-realtime-2.1",
      error.url.to_s
    )
    refute_nil(error.cause)
    assert_equal("Realtime WebSocket connection error.", error.message)
    refute_includes(error.message, error.cause.message)
  end

  def test_sideband_handshake_failures_redact_the_error_url
    port = available_port
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "http://127.0.0.1:#{port}/v1",
      timeout: 0.5
    )

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      client.realtime.connect_to_call(call_id: "rtc_sensitive") { |_connection| nil }
    end

    assert_equal(
      "ws://127.0.0.1:#{port}/v1/realtime?call_id=[REDACTED]",
      error.url.to_s
    )
    refute_includes(error.url.to_s, "rtc_sensitive")
    refute_nil(error.cause)
  end

  def test_sideband_socket_failures_redact_the_error_url
    handler = -> (connection) { connection.close(1011, "service failure") }

    with_websocket_server(handler) do |client|
      error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
        client.realtime.connect_to_call(call_id: "rtc_sensitive", &:receive)
      end

      assert_instance_of(Protocol::WebSocket::ClosedError, error.cause)
      assert_equal("call_id=[REDACTED]", error.url.query)
      refute_includes(error.url.to_s, "rtc_sensitive")
    end
  end

  def test_request_timeout_bounds_negotiation_but_not_an_established_session
    server = TCPServer.new("127.0.0.1", 0)
    release_server = Queue.new
    server_thread = Thread.new do
      socket = server.accept
      socket.readpartial(4_096)
      release_server.pop
    rescue IOError, SystemCallError
      nil
    ensure
      socket&.close
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "http://127.0.0.1:#{server.local_address.ip_port}/v1",
      timeout: 0.1
    )

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      client.realtime.connect(model: "gpt-realtime-2.1") { |_connection| nil }
    end

    assert_instance_of(Async::TimeoutError, error.cause)

    delayed = lambda do |connection|
      sleep(0.3)
      write_event(connection, **JSON.parse(text_delta("still connected"), symbolize_names: true))
    end

    with_websocket_server(delayed, timeout: 0.1) do |established_client|
      event = established_client.realtime.connect(model: "gpt-realtime-2.1", &:receive)
      assert_equal("still connected", event.delta)
    end

  ensure
    release_server&.push(true)
    server&.close
    server_thread&.join
  end

  def test_missing_optional_dependency_is_actionable
    transport_class = Class.new(OpenAI::Realtime::Transports::AsyncWebSocket) do
      private def require(path)
        raise LoadError, "cannot load #{path}" if path == "async/websocket/client"

        super
      end
    end

    url = URI("wss://example.com/v1/realtime?model=gpt-realtime-2.1")

    error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
      transport_class.new.open(url: url, headers: {}, timeout: 1) { |_socket| nil }
    end

    assert_instance_of(LoadError, error.cause)
    assert_includes(error.message, "Add `gem \"async-websocket\"` to your Gemfile")
  end

  private def serve_text_lifecycle(connection)
    write_event(
      connection,
      type: "session.created",
      event_id: "event_created",
      session: {type: "realtime"}
    )
    update = read_event(connection)
    raise "expected session.update" unless update.fetch("type") == "session.update"

    write_event(
      connection,
      type: "session.updated",
      event_id: "event_updated",
      session: update.fetch("session")
    )
    unless read_event(connection).fetch("type") == "conversation.item.create"
      raise "expected conversation item"
    end

    raise "expected response.create" unless read_event(connection).fetch("type") == "response.create"

    write_event(
      connection,
      **JSON.parse(text_delta("hello from the local service"), symbolize_names: true)
    )
    write_event(
      connection,
      type: "response.done",
      event_id: "event_done",
      response: {id: "response_1", status: "completed", output: []}
    )
  end

  private def with_websocket_server(handler, timeout: 5)
    port = available_port
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    fallback = -> (_request) { Protocol::HTTP::Response[404, {}, []] }
    websocket = Async::WebSocket::Server.new(fallback, &handler)
    server = Async::HTTP::Server.new(websocket, endpoint)

    Sync do |task|
      server_task = task.async { server.run.wait }
      client = OpenAI::Client.new(
        api_key: "test-key",
        base_url: "http://127.0.0.1:#{port}/v1",
        timeout: timeout
      )
      yield(client)
    ensure
      server_task&.stop
    end
  end

  private def with_secure_websocket_server(handler, ssl_context:, host: "127.0.0.1")
    port = available_port
    endpoint = Async::HTTP::Endpoint.parse(
      "https://127.0.0.1:#{port}",
      ssl_context: ssl_context,
      protocol: Async::HTTP::Protocol::HTTP11
    )
    fallback = -> (_request) { Protocol::HTTP::Response[404, {}, []] }
    websocket = Async::WebSocket::Server.new(fallback, &handler)
    server = Async::HTTP::Server.new(websocket, endpoint)

    Sync do |task|
      server_task = task.async { server.run.wait }
      client = OpenAI::Client.new(
        api_key: "test-key",
        base_url: "https://#{host}:#{port}/v1",
        timeout: 5
      )
      yield(client)
    ensure
      server_task&.stop
    end
  end

  private def server_tls_context(certificate, key)
    OpenSSL::SSL::SSLContext.new.tap do |context|
      context.cert = certificate
      context.key = key
      context.alpn_select_cb = lambda do |protocols|
        (protocols & Async::HTTP::Protocol::HTTP11.names).fetch(0)
      end
    end
  end

  private def issue_certificate(
    subject:,
    key:,
    issuer: nil,
    issuer_key: nil,
    ca: false,
    extended_key_usage: nil,
    subject_alt_name: nil
  )
    certificate = OpenSSL::X509::Certificate.new
    certificate.version = 2
    certificate.serial = rand(1..1_000_000)
    certificate.subject = OpenSSL::X509::Name.parse(subject)
    certificate.issuer = issuer ? issuer.subject : certificate.subject
    certificate.public_key = key.public_key
    certificate.not_before = Time.now - 60
    certificate.not_after = Time.now + 3_600

    extensions = OpenSSL::X509::ExtensionFactory.new
    extensions.subject_certificate = certificate
    extensions.issuer_certificate = issuer || certificate
    certificate.add_extension(
      extensions.create_extension("basicConstraints", ca ? "CA:TRUE" : "CA:FALSE", true)
    )
    certificate.add_extension(
      extensions.create_extension(
        "keyUsage",
        ca ? "keyCertSign,cRLSign" : "digitalSignature,keyEncipherment",
        true
      )
    )
    certificate.add_extension(extensions.create_extension("subjectKeyIdentifier", "hash"))
    certificate.add_extension(extensions.create_extension("authorityKeyIdentifier", "keyid:always"))
    if extended_key_usage
      certificate.add_extension(extensions.create_extension("extendedKeyUsage", extended_key_usage))
    end

    if subject_alt_name
      certificate.add_extension(extensions.create_extension("subjectAltName", subject_alt_name))
    end

    certificate.sign(issuer_key || key, OpenSSL::Digest.new("SHA256"))
    certificate
  end

  private def read_event(connection)
    message = connection.read
    raise "client closed before the expected event" if message.nil?

    JSON.parse(message.to_str)
  end

  private def write_event(connection, **event)
    connection.write(Protocol::WebSocket::TextMessage.generate(event))
    connection.flush
  end

  private def text_delta(delta)
    JSON.generate(
      type: "response.output_text.delta",
      event_id: "event_delta",
      response_id: "response_1",
      item_id: "item_1",
      output_index: 0,
      content_index: 0,
      delta: delta
    )
  end

  private def available_port
    server = TCPServer.new("127.0.0.1", 0)
    server.local_address.ip_port
  ensure
    server&.close
  end
end
