# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Realtime::CallsTest < OpenAI::Test::ResourceTest
  class CapturingLogger
    attr_reader :events

    def initialize = @events = []

    def debug(message) = @events << [:debug, message]
    def info(message) = @events << [:info, message]
    def warn(message) = @events << [:warn, message]
    def error(message) = @events << [:error, message]
  end

  class StubHTTPClient < OpenAI::HTTPClient
    attr_reader :request

    def execute(request)
      @request = request
      OpenAI::HTTPClient::Response.new(
        status: 201,
        headers: {
          "Content-Type" => "application/sdp",
          "Location" => "/v1/realtime/calls/rtc_123",
          "X-Request-ID" => "req_realtime_call"
        },
        body: "answer-sdp"
      )
    end
  end

  def test_create_with_an_sdp_offer
    http_client = StubHTTPClient.new
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    response = client.realtime.calls.create(sdp: "offer-sdp")

    assert_equal("answer-sdp", response.sdp)
    assert_equal("rtc_123", response.call_id)
    assert_equal("req_realtime_call", response._request_id)
    assert_equal(201, response.last_response.status)
    assert_equal("/v1/realtime/calls/rtc_123", response.headers.fetch("location"))
    assert_equal(:post, http_client.request.method)
    assert_equal("https://example.com/v1/realtime/calls", http_client.request.url.to_s)
    assert_equal("application/sdp", http_client.request.headers.fetch("content-type"))
    assert_equal("offer-sdp", http_client.request.body)
  end

  def test_create_with_session_configuration_uses_typed_multipart_parts
    http_client = StubHTTPClient.new
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    client.realtime.calls.create(
      sdp: "offer-sdp",
      session: {type: :realtime, model: "gpt-realtime"}
    )

    content_type = http_client.request.headers.fetch("content-type")
    body = http_client.request.body.to_a.join

    assert_match(%r{\Amultipart/form-data; boundary=}, content_type)
    assert_includes(body, "name=\"sdp\"\r\nContent-Type: application/sdp\r\n\r\noffer-sdp")
    assert_includes(body, "name=\"session\"\r\nContent-Type: application/json")
    assert_includes(body, JSON.generate(type: :realtime, model: "gpt-realtime"))
    refute_includes(body, "filename=")
  end

  def test_create_preserves_request_observability_for_raw_sdp_responses
    logger = CapturingLogger.new
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: StubHTTPClient.new,
      logger: logger,
      log_level: :debug
    )

    response = client.realtime.calls.create(sdp: "offer-sdp")

    assert_equal("answer-sdp", response.sdp)
    log = logger.events.map(&:last).join("\n")
    assert_includes(log, "request complete")
    assert_includes(log, "request_id=req_realtime_call")
    assert_includes(log, "response body")
  end

  def test_accept_required_params
    response = @openai.realtime.calls.accept("call_id", type: :realtime)

    assert_pattern do
      response => nil
    end
  end

  def test_hangup
    response = @openai.realtime.calls.hangup("call_id")

    assert_pattern do
      response => nil
    end
  end

  def test_refer_required_params
    response = @openai.realtime.calls.refer("call_id", target_uri: "tel:+14155550123")

    assert_pattern do
      response => nil
    end
  end

  def test_reject
    response = @openai.realtime.calls.reject("call_id")

    assert_pattern do
      response => nil
    end
  end
end
