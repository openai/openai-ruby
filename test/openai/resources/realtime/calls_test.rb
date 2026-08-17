# frozen_string_literal: true

require_relative "../../test_helper"
require "async/queue"

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

  class MalformedLocationHTTPClient < OpenAI::HTTPClient
    def execute(_request)
      OpenAI::HTTPClient::Response.new(
        status: 201,
        headers: {
          "Content-Type" => "application/sdp",
          "Location" => "http://[malformed",
          "X-Request-ID" => "req_malformed_location"
        },
        body: "usable-answer-sdp"
      )
    end
  end

  class SequenceHTTPClient < OpenAI::HTTPClient
    attr_reader :requests

    def initialize(*responses)
      super()
      @responses = responses
      @requests = []
    end

    def execute(request)
      @requests << request
      @responses.shift
    end
  end

  class FailingBody
    include Enumerable

    attr_reader :closed

    def initialize = @closed = false

    def each
      return enum_for(__method__) unless block_given?

      yield("partial-answer")
      raise IOError, "SDP read failed"
    end

    def close = @closed = true
  end

  class BlockingBody
    include Enumerable

    attr_reader :closed

    def initialize(started)
      @started = started
      @closed = false
    end

    def each
      return enum_for(__method__) unless block_given?

      @started.enqueue(true)
      Kernel.sleep(3_600)
    end

    def close = @closed = true
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

  def test_create_ignores_a_malformed_optional_location_header
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: MalformedLocationHTTPClient.new
    )

    response = client.realtime.calls.create(sdp: "offer-sdp")

    assert_equal("usable-answer-sdp", response.sdp)
    assert_nil(response.call_id)
    assert_equal("req_malformed_location", response._request_id)
  end

  def test_create_ignores_parseable_locations_that_do_not_identify_a_call
    locations = ["/v1/realtime/calls", "/somewhere/else"]
    responses = locations.map do |location|
      OpenAI::HTTPClient::Response.new(
        status: 201,
        headers: {"content-type" => "application/sdp", "location" => location},
        body: "usable-answer-sdp"
      )
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: SequenceHTTPClient.new(*responses)
    )

    locations.each do
      response = client.realtime.calls.create(sdp: "offer-sdp")

      assert_nil(response.call_id)
      assert_equal("usable-answer-sdp", response.sdp)
    end
  end

  def test_create_does_not_retry_by_default
    http_client = SequenceHTTPClient.new(
      OpenAI::HTTPClient::Response.new(
        status: 500,
        headers: {"content-type" => "application/json"},
        body: JSON.generate(error: {message: "try once", type: "server_error"})
      ),
      OpenAI::HTTPClient::Response.new(
        status: 201,
        headers: {"content-type" => "application/sdp"},
        body: "unexpected retry"
      )
    )
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    assert_raises(OpenAI::Errors::InternalServerError) do
      client.realtime.calls.create(sdp: "offer-sdp")
    end

    assert_equal(1, http_client.requests.length)
  end

  def test_create_treats_a_nil_retry_override_as_the_no_retry_default
    http_client = SequenceHTTPClient.new(
      OpenAI::HTTPClient::Response.new(
        status: 500,
        headers: {"content-type" => "application/json"},
        body: JSON.generate(error: {message: "try once", type: "server_error"})
      ),
      OpenAI::HTTPClient::Response.new(
        status: 201,
        headers: {"content-type" => "application/sdp"},
        body: "unexpected retry"
      )
    )
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client,
      max_retries: 1
    )

    assert_raises(OpenAI::Errors::InternalServerError) do
      client.realtime.calls.create(sdp: "offer-sdp", request_options: {max_retries: nil})
    end

    assert_equal(1, http_client.requests.length)
  end

  def test_create_hangs_up_an_allocated_call_when_reading_the_sdp_fails
    failing_body = FailingBody.new
    http_client = SequenceHTTPClient.new(
      OpenAI::HTTPClient::Response.new(
        status: 201,
        headers: {
          "content-type" => "application/sdp",
          "location" => "/v1/realtime/calls/rtc_orphan"
        },
        body: failing_body
      ),
      OpenAI::HTTPClient::Response.new(
        status: 500,
        headers: {"content-type" => "application/json"},
        body: JSON.generate(error: {message: "temporary hangup failure", type: "server_error"})
      ),
      OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    )
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )

    error = assert_raises(IOError) do
      client.realtime.calls.create(
        sdp: "offer-sdp",
        request_options: {
          extra_headers: {"x-routing-key" => "tenant_123"},
          extra_query: {"route" => "primary"},
          timeout: 0.125
        }
      )
    end

    assert_equal("SDP read failed", error.message)
    assert_equal(
      [
        "/v1/realtime/calls",
        "/v1/realtime/calls/rtc_orphan/hangup",
        "/v1/realtime/calls/rtc_orphan/hangup"
      ],
      http_client.requests.map { _1.url.path }
    )
    assert_equal(["route=primary"] * 3, http_client.requests.map { _1.url.query })
    assert_equal(
      ["tenant_123"] * 3,
      http_client.requests.map { _1.headers.fetch("x-routing-key") }
    )
    assert_equal([0.125] * 3, http_client.requests.map(&:timeout))
    assert(failing_body.closed)
  end

  def test_create_hangs_up_an_allocated_call_when_the_async_task_is_cancelled
    started = Async::Queue.new
    blocking_body = BlockingBody.new(started)
    http_client = SequenceHTTPClient.new(
      OpenAI::HTTPClient::Response.new(
        status: 201,
        headers: {
          "content-type" => "application/sdp",
          "location" => "/v1/realtime/calls/rtc_cancelled"
        },
        body: blocking_body
      ),
      OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    )
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    Sync do |task|
      create = task.async { client.realtime.calls.create(sdp: "offer-sdp") }
      started.dequeue
      create.stop
    end

    assert_equal(
      ["/v1/realtime/calls", "/v1/realtime/calls/rtc_cancelled/hangup"],
      http_client.requests.map { _1.url.path }
    )
    assert(blocking_body.closed)
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
