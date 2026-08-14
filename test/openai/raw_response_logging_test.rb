# frozen_string_literal: true

require_relative "logging_test_case"

class RawResponseLoggingTest < OpenAILoggingTestCase
  def test_raw_response_completion_is_logged_only_after_body_consumption
    logger = CapturingLogger.new
    source = CloseableBody.new("answer-sdp")
    http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/sdp", "x-request-id" => "req_raw"},
        body: source
      )
    end
    client = diagnostic_client(http_client: http_client, logger: logger, log_level: :info)

    response = client.request_raw(method: :post, path: "realtime/calls")

    assert_empty(logger.events)
    assert_equal(["answer-sdp"], response.body.to_a)
    assert_equal(1, source.close_count)
    assert_equal([:info], logger.events.map(&:first))
    assert_includes(logger.events.fetch(0).fetch(1), "request complete")
  end

  def test_raw_response_body_failure_logs_an_error_without_a_success_event
    logger = CapturingLogger.new
    failure = OpenAI::Errors::APIConnectionError.new(
      url: URI("https://example.com/v1/realtime/calls")
    )
    source = FailingBody.new(failure)
    http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/sdp"},
        body: source
      )
    end
    client = diagnostic_client(http_client: http_client, logger: logger, log_level: :info)
    response = client.request_raw(method: :post, path: "realtime/calls")

    assert_empty(logger.events)
    error = assert_raises(OpenAI::Errors::APIConnectionError) { response.body.to_a }

    assert_same(failure, error)
    assert_equal(1, source.close_count)
    assert_equal([:error], logger.events.map(&:first))
    assert_includes(logger.events.fetch(0).fetch(1), "request failed")
    refute_includes(logger.events.fetch(0).fetch(1), "request complete")
  end

  def test_closing_a_partially_consumed_raw_response_closes_its_source
    logger = CapturingLogger.new
    source = CloseableBody.new("first", "second")
    http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/sdp"},
        body: source
      )
    end
    client = diagnostic_client(http_client: http_client, logger: logger, log_level: :info)
    response = client.request_raw(method: :post, path: "realtime/calls")

    assert_equal("first", response.body.first)

    assert_equal(1, source.close_count)
    assert_empty(logger.events)
  end
end
