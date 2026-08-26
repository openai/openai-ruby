# frozen_string_literal: true

require "open3"
require "socket"
require "stringio"
require "console/capture"
require "console/logger"

require_relative "../test_helper"
require_relative "../../../examples/realtime/webrtc_conversation"

class OpenAI::Test::RealtimeWebRTCConversationExampleTest < Minitest::Test
  ORIGIN = "http://127.0.0.1:4567"
  CSRF_TOKEN = "synthetic-csrf-token"
  APPLICATION_TOKEN = "synthetic-application-token"
  SECRET = Data.define(:value, :expires_at)

  def test_authorized_browser_receives_a_short_lived_secret_without_allocating_a_call
    secrets = Minitest::Mock.new
    secrets.expect(:create, SECRET.new(value: "ek_synthetic_secret", expires_at: 1234)) do |expires_after:, session:|
      assert_equal({anchor: :created_at, seconds: 60}, expires_after)
      assert_equal(:realtime, session.fetch(:type))
      assert_equal("gpt-realtime-2.1", session.fetch(:model))
      assert_equal(true, session.dig(:audio, :input, :turn_detection, :interrupt_response))
      true
    end

    realtime = Minitest::Mock.new
    realtime.expect(:client_secrets, secrets)
    client = Minitest::Mock.new
    client.expect(:realtime, realtime)
    errors = StringIO.new

    response = application(client: client, error_output: errors).call(token_request)

    assert_equal(201, response.status)
    assert_equal("application/json", response.headers["content-type"])
    assert_equal({"value" => "ek_synthetic_secret", "expires_at" => 1234}, JSON.parse(response.read))
    assert_security_headers(response)
    assert_empty(errors.string)
    [client, realtime, secrets].each(&:verify)
  end

  def test_page_contains_nonce_and_csrf_token_but_never_application_or_api_credentials
    html = "<style nonce=\"__CSP_NONCE__\"></style><script nonce=\"__CSP_NONCE__\">__CSRF_TOKEN__</script>"
    errors = StringIO.new

    response = application(client: Minitest::Mock.new, html: html, error_output: errors).call(page_request)
    content = response.read

    assert_equal(200, response.status)
    assert_equal("text/html; charset=utf-8", response.headers["content-type"])
    assert_includes(content, CSRF_TOKEN)
    refute_includes(content, "__CSP_NONCE__")
    refute_includes(content, APPLICATION_TOKEN)
    assert_match(/nonce="[0-9a-f]{48}"/, content)
    policy = response.headers["content-security-policy"].to_s
    assert_match(/script-src 'nonce-[0-9a-f]{48}'/, policy)
    refute_includes(policy, "unsafe-inline")
    assert_security_headers(response)
    assert_empty(errors.string)
  end

  def test_host_must_exactly_match_the_loopback_origin
    response = application(client: Minitest::Mock.new).call(token_request("host" => "attacker.example"))

    assert_forbidden(response)
  end

  def test_duplicate_host_headers_are_rejected
    headers = valid_headers.to_a + [["host", "attacker.example"]]
    response = application(client: Minitest::Mock.new).call(request(headers: headers))

    assert_forbidden(response)
  end

  def test_request_authority_must_match_the_host_header
    message = request(headers: valid_headers)
    message.authority = "attacker.example"

    assert_forbidden(application(client: Minitest::Mock.new).call(message))
  end

  def test_normalized_request_authority_is_accepted_when_the_parser_consumes_host
    message = request(method: "GET", path: "/", headers: {})
    message.authority = "127.0.0.1:4567"

    assert_equal(200, application(client: Minitest::Mock.new).call(message).status)
  end

  def test_real_loopback_http_request_serves_the_browser_page
    with_loopback_server do |port|
      response = raw_http(port, "GET / HTTP/1.1\r\nHost: 127.0.0.1:#{port}\r\nConnection: close\r\n\r\n")

      assert_match(%r{\AHTTP/1\.1 200 OK\r\n}, response)
      assert_includes(response.downcase, "cache-control: no-store")
      assert_includes(response, "demo")
    end
  end

  def test_real_loopback_http_request_issues_an_authorized_client_secret
    secrets = Minitest::Mock.new
    secrets.expect(:create, SECRET.new(value: "ek_synthetic_secret", expires_at: 1234)) do |**_params|
      true
    end

    realtime = Minitest::Mock.new
    realtime.expect(:client_secrets, secrets)
    client = Minitest::Mock.new
    client.expect(:realtime, realtime)

    with_loopback_server(client: client) do |port|
      response = raw_http(
        port,
        "POST /token HTTP/1.1\r\n" \
          "Host: 127.0.0.1:#{port}\r\n" \
          "Origin: http://127.0.0.1:#{port}\r\n" \
          "Authorization: Bearer #{APPLICATION_TOKEN}\r\n" \
          "X-Realtime-CSRF: #{CSRF_TOKEN}\r\n" \
          "Content-Length: 0\r\n" \
          "Connection: close\r\n\r\n"
      )

      headers, body = response.split("\r\n\r\n", 2)
      assert_match(%r{\AHTTP/1\.1 201 Created\r\n}, headers)
      assert_equal({"value" => "ek_synthetic_secret", "expires_at" => 1234}, JSON.parse(body))
    end

    [client, realtime, secrets].each(&:verify)
  end

  def test_real_http_parser_rejects_duplicate_host_before_normalizing_authority
    with_loopback_server do |port|
      response = raw_http(
        port,
        "GET / HTTP/1.1\r\n" \
          "Host: attacker.example\r\n" \
          "Host: 127.0.0.1:#{port}\r\n" \
          "Connection: close\r\n\r\n"
      )

      assert_match(%r{\AHTTP/1\.1 400 Bad Request\r\n}, response)
      assert_raw_security_headers(response)
    end
  end

  def test_real_http_parser_rejects_absolute_form_request_targets
    with_loopback_server do |port|
      response = raw_http(
        port,
        "GET http://127.0.0.1:#{port}/ HTTP/1.1\r\n" \
          "Host: attacker.example\r\n" \
          "Connection: close\r\n\r\n"
      )

      assert_match(%r{\AHTTP/1\.1 400 Bad Request\r\n}, response)
      assert_raw_security_headers(response)
    end
  end

  def test_real_http_parser_never_logs_credentials_from_malformed_authorization_headers
    logs = ::Console::Capture.new
    credential = "ek_synthetic_parser_header_secret"

    with_loopback_server(logs: logs) do |port|
      response = raw_http(
        port,
        "GET / HTTP/1.1\r\n" \
          "Host: 127.0.0.1:#{port}\r\n" \
          "Authorization : Bearer #{credential}\r\n" \
          "Connection: close\r\n\r\n"
      )

      assert_match(%r{\AHTTP/1\.1 400 Bad Request\r\n}, response)
      assert_raw_security_headers(response)
    end

    assert_empty(logs.records)
    refute_includes(logs.records.inspect, credential)
  end

  def test_real_http_parser_never_logs_credentials_from_malformed_request_targets
    logs = ::Console::Capture.new
    credential = "ek_synthetic_parser_target_secret"

    with_loopback_server(logs: logs) do |port|
      response = raw_http(
        port,
        "GET /?credential=#{credential} HTTP/1.1 EXTRA\r\n" \
          "Host: 127.0.0.1:#{port}\r\n" \
          "Connection: close\r\n\r\n"
      )

      assert_match(%r{\AHTTP/1\.1 400 Bad Request\r\n}, response)
      assert_raw_security_headers(response)
    end

    assert_empty(logs.records)
    refute_includes(logs.records.inspect, credential)
  end

  def test_real_http_parser_rejects_transfer_encoding_bodies_and_protocol_upgrades
    ["Transfer-Encoding: gzip", "Transfer-Encoding: chunked", "Content-Length: 100", "Upgrade: websocket"].each do |
        framing
      |
      with_loopback_server do |port|
        response = raw_http(
          port,
          "POST /token HTTP/1.1\r\n" \
            "Host: 127.0.0.1:#{port}\r\n" \
            "Origin: http://127.0.0.1:#{port}\r\n" \
            "Authorization: Bearer #{APPLICATION_TOKEN}\r\n" \
            "X-Realtime-CSRF: #{CSRF_TOKEN}\r\n" \
            "#{framing}\r\n" \
            "Connection: close\r\n\r\n"
        )

        assert_match(%r{\AHTTP/1\.1 400 Bad Request\r\n}, response)
        assert_raw_security_headers(response)
      end
    end
  end

  def test_cross_origin_or_missing_origin_cannot_mint_credentials
    [nil, "https://127.0.0.1:4567", "http://attacker.example"].each do |origin|
      response = application(client: Minitest::Mock.new).call(token_request("origin" => origin))

      assert_forbidden(response)
    end
  end

  def test_missing_wrong_or_duplicate_csrf_headers_are_rejected
    [nil, "wrong-csrf-token"].each do |csrf|
      response = application(client: Minitest::Mock.new).call(token_request("x-realtime-csrf" => csrf))

      assert_forbidden(response)
    end

    headers = valid_headers.to_a + [["X-Realtime-CSRF", "wrong-csrf-token"]]
    assert_forbidden(application(client: Minitest::Mock.new).call(request(headers: headers)))
  end

  def test_missing_or_non_bearer_application_authorization_is_unauthorized
    [nil, "Basic synthetic", APPLICATION_TOKEN].each do |authorization|
      response = application(client: Minitest::Mock.new).call(token_request("authorization" => authorization))

      assert_equal(401, response.status)
      assert_equal("Unauthorized\n", response.read)
      assert_security_headers(response)
    end
  end

  def test_unapproved_or_duplicate_application_authorization_is_forbidden
    response = application(client: Minitest::Mock.new).call(
      token_request("authorization" => "Bearer unapproved-token")
    )

    assert_forbidden(response)

    headers = valid_headers.to_a + [["Authorization", "Bearer another-token"]]
    duplicate = application(client: Minitest::Mock.new).call(request(headers: headers))

    assert_equal(401, duplicate.status)
  end

  def test_authorization_policy_must_return_a_nonempty_trusted_identity
    [nil, false, true, ""].each do |principal|
      app = application(client: Minitest::Mock.new, authorization_policy: -> (_token, _request) { principal })

      assert_forbidden(app.call(token_request))
    end
  end

  def test_issuance_is_limited_per_identity_and_recovers_after_one_minute
    now = 10.0
    secrets = Minitest::Mock.new
    6.times do
      secrets.expect(:create, SECRET.new(value: "ek_synthetic_secret", expires_at: 1234)) do |**_params|
        true
      end
    end

    realtime = Minitest::Mock.new
    6.times { realtime.expect(:client_secrets, secrets) }
    client = Minitest::Mock.new
    6.times { client.expect(:realtime, realtime) }
    app = application(client: client, clock: -> { now })

    5.times { assert_equal(201, app.call(token_request).status) }
    limited = app.call(token_request)

    assert_equal(429, limited.status)
    assert_equal("Too many requests\n", limited.read)
    assert_security_headers(limited)

    now += 60
    assert_equal(201, app.call(token_request).status)
    [client, realtime, secrets].each(&:verify)
  end

  def test_authorized_identities_have_independent_rate_limits
    secrets = Minitest::Mock.new
    6.times do
      secrets.expect(:create, SECRET.new(value: "ek_synthetic_secret", expires_at: 1234)) do |**_params|
        true
      end
    end

    realtime = Minitest::Mock.new
    6.times { realtime.expect(:client_secrets, secrets) }
    client = Minitest::Mock.new
    6.times { client.expect(:realtime, realtime) }
    app = application(client: client, authorization_policy: -> (token, _request) { token })

    5.times { assert_equal(201, app.call(token_request).status) }
    assert_equal(429, app.call(token_request).status)
    second_identity = token_request("authorization" => "Bearer second-authorized-identity")

    assert_equal(201, app.call(second_identity).status)
    [client, realtime, secrets].each(&:verify)
  end

  def test_service_failures_never_expose_credentials_customer_data_or_service_details
    customer_data = "private customer prompt and ek_synthetic_secret"
    secrets = Minitest::Mock.new
    secrets.expect(:create, nil) { |**_params| raise IOError, customer_data }
    realtime = Minitest::Mock.new
    realtime.expect(:client_secrets, secrets)
    client = Minitest::Mock.new
    client.expect(:realtime, realtime)
    errors = StringIO.new

    response = application(client: client, error_output: errors).call(token_request)

    assert_equal(502, response.status)
    assert_equal("Realtime request failed\n", response.read)
    assert_equal("[realtime] token issuance failed: IOError\n", errors.string)
    refute_includes(errors.string, customer_data)
    refute_includes(errors.string, APPLICATION_TOKEN)
    assert_security_headers(response)
    [client, realtime, secrets].each(&:verify)
  end

  def test_authorization_failures_do_not_expose_policy_details
    errors = StringIO.new
    policy = -> (_token, _request) { raise ArgumentError, "private tenant authorization details" }

    response = application(client: Minitest::Mock.new, authorization_policy: policy, error_output: errors).call(
      token_request
    )

    assert_equal(502, response.status)
    assert_equal("Realtime request failed\n", response.read)
    assert_equal("[realtime] token issuance failed: ArgumentError\n", errors.string)
  end

  def test_unknown_paths_and_methods_do_not_allocate_credentials
    app = application(client: Minitest::Mock.new)

    [request(method: "GET", path: "/token"), request(method: "POST", path: "/unknown")].each do |message|
      response = app.call(message)

      assert_equal(404, response.status)
      assert_equal("Not found\n", response.read)
      assert_security_headers(response)
    end
  end

  def test_origin_configuration_rejects_non_loopback_credentials_paths_queries_and_fragments
    [
      "https://127.0.0.1:4567",
      "http://localhost:4567",
      "http://0.0.0.0:4567",
      "http://attacker.example:4567",
      "http://user@127.0.0.1:4567",
      "http://127.0.0.1:4567/token",
      "http://127.0.0.1:4567?query=true",
      "http://127.0.0.1:4567#fragment",
      "not an origin"
    ].each do |origin|
      error = assert_raises(ArgumentError) { application(client: Minitest::Mock.new, origin: origin) }

      assert_equal("Expected an HTTP loopback origin without credentials or a path", error.message)
    end
  end

  def test_ipv6_loopback_authority_is_supported
    app = application(client: Minitest::Mock.new, origin: "http://[::1]:4567")
    response = app.call(request(method: "GET", path: "/", headers: {"host" => "[::1]:4567"}))

    assert_equal(200, response.status)
  end

  def test_browser_keeps_signaling_media_and_teardown_on_the_client
    html = File.binread(File.join(__dir__, "../../../examples/realtime/webrtc_conversation.html"))

    assert_includes(html, "navigator.mediaDevices.getUserMedia")
    assert_includes(html, "new RTCPeerConnection()")
    assert_includes(html, "connection.createDataChannel(\"oai-events\")")
    assert_includes(html, "fetch(\"https://api.openai.com/v1/realtime/calls\"")
    assert_includes(html, "\"X-Realtime-CSRF\": csrfToken")
    assert_includes(html, "cache: \"no-store\"")
    assert_includes(html, "startupController?.abort()")
    assert_includes(html, "dataChannel?.close()")
    assert_includes(html, "peerConnection?.close()")
    assert_includes(html, "microphoneStream?.getTracks().forEach((track) => track.stop())")
    assert_includes(html, "window.addEventListener(\"pagehide\"")
    refute_includes(html, "localStorage")
    refute_includes(html, "sessionStorage")
    refute_includes(html, "console.log")
  end

  def test_browser_startup_cancellation_signaling_and_teardown_execute_deterministically
    browser_test = File.join(__dir__, "webrtc_conversation_browser_test.js")
    output, status = Open3.capture2e("node", "--test", browser_test)

    assert_predicate(status, :success?, output)
    assert_match(/^# tests 5$/, output)
    assert_match(/^# fail 0$/, output)
  end

  private

  def application(client:, origin: ORIGIN, authorization_policy: nil, html: "demo", **options)
    policy = authorization_policy || -> (token, _request) { "trusted-user" if token == APPLICATION_TOKEN }
    OpenAI::Examples::Realtime::WebRTCConversation::App.new(
      client: client,
      origin: origin,
      authorization_policy: policy,
      html: html,
      csrf_token: CSRF_TOKEN,
      **options
    )
  end

  def valid_headers
    {
      "host" => "127.0.0.1:4567",
      "origin" => ORIGIN,
      "authorization" => "Bearer #{APPLICATION_TOKEN}",
      "x-realtime-csrf" => CSRF_TOKEN
    }
  end

  def page_request
    request(method: "GET", path: "/", headers: {"host" => "127.0.0.1:4567"})
  end

  def token_request(overrides = {})
    request(headers: valid_headers.merge(overrides).compact)
  end

  def request(method: "POST", path: "/token", headers: {"host" => "127.0.0.1:4567"})
    ::Protocol::HTTP::Request[method, path, headers]
  end

  def with_loopback_server(client: Minitest::Mock.new, logs: nil)
    reserved = TCPServer.new("127.0.0.1", 0)
    port = reserved.local_address.ip_port
    reserved.close
    origin = "http://127.0.0.1:#{port}"
    app = application(client: client, origin: origin)
    endpoint = ::Async::HTTP::Endpoint.parse(origin)
    protocol = OpenAI::Examples::Realtime::WebRTCConversation::StrictHTTPProtocol
    server = ::Async::HTTP::Server.new(app, endpoint, protocol: protocol)

    Sync do |task|
      task.with_timeout(5) do
        original_logger = ::Console.logger
        ::Console.logger = ::Console::Logger.new(logs) if logs
        server_task = task.async { server.run.wait }
        yield(port)
      ensure
        server_task&.stop
        ::Console.logger = original_logger if logs
      end
    end
  end

  def raw_http(port, message)
    socket = TCPSocket.new("127.0.0.1", port)
    socket.write(message)
    socket.read
  ensure
    socket&.close
  end

  def assert_forbidden(response)
    assert_equal(403, response.status)
    assert_equal("Forbidden\n", response.read)
    assert_security_headers(response)
  end

  def assert_security_headers(response)
    assert_equal("no-store", response.headers["cache-control"].to_s)
    assert_equal("no-referrer", response.headers["referrer-policy"].to_s)
    assert_equal("nosniff", response.headers["x-content-type-options"].to_s)
    assert_equal("same-origin", response.headers["cross-origin-resource-policy"].to_s)
    assert_equal("microphone=(self)", response.headers["permissions-policy"].to_s)
    assert_includes(response.headers["content-security-policy"].to_s, "frame-ancestors 'none'")
  end

  def assert_raw_security_headers(response)
    assert_includes(response.downcase, "cache-control: no-store\r\n")
    assert_includes(response.downcase, "referrer-policy: no-referrer\r\n")
    assert_includes(response.downcase, "x-content-type-options: nosniff\r\n")
    assert_includes(response.downcase, "cross-origin-resource-policy: same-origin\r\n")
    assert_includes(response.downcase, "permissions-policy: microphone=(self)\r\n")
    assert_includes(response.downcase, "content-security-policy: default-src 'none'; frame-ancestors 'none'\r\n")
  end
end
