# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ResponsesWebSocketErrorsTest < Minitest::Test
  def test_connection_errors_drop_credentials_and_query_without_mutating_url
    url = URI("wss://user:secret@example.com/v1/responses?token=sensitive#fragment-secret")
    original = url.to_s

    error = OpenAI::Errors::ResponsesConnectionError.new(url: url)

    assert_equal("wss://example.com/v1/responses", error.url.to_s)
    assert_equal(original, url.to_s)
    refute_includes(error.full_message, "sensitive")
    refute_includes(error.url.to_s, "fragment-secret")
    assert_nil(error.cause)
  end

  def test_shared_transport_does_not_retain_a_suppressed_responses_cause
    secret = "synthetic-private-close-reason"
    connection = Object.new
    connection.define_singleton_method(:read) { raise IOError, secret }
    error_factory = lambda do |url:, **_options|
      OpenAI::Errors::ResponsesConnectionError.new(url: url)
    end

    socket = OpenAI::WebSocket::AsyncWebSocketTransport::Socket.new(
      connection,
      url: URI("wss://example.com/v1/responses"),
      error_factory: error_factory
    )

    error = assert_raises(OpenAI::Errors::ResponsesConnectionError) { socket.read }

    assert_nil(error.cause)
    refute_includes(error.full_message, secret)
  end
end
