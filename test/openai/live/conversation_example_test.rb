# frozen_string_literal: true

require "async/http/client"
require "protocol/http/request"
require "socket"
require "async/queue"

require_relative "../test_helper"
require_relative "../../../examples/live/conversation"

class OpenAI::Test::LiveConversationExampleTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def setup
    super
    WebMock.enable!
    WebMock.disable_net_connect!(allow_localhost: true)
    @client = OpenAI::Client.new(api_key: "fake-example-key")
    @app = OpenAI::Examples::Live::Conversation.new(client: @client, port: 4567)
  end

  def teardown
    WebMock.reset!
    WebMock.disable!
    super
  end

  def test_creation_uses_generated_live_resource_with_server_owned_policy
    sent = nil
    stub_request(:post, "https://api.openai.com/v1/live/sessions")
      .with do |request|
        sent = JSON.parse(request.body)
        request.headers["Authorization"] == "Bearer fake-example-key"
      end
      .to_return_json(body: {session: {id: "live_fake"}, transport: {type: "webrtc", sdp: "fake answer"}})

    response = Sync { @app.call(request) }
    assert_equal(201, response.status)
    assert_equal("fake offer", sent.dig("transport", "sdp"))
    assert_equal("gpt-live-1", sent.dig("session", "model"))
    assert_equal(false, sent.dig("session", "store"))
    assert_equal("responses", sent.dig("session", "delegation", "type"))
    assert_equal([], sent.dig("session", "delegation", "responses", "tools"))
    assert_equal(["session.close"], sent.dig("session", "client", "data_channel", "allowed_client_events"))
    assert_nil(sent.dig("session", "audio", "format"))
    assert_equal("live_fake", JSON.parse(response.read).dig("session", "id"))
    assert_equal(["no-store"], response.headers["cache-control"])
  end

  def test_foreign_missing_or_duplicate_origin_and_host_cannot_create_sessions
    [nil, "null", "http://evil.example", "http://127.0.0.1:4567, http://evil.example"].each do |origin|
      assert_equal(403, Sync { @app.call(request(origin: origin)) }.status)
    end

    ["evil.example", "localhost:4567", "127.0.0.1:9999"].each do |authority|
      assert_equal(403, Sync { @app.call(request(authority: authority)) }.status)
    end

    assert_not_requested(:post, "https://api.openai.com/v1/live/sessions")
  end

  def test_bad_method_content_type_empty_body_and_paths_do_not_create_sessions
    assert_equal(405, Sync { @app.call(request(method: "GET")) }.status)
    assert_equal(415, Sync { @app.call(request(content_type: "text/plain")) }.status)
    assert_equal(400, Sync { @app.call(request(body: "")) }.status)
    assert_equal(404, Sync { @app.call(request(path: "/../webrtc.rb", method: "GET")) }.status)
    assert_not_requested(:post, "https://api.openai.com/v1/live/sessions")
  end

  def test_uncertain_creation_is_not_retried_and_errors_are_sanitized
    stub = stub_request(:post, "https://api.openai.com/v1/live/sessions")
      .to_return_json(status: 500, body: {error: {message: "private example SDP and key", type: "server_error"}})
    response = Sync { @app.call(request) }
    assert_equal(502, response.status)
    refute_includes(response.read, "private example")
    assert_requested(stub, times: 1)
  end

  def test_second_creation_is_rejected_while_first_waits_and_cancellation_releases_slot
    Sync do |task|
      entered = Async::Queue.new
      waiting = Async::Queue.new
      @client.live.stub(
        :create,
        -> (_params) {
          entered.enqueue(true)
          waiting.dequeue
        }
      ) do
        first = task.async { @app.call(request) }
        entered.dequeue
        assert_equal(409, @app.call(request).status)
        first.stop
      end

      assert_equal(400, @app.call(request(body: "")).status)
    end
  end

  def test_local_http_server_serves_assets_and_checks_wire_authority
    port = TCPServer.open("127.0.0.1", 0) { |socket| socket.addr[1] }
    endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:#{port}")
    app = OpenAI::Examples::Live::Conversation.new(client: @client, port: port)
    Sync do |task|
      server = task.async { Async::HTTP::Server.new(app, endpoint).run.wait }
      http = Async::HTTP::Client.new(endpoint)
      response = http.get("/")
      assert_equal(200, response.status)
      assert_includes(response.read, "Start conversation")
      assert_includes(response.headers["content-security-policy"].join, "frame-ancestors 'none'")
      denied = http.post(
        "/session",
        {"origin" => "http://evil.example", "content-type" => "application/sdp"},
        ["fake offer"]
      )
      assert_equal(403, denied.status)
      denied.finish
    ensure
      http&.close
      server&.stop
    end
  end

  private def request(
    authority: "127.0.0.1:4567",
    origin: "http://127.0.0.1:4567",
    method: "POST",
    content_type: "application/sdp",
    body: "fake offer",
    path: "/session"
  )
    headers = {"content-type" => content_type}
    headers["origin"] = origin if origin
    result = Protocol::HTTP::Request[method, path, headers, [body]]
    result.authority = authority
    result
  end
end
