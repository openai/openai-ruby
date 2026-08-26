# frozen_string_literal: true

require_relative "connection_test_support"

class OpenAI::Test::RealtimeCallCreationTest < Minitest::Test
  include OpenAI::Test::RealtimeConnectionTestSupport

  def test_create_exposes_response_metadata_and_composes_with_sideband_and_hangup
    call_id = "rtc_generated_123"
    answer_sdp = "v=0\r\no=- generated answer\r\n"
    creation_response = OpenAI::HTTPClient::Response.new(
      status: 201,
      headers: {
        "Content-Type" => "application/sdp",
        "Location" => "/v1/realtime/calls/#{call_id}",
        "X-Request-ID" => "req_realtime_create"
      },
      body: answer_sdp
    )
    hangup_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    http = Minitest::Mock.new(Object.new)
    request_body = nil
    http.expect(:execute, creation_response) do |request|
      request_body = request.body.to_a.join
      request.url.path == "/v1/realtime/calls" &&
        request.headers.fetch("authorization") == "Bearer test-key" &&
        request.headers.fetch("accept") == "application/sdp"
    end

    http.expect(:execute, hangup_response) do |request|
      request.url.path == "/v1/realtime/calls/#{call_id}/hangup" &&
        request.headers.fetch("authorization") == "Bearer test-key"
    end

    configured = client(http_client: http)
    result = configured.realtime.calls.create(
      sdp: "v=0\r\no=- browser offer\r\n",
      session: {type: :realtime, model: "gpt-realtime-2.1"}
    )

    assert_instance_of(OpenAI::HTTPClient::Response, result)
    assert_equal(201, result.status)
    assert_equal("req_realtime_create", result.metadata.request_id)
    assert_equal("/v1/realtime/calls/#{call_id}", result.headers.fetch("location"))
    assert_equal(answer_sdp, result.body.to_a.join)
    assert_empty(result.body.to_a)
    assert_includes(request_body, "Content-Type: application/sdp")
    assert_includes(request_body, "Content-Type: application/json")
    assert_includes(request_body, "gpt-realtime-2.1")

    parsed_call_id = URI.parse(result.headers.fetch("location")).path.split("/").last
    socket = FakeSocket.new
    websocket = FakeTransport.new(socket)

    configured.realtime.connect_to_call(call_id: parsed_call_id, transport: websocket) do |connection|
      assert_instance_of(OpenAI::Realtime::SidebandConnection, connection)
    end

    configured.realtime.calls.hangup(parsed_call_id)

    assert_equal([["call_id", call_id]], URI.decode_www_form(websocket.open_args.fetch(:url).query))
    assert_predicate(socket, :closed?)
    assert_mock(http)
  end

  def test_create_preserves_a_valid_sdp_response_when_location_is_absent
    response = OpenAI::HTTPClient::Response.new(
      status: 201,
      headers: {"Content-Type" => "application/sdp"},
      body: "v=0\r\n"
    )
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, response) { |request| request.url.path == "/v1/realtime/calls" }

    result = client(http_client: http).realtime.calls.create(sdp: "v=0\r\n")

    assert_instance_of(OpenAI::HTTPClient::Response, result)
    assert_nil(result.headers["location"])
    assert_equal("v=0\r\n", result.body.to_a.join)
    assert_mock(http)
  end

  def test_create_releases_transport_resources_before_returning_the_response
    released = false
    source = OpenAI::Internal::Util.fused_enum(["v=0\r\n"]) { released = true }
    first_response = OpenAI::HTTPClient::Response.new(
      status: 201,
      headers: {"Content-Type" => "application/sdp"},
      body: source
    )
    second_response = OpenAI::HTTPClient::Response.new(
      status: 201,
      headers: {"Content-Type" => "application/sdp"},
      body: "v=0\r\no=- second answer\r\n"
    )
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, first_response) { |_request| true }
    http.expect(:execute, second_response) { |_request| released }
    configured = client(http_client: http)

    first = configured.realtime.calls.create(sdp: "v=0\r\n")

    assert(released, "the pooled connection must be returned before exposing the raw response")
    assert_raises(KeyError) { first.headers.fetch("location") }

    second = configured.realtime.calls.create(sdp: "v=0\r\n")

    assert_equal("v=0\r\n", first.body.to_a.join)
    assert_equal("v=0\r\no=- second answer\r\n", second.body.to_a.join)
    assert_mock(http)
  end

  def test_create_does_not_retry_a_call_allocation_by_default
    failed = OpenAI::HTTPClient::Response.new(
      status: 500,
      headers: {"Content-Type" => "application/json"},
      body: JSON.generate(error: {message: "fake transient failure"})
    )
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, failed) { |request| request.url.path == "/v1/realtime/calls" }

    error = assert_raises(OpenAI::Errors::InternalServerError) do
      client(http_client: http, initial_retry_delay: 0, max_retry_delay: 0)
        .realtime
        .calls
        .create(sdp: "v=0\r\n")
    end

    assert_equal(500, error.status)
    assert_mock(http)
  end

  def test_create_does_not_retry_an_ambiguous_connection_failure_by_default
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, nil) do |request|
      raise OpenAI::Errors::APIConnectionError.new(url: request.url)
    end

    assert_raises(OpenAI::Errors::APIConnectionError) do
      client(http_client: http, initial_retry_delay: 0, max_retry_delay: 0)
        .realtime
        .calls
        .create(sdp: "v=0\r\n")
    end
  end

  def test_create_allows_an_explicit_application_owned_retry_override
    failed = OpenAI::HTTPClient::Response.new(
      status: 500,
      headers: {"Content-Type" => "application/json"},
      body: JSON.generate(error: {message: "fake transient failure"})
    )
    succeeded = OpenAI::HTTPClient::Response.new(
      status: 201,
      headers: {"Content-Type" => "application/sdp"},
      body: "v=0\r\n"
    )
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, failed) { |request| request.url.path == "/v1/realtime/calls" }
    http.expect(:execute, succeeded) { |request| request.url.path == "/v1/realtime/calls" }

    result = client(http_client: http, initial_retry_delay: 0, max_retry_delay: 0)
      .realtime
      .calls
      .create(sdp: "v=0\r\n", request_options: {max_retries: 1})

    assert_instance_of(OpenAI::HTTPClient::Response, result)
    assert_equal("v=0\r\n", result.body.to_a.join)
    assert_mock(http)
  end

  def test_nil_retry_overrides_preserve_the_call_creation_default
    [
      {max_retries: nil},
      OpenAI::RequestOptions.new(max_retries: nil)
    ].each do |request_options|
      failed = OpenAI::HTTPClient::Response.new(
        status: 500,
        headers: {"Content-Type" => "application/json"},
        body: JSON.generate(error: {message: "fake transient failure"})
      )
      http = Minitest::Mock.new(Object.new)
      http.expect(:execute, failed) { |request| request.url.path == "/v1/realtime/calls" }

      error = assert_raises(OpenAI::Errors::InternalServerError) do
        client(http_client: http, initial_retry_delay: 0, max_retry_delay: 0)
          .realtime
          .calls
          .create(sdp: "v=0\r\n", request_options: request_options)
      end

      assert_equal(500, error.status)
      assert_mock(http)
    end
  end

  def test_existing_binary_downloads_continue_returning_stringio
    binary = "fake file\x00content".b
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"Content-Type" => "application/octet-stream"},
      body: binary
    )
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, response) do |request|
      request.url.path == "/v1/files/file_existing_123/content" &&
        request.headers.fetch("accept") == "application/binary"
    end

    result = client(http_client: http).files.content("file_existing_123")

    assert_instance_of(StringIO, result)
    assert_equal(binary, result.read)
    assert_mock(http)
  end
end
