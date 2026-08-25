# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::RealtimeErrorsTest < Minitest::Test
  def test_connection_errors_preserve_ordinary_url_identity
    urls = [
      URI("wss://example.com/v1/realtime"),
      URI("wss://example.com/v1/realtime?model=gpt-realtime-2.1")
    ]

    urls.each do |url|
      error = OpenAI::Errors::RealtimeConnectionError.new(url: url)

      assert_same(url, error.url)
    end
  end

  def test_connection_errors_redact_encoded_and_repeated_call_ids
    original = URI(
      "wss://example.com/v1/realtime?" \
        "call%5Fid=rtc_encoded&safe=hello%20world&call_id=rtc_repeated&"
    )
    original_value = original.to_s

    error = OpenAI::Errors::RealtimeConnectionError.new(url: original)

    assert_equal(
      "wss://example.com/v1/realtime?" \
        "call%5Fid=[REDACTED]&safe=hello%20world&call_id=[REDACTED]&",
      error.url.to_s
    )
    assert_equal(original_value, original.to_s)
    refute_same(original, error.url)
    refute_includes(error.url.to_s, "rtc_encoded")
    refute_includes(error.url.to_s, "rtc_repeated")
  end

  def test_connection_errors_redact_empty_call_ids
    url = URI("wss://example.com/v1/realtime?call_id=&safe=visible")

    error = OpenAI::Errors::RealtimeConnectionError.new(url: url)

    assert_equal(
      "wss://example.com/v1/realtime?call_id=[REDACTED]&safe=visible",
      error.url.to_s
    )
    assert_equal("", URI.decode_www_form(url.query).assoc("call_id").last)
  end

  def test_connection_errors_drop_malformed_queries_without_mutating_the_url
    url = URI("wss://example.com/v1/realtime?call_id=rtc_sensitive")
    error = nil

    url.stub(:query, "call_id=rtc_sensitive&bad%ZZ=value") do
      error = OpenAI::Errors::RealtimeConnectionError.new(url: url)
    end

    assert_equal("wss://example.com/v1/realtime", error.url.to_s)
    assert_equal("call_id=rtc_sensitive", url.query)
    refute_includes(error.url.to_s, "rtc_sensitive")
  end
end
