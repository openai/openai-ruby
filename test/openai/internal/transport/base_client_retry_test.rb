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
    assert_equal(0, client.calculated_retry_delay({"retry-after" => "5"}))
  end

  def test_negative_retry_after_values_fall_back_to_initial_delay
    @client.stub(:rand, 0.0) do
      assert_equal(0.5, @client.calculated_retry_delay({"retry-after" => "-1"}))
      assert_equal(0.5, @client.calculated_retry_delay({"retry-after-ms" => "-1000"}))
    end
  end

  def test_non_finite_retry_after_values_fall_back_to_initial_delay
    @client.stub(:rand, 0.0) do
      assert_equal(0.5, @client.calculated_retry_delay({"retry-after" => "1e999"}))
      assert_equal(0.5, @client.calculated_retry_delay({"retry-after-ms" => "1e999"}))
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

  def test_retry_after_values_are_capped_at_configured_maximum
    client = RetryClient.new(api_key: "test-key", max_retry_delay: 2.5)

    assert_equal(2.5, client.calculated_retry_delay({"retry-after" => "1000000000"}))
    assert_equal(2.5, client.calculated_retry_delay({"retry-after-ms" => "1000000000000"}))
    assert_equal(2.5, client.calculated_retry_delay({"retry-after" => (Time.now + 60).httpdate}))
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
      @client.calculated_retry_delay({"retry-after-ms" => "1e999", "retry-after" => "3"})
    )
  end

  def test_zero_retry_after_remains_immediate
    assert_equal(0.0, @client.calculated_retry_delay({"retry-after" => "0"}))
    assert_equal(0.0, @client.calculated_retry_delay({"retry-after-ms" => "0"}))
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
