# frozen_string_literal: true

require_relative "../../test_helper"
require_relative "../../../../examples/realtime/browser/server"
require "stringio"

class OpenAI::Test::BrowserAppTest < Minitest::Test
  # These are concrete request/response protocol containers, not SDK doubles.
  Request = Struct.new(:request_method, :path, :body, :headers) do
    def [](key) = headers[key]
  end

  Response = Struct.new(:status, :body, :chunked, :headers) do
    def []=(key, value)
      headers[key] = value
    end
  end

  TOKEN = "fake-application-token-for-offline-tests"
  ID = "00000000-0000-4000-8000-000000000001"

  def setup
    @http = Minitest::Mock.new(Object.new)
    @now = 100
    @output = StringIO.new
    @http.stub(:respond_to?, true) do
      @client = OpenAI::Client.new(api_key: "fake-api-key", http_client: @http)
    end

    @app = OpenAI::Examples::Realtime::BrowserApp.new(
      client: @client,
      token: TOKEN,
      clock: -> { @now },
      output: @output
    )
  end

  def request(path, headers: {}, method: "POST", body: "fake opaque SDP")
    response = Response.new(200, nil, false, {})
    @app.service(
      Request.new(
        method,
        path,
        body,
        {
          "host" => "127.0.0.1:9292",
          "origin" => "http://127.0.0.1:9292",
          "authorization" => "Bearer #{TOKEN}",
          "content-type" => "application/sdp",
          "x-operation-id" => ID
        }.merge(headers)
      ),
      response
    )
    response
  end

  def create(location: "/v1/realtime/calls/rtc_fake_example", body: "fake answer")
    @http
      .expect(
        :execute,
        OpenAI::HTTPClient::Response.new(
          status: 201,
          headers: {"content-type" => "application/sdp", "location" => location}.compact,
          body: body
        )
      ) do |wire|
        wire.url.path == "/v1/realtime/calls" && wire.body.to_a.join.include?("fake opaque SDP")
      end

    request("/api/calls")
  end

  def expect_hangup(status: 200)
    @http.expect(:execute, OpenAI::HTTPClient::Response.new(status: status, headers: {}, body: "")) do |wire|
      wire.url.path == "/v1/realtime/calls/rtc_fake_example/hangup"
    end
  end

  def test_auth_origin_host_and_method_rejected_before_sdk
    [
      ["authorization", "Bearer invalid", 401],
      ["origin", "https://hostile.example", 403],
      ["origin", nil, 403],
      ["host", "hostile.example:9292", 403]
    ].each do |name, value, status|
      response = request("/api/secret", headers: {name => value})
      assert_equal(status, response.status)
      assert_equal("no-store", response.headers["Cache-Control"])
    end

    assert_equal(405, request("/api/secret", method: "GET").status)
    assert_mock(@http)
  end

  def test_assets_are_allowlisted_and_no_store
    response = request("/backend", method: "GET")
    assert_equal(200, response.status)
    assert_includes(response.body, "id=\"start\"")
    assert_includes(response.headers["Content-Security-Policy"], "frame-ancestors 'none'")
    assert_equal("no-store", response.headers["Cache-Control"])
    assert_equal(405, request("/server.rb", method: "GET").status)
  end

  def test_secret_uses_short_ttl_trusted_safety_identifier_and_no_create_retries
    @http
      .expect(
        :execute,
        OpenAI::HTTPClient::Response.new(
          status: 200,
          headers: {"content-type" => "application/json"},
          body: JSON.generate({value: "ek_fake", expires_at: 200, session: {type: "realtime"}})
        )
      ) do |wire|
        params = JSON.parse(wire.body)
        wire.url.path == "/v1/realtime/client_secrets" &&
          params.dig("expires_after", "seconds") == 30 &&
          wire.headers["openai-safety-identifier"] == Digest::SHA256.hexdigest(TOKEN)
      end

    response = request("/api/secret")
    assert_equal(200, response.status)
    assert_equal({"value" => "ek_fake"}, JSON.parse(response.body))
    assert_equal(429, request("/api/secret").status)
    @now += 40
    # Failed/lost token delivery allocated no backend call to hang up.
    @app.reap
    assert_mock(@http)
  end

  def test_ack_and_renew_keep_call_owned_until_explicit_stop
    response = create
    sink = StringIO.new
    response.body.call(sink)
    assert_equal({"sdp" => "fake answer"}, JSON.parse(sink.string))
    assert_equal(409, request("/api/renew").status)
    assert_equal(200, request("/api/ack").status)
    @now += 50
    @app.reap
    assert_equal(200, request("/api/renew").status)
    assert_equal(409, request("/api/calls").status)
    expect_hangup
    assert_equal(200, request("/api/stop").status)
    assert_equal(200, request("/api/stop").status)
    assert_mock(@http)
  end

  def test_lost_answer_without_ack_expires_even_if_http_write_succeeds
    response = create
    response.body.call(StringIO.new)
    @now += 21
    assert_equal(409, request("/api/ack").status)
    expect_hangup
    @app.reap
    assert_equal(404, request("/api/ack").status)
    assert_mock(@http)
  end

  def test_failed_answer_write_hangs_up
    response = create
    socket = Minitest::Mock.new
    socket.expect(:write, nil) { |_payload| raise IOError, "fake private payload" }
    expect_hangup
    assert_raises(IOError) { response.body.call(socket) }
    assert_equal(404, request("/api/ack").status)
    refute_includes(@output.string, "fake private payload")
    assert_mock(@http)
  end

  def test_hangup_failure_keeps_ownership_and_retries_on_timer
    create
    expect_hangup(status: 500)
    assert_equal(503, request("/api/stop").status)
    assert_equal(409, request("/api/ack").status)
    assert_equal(409, request("/api/calls").status)
    @now += 6
    expect_hangup
    @app.reap
    assert_equal(404, request("/api/ack").status)
    assert_mock(@http)
  end

  def test_wrong_operation_cannot_ack_or_stop_another_call
    create
    other = {"x-operation-id" => "00000000-0000-4000-8000-000000000002"}
    assert_equal(404, request("/api/ack", headers: other).status)
    assert_equal(200, request("/api/stop", headers: other).status)
    assert_equal(200, request("/api/ack").status)
    @now += 61
    expect_hangup
    @app.reap
    assert_mock(@http)
  end

  def test_missing_and_untrusted_locations_fail_without_guessing_hangup_target
    [nil, "https://hostile.example/v1/realtime/calls/rtc_fake_example", "/v1/realtime/calls/../bad"].each do |location|
      assert_equal(502, create(location: location).status)
      @now += 6
    end

    refute_includes(@output.string, "hostile.example")
    assert_mock(@http)
  end

  def test_sideband_failure_reclaims_known_call
    @app = OpenAI::Examples::Realtime::BrowserApp.new(
      client: @client,
      token: TOKEN,
      sideband: true,
      clock: -> { @now },
      output: @output
    )
    # Stub existing example boundary; no alternate sideband implementation.
    OpenAI::Examples::Realtime::Sideband.stub(:run, -> (**) { raise "fake sideband failure" }) do
      @http
        .expect(
          :execute,
          OpenAI::HTTPClient::Response.new(
            status: 201,
            headers: {"location" => "/v1/realtime/calls/rtc_fake_example"},
            body: "fake answer"
          )
        ) { |_wire| true }
      expect_hangup
      assert_equal(502, request("/api/calls").status)
    end

    assert_mock(@http)
  end

  def test_shutdown_reclaims_and_stops_new_operations
    create
    expect_hangup
    @app.shutdown
    assert_equal(503, request("/api/secret").status)
    assert_mock(@http)
  end
end
