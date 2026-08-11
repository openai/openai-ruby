# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::RawResponseTransportTest < Minitest::Test
  class StubHTTPClient < OpenAI::HTTPClient
    def initialize(&execute)
      super()
      @execute = execute
    end

    def execute(request) = @execute.call(request)
  end

  class CloseableBody
    include Enumerable

    attr_reader :close_count

    def initialize(*chunks)
      @chunks = chunks
      @close_count = 0
    end

    def close = (@close_count += 1)

    def each(&block)
      @chunks.each(&block)
    end
  end

  def test_raw_request_buffers_and_parses_through_the_standard_response_path
    source = CloseableBody.new(
      '{"id":"gpt-test",',
      '"created":1,"object":"model","owned_by":"openai"}'
    )
    http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"Content-Type" => "application/json", "X-Request-ID" => "req_raw"},
        body: source
      )
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    response = client.raw_request(
      method: :get,
      path: "models/gpt-test",
      model: OpenAI::Model,
      security: {bearer_auth: true}
    )

    assert_instance_of(OpenAI::RawResponse, response)
    assert_equal("req_raw", response.request_id)
    assert_equal(1, source.close_count)
    assert_equal(response.body, response.read)
    refute_same(response.body, response.read)
    assert_raises(FrozenError) { response.headers["x-test"] = "value" }
    assert_raises(FrozenError) { response.headers["x-request-id"].replace("changed") }

    model = response.parse
    assert_instance_of(OpenAI::Model, model)
    assert_equal("gpt-test", model.id)
    assert_equal("req_raw", model._request_id)
  end

  def test_raw_request_uses_the_standard_retry_policy
    attempts = 0
    http_client = StubHTTPClient.new do |_request|
      attempts += 1
      if attempts == 1
        OpenAI::HTTPClient::Response.new(
          status: 500,
          headers: {"Content-Type" => "application/json"},
          body: '{"error":{"message":"retry"}}'
        )
      else
        OpenAI::HTTPClient::Response.new(
          status: 200,
          headers: {"Content-Type" => "application/json"},
          body: '{"ok":true}'
        )
      end
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client,
      initial_retry_delay: 0,
      max_retries: 1,
      max_retry_delay: 0
    )

    response = client.raw_request(method: :get, path: "probe")

    assert_equal(2, attempts)
    assert_equal({ok: true}, response.parse)
  end

  def test_raw_request_uses_the_standard_status_errors
    http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 400,
        headers: {"Content-Type" => "application/json", "X-Request-ID" => "req_error"},
        body: '{"error":{"message":"invalid"}}'
      )
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    error = assert_raises(OpenAI::Errors::BadRequestError) do
      client.raw_request(method: :get, path: "probe")
    end

    assert_equal("req_error", error.request_id)
  end

  def test_raw_request_buffers_and_replays_streaming_responses
    body = "data: {\"value\":1}\n\ndata: [DONE]\n\n"
    http_client = StubHTTPClient.new do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"Content-Type" => "text/event-stream", "X-Request-ID" => "req_stream"},
        body: body
      )
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    response = client.raw_request(
      method: :get,
      path: "probe",
      stream: OpenAI::Internal::Stream
    )
    stream = response.parse

    assert_equal(body, response.read)
    assert_equal("req_stream", response.request_id)
    assert_equal(200, stream.status)
    assert_equal("req_stream", stream.headers["x-request-id"])
    assert_equal([{value: 1}], stream.to_a)
  end
end
