# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::BaseClientRetryTest < Minitest::Test
  class RetryClient < OpenAI::Client
    def calculated_retry_delay(headers, retry_count: 0)
      retry_delay(headers, retry_count: retry_count)
    end
  end

  def setup
    super
    @client = RetryClient.new(api_key: "test-key")
  end

  def test_first_retry_uses_configured_initial_delay
    @client.stub(:rand, 0.0) do
      assert_equal(0.5, @client.calculated_retry_delay({}))
    end
  end

  def test_backoff_grows_exponentially_and_respects_configured_maximum
    client = RetryClient.new(api_key: "test-key", initial_retry_delay: 1.25, max_retry_delay: 3.0)

    client.stub(:rand, 0.0) do
      assert_equal(1.25, client.calculated_retry_delay({}, retry_count: 0))
      assert_equal(2.5, client.calculated_retry_delay({}, retry_count: 1))
      assert_equal(3.0, client.calculated_retry_delay({}, retry_count: 2))
      assert_equal(3.0, client.calculated_retry_delay({}, retry_count: 10))
    end
  end

  def test_jitter_is_applied_after_capping_exponential_backoff
    @client.stub(:rand, 1.0) do
      assert_equal(0.375, @client.calculated_retry_delay({}, retry_count: 0))
      assert_equal(6.0, @client.calculated_retry_delay({}, retry_count: 10))
    end
  end

  def test_zero_configured_backoff_remains_supported
    client = RetryClient.new(api_key: "test-key", initial_retry_delay: 0, max_retry_delay: 0)

    assert_equal(0, client.calculated_retry_delay({}))
    assert_equal(5, client.calculated_retry_delay({"retry-after" => "5"}))
  end

  def test_negative_retry_after_values_fall_back_to_initial_delay
    @client.stub(:rand, 0.0) do
      assert_equal(0.5, @client.calculated_retry_delay({"retry-after" => "-1"}))
      assert_equal(0.5, @client.calculated_retry_delay({"retry-after-ms" => "-1000"}))
    end
  end

  def test_literal_infinity_and_negative_overflow_fall_back_to_initial_delay
    @client.stub(:rand, 0.0) do
      %w[Infinity +Infinity -Infinity NaN -1e999].each do |value|
        assert_equal(0.5, @client.calculated_retry_delay({"retry-after" => value}))
        assert_equal(0.5, @client.calculated_retry_delay({"retry-after-ms" => value}))
      end
    end
  end

  def test_malformed_retry_after_values_fall_back_to_initial_delay
    @client.stub(:rand, 0.0) do
      assert_equal(0.5, @client.calculated_retry_delay({"retry-after" => "not a date"}))
      assert_equal(0.5, @client.calculated_retry_delay({"retry-after-ms" => "not a number"}))
    end
  end

  def test_expired_retry_after_date_falls_back_to_initial_delay
    expired = (Time.now - 60).httpdate

    @client.stub(:rand, 0.0) do
      assert_equal(0.5, @client.calculated_retry_delay({"retry-after" => expired}))
    end
  end

  def test_retry_after_values_preserve_the_server_minimum
    client = RetryClient.new(api_key: "test-key", max_retry_delay: 2.5)
    now = Time.at(1_700_000_000)
    previous_time = Thread.current.thread_variable_get(:time_now)
    Thread.current.thread_variable_set(:time_now, now)

    assert_equal(1_000_000_000, client.calculated_retry_delay({"retry-after" => "1000000000"}))
    assert_equal(1_000_000_000, client.calculated_retry_delay({"retry-after-ms" => "1000000000000"}))
    assert_equal(60, client.calculated_retry_delay({"retry-after" => (now + 60).httpdate}))
  ensure
    Thread.current.thread_variable_set(:time_now, previous_time)
  end

  def test_valid_millisecond_header_takes_precedence_over_retry_after
    assert_equal(
      1.25,
      @client.calculated_retry_delay({"retry-after-ms" => "1250", "retry-after" => "3"})
    )
  end

  def test_invalid_millisecond_header_falls_back_to_valid_retry_after
    assert_equal(
      3.0,
      @client.calculated_retry_delay({"retry-after-ms" => "-1000", "retry-after" => "3"})
    )
    assert_equal(
      3.0,
      @client.calculated_retry_delay({"retry-after-ms" => "-1e999", "retry-after" => "3"})
    )
  end

  def test_zero_retry_after_remains_immediate
    assert_equal(0.0, @client.calculated_retry_delay({"retry-after" => "0"}))
    assert_equal(0.0, @client.calculated_retry_delay({"retry-after-ms" => "0"}))
  end

  def test_retry_after_above_the_limit_preserves_the_original_error_without_retrying
    now = Time.at(1_700_000_000)
    previous_time = Thread.current.thread_variable_get(:time_now)
    Thread.current.thread_variable_set(:time_now, now)
    hints = [
      [{"retry-after" => "9"}, 8],
      [{"retry-after" => "90"}, 8],
      [{"retry-after" => "1e999"}, 8],
      [{"retry-after" => "1e999"}, Float::INFINITY],
      [{"retry-after-ms" => "1e999", "retry-after" => "0"}, Float::INFINITY],
      [{"retry-after" => "9" * 400}, 8],
      [{"retry-after-ms" => "1e999", "retry-after" => "0"}, 8],
      [{"retry-after-ms" => "9" * 400, "retry-after" => "0"}, 8],
      [{"retry-after-ms" => "9000", "retry-after" => "1"}, 8],
      [{"retry-after" => (now + 90).httpdate}, 8],
      [{"retry-after" => "90", "x-should-retry" => "true"}, 8],
      [{"retry-after" => "3"}, 2],
      [{"retry-after" => "1"}, 0]
    ]

    [429, 503].product(hints).each do |status, (hint, maximum)|
      type, code = status == 429 ? %w[rate_limit_error slow_down] : %w[service_unavailable_error server_is_overloaded]
      error_body = {error: {message: "try later", type: type, code: code}}
      headers = {"content-type" => "application/json", "x-request-id" => "req_fake", **hint}
      chunks = [JSON.generate(error_body)]
      body = Enumerator.new { |output| output << chunks.shift until chunks.empty? }
      response = OpenAI::HTTPClient::Response.new(
        status: status,
        headers: headers,
        body: body
      )
      http_client = Minitest::Mock.new(OpenAI::HTTPClient.new)
      http_client.expect(:execute, response, [OpenAI::HTTPClient::Request])
      events = []
      slept = []
      client = OpenAI::Client.new(
        api_key: "test-key",
        http_client: http_client,
        max_retry_delay: maximum,
        on_retry: -> (event) { events << event }
      )

      client.stub(:sleep, -> (delay) { slept << delay }) do
        error_class = status == 429 ? OpenAI::Errors::RateLimitError : OpenAI::Errors::InternalServerError
        error = assert_raises(error_class) { client.request(method: :get, path: "probe") }
        assert_equal(status, error.status)
        assert_equal(error_body, error.body)
        assert_equal(headers, error.headers)
        assert_equal("req_fake", error.request_id)
      end

      assert_mock(http_client)
      assert_empty(events)
      assert_empty(slept)
    end

  ensure
    Thread.current.thread_variable_set(:time_now, previous_time)
  end

  def test_retry_after_within_the_limit_waits_for_the_server_minimum
    hints = [
      [{"retry-after" => "8"}, 8, 8],
      [{"retry-after-ms" => "1250", "retry-after" => "90"}, 8, 1.25],
      [{"retry-after-ms" => "invalid", "retry-after" => "3"}, 8, 3],
      [{"retry-after" => "90"}, 120, 90],
      [{"retry-after" => "0"}, 0, 0],
      [{"retry-after" => " +2.5e0 "}, 8, 2.5],
      [{"retry-after" => "0x1p1"}, 8, 2],
      [{"retry-after" => "1_0"}, 12, 10],
      [{"retry-after-ms" => "1250", "retry-after" => "1e999"}, 8, 1.25],
      [{"retry-after-ms" => "Infinity", "retry-after" => "3"}, 8, 3],
      [{"retry-after-ms" => "-1e999", "retry-after" => "3"}, 8, 3]
    ]

    [429, 503].product(hints).each do |status, (headers, maximum, delay)|
      http_client = Minitest::Mock.new(OpenAI::HTTPClient.new)
      http_client.expect(
        :execute,
        OpenAI::HTTPClient::Response.new(status: status, headers: headers, body: ""),
        [OpenAI::HTTPClient::Request]
      )
      http_client.expect(
        :execute,
        OpenAI::HTTPClient::Response.new(
          status: 200,
          headers: {"content-type" => "application/json"},
          body: "{\"ok\":true}"
        ),
        [OpenAI::HTTPClient::Request]
      )
      events = []
      slept = []
      client = OpenAI::Client.new(
        api_key: "test-key",
        http_client: http_client,
        max_retries: 1,
        max_retry_delay: maximum,
        on_retry: -> (event) { events << event }
      )

      client.stub(:sleep, -> (seconds) { slept << seconds }) do
        assert_equal(true, client.request(method: :get, path: "probe")[:ok])
      end

      assert_mock(http_client)
      assert_equal([delay], slept)
      assert_equal([delay], events.map(&:delay))
    end
  end

  def test_negative_retry_after_retries_and_reports_actual_delay
    rate_limited = OpenAI::HTTPClient::Response.new(
      status: 429,
      headers: {"content-type" => "application/json", "retry-after" => "-1"},
      body: "{\"error\":\"rate limited\"}"
    )
    successful = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: "{\"ok\":true}"
    )
    http_client = Minitest::Mock.new(OpenAI::HTTPClient.new)
    http_client.expect(:execute, rate_limited, [OpenAI::HTTPClient::Request])
    http_client.expect(:execute, successful, [OpenAI::HTTPClient::Request])
    retry_events = []
    slept = []
    client = RetryClient.new(
      api_key: "test-key",
      http_client: http_client,
      max_retries: 1,
      on_retry: -> (event) { retry_events << event }
    )

    client.stub(:rand, 0.0) do
      client.stub(:sleep, -> (delay) { slept << delay }) do
        assert_equal(true, client.request(method: :get, path: "probe")[:ok])
      end
    end

    assert_mock(http_client)
    assert_equal([0.5], slept)
    assert_equal(1, retry_events.length)
    assert_equal(0.5, retry_events.fetch(0).delay)
    assert_equal(429, retry_events.fetch(0).status)
  end
end
