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

  def test_create_consumes_and_closes_successful_responses_with_hostless_http_locations
    ["http:/foo", "https:/foo", "http:foo", "https:foo"].each do |location|
      released = false
      body = OpenAI::Internal::Util.fused_enum(["v=0\r\n"]) { released = true }
      response = OpenAI::HTTPClient::Response.new(
        status: 201,
        headers: {"Content-Type" => "application/sdp", "Location" => location},
        body: body
      )
      http = Minitest::Mock.new(Object.new)
      http.expect(:execute, response) { |request| request.url.path == "/v1/realtime/calls" }

      result = client(http_client: http).realtime.calls.create(sdp: "v=0\r\n")

      assert_instance_of(OpenAI::HTTPClient::Response, result)
      assert_equal(location, result.headers.fetch("location"))
      assert_equal("v=0\r\n", result.body.to_a.join)
      assert(released, "#{location.inspect} must not leak the transport response body")
      assert_mock(http)
    end
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

  def test_create_hangs_up_an_allocated_call_when_reading_its_answer_fails
    call_id = "rtc_interrupted_123"
    released = false
    creation_response = interrupted_call_response(location: "/v1/realtime/calls/#{call_id}") do
      released = true
    end

    hangup_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, creation_response) { |request| request.url.path == "/v1/realtime/calls" }
    http.expect(:execute, hangup_response) do |request|
      released && request.url.path == "/v1/realtime/calls/#{call_id}/hangup"
    end

    error = assert_raises(IOError) do
      client(http_client: http).realtime.calls.create(sdp: "v=0\r\n")
    end

    assert_equal("synthetic SDP response interrupted", error.message)
    assert(released, "the interrupted response must release its pooled connection before cleanup")
    assert_mock(http)
  end

  def test_create_preserves_routing_for_its_bounded_hangup
    call_id = "rtc_routed_123"
    creation_response = interrupted_call_response(
      location: "https://example.com/v1/realtime/calls/#{call_id}?location_only=ignored"
    )
    successful_hangup = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    expected_query = [["tenant", "fake-tenant"]]
    requests = []
    http = Minitest::Mock.new(Object.new)
    [creation_response, successful_hangup].each do |response|
      http.expect(:execute, response) do |request|
        requests << request
        true
      end
    end

    error = assert_raises(IOError) do
      client(http_client: http, max_retries: 1, initial_retry_delay: 0, max_retry_delay: 0)
        .realtime
        .calls
        .create(
          sdp: "v=0\r\n",
          request_options: {
            extra_headers: {
              "OpenAI-Organization" => "org_fake",
              "OpenAI-Project" => "proj_fake",
              "X-Routing" => "fake-route"
            },
            extra_query: {"tenant" => "fake-tenant"},
            timeout: 4.5,
            max_retries: 0
          }
        )
    end

    assert_equal("synthetic SDP response interrupted", error.message)
    assert_equal(2, requests.length)
    requests.each do |request|
      assert_equal(expected_query, URI.decode_www_form(request.url.query))
      assert_equal("Bearer test-key", request.headers.fetch("authorization"))
      assert_equal("org_fake", request.headers.fetch("openai-organization"))
      assert_equal("proj_fake", request.headers.fetch("openai-project"))
      assert_equal("fake-route", request.headers.fetch("x-routing"))
      assert_equal(4.5, request.timeout)
    end

    assert_equal("/v1/realtime/calls", requests.fetch(0).url.path)
    assert_equal("/v1/realtime/calls/#{call_id}/hangup", requests.fetch(1).url.path)
    assert_equal("0", requests.fetch(1).headers.fetch("x-stainless-retry-count"))
    assert_mock(http)
  end

  def test_create_hangs_up_calls_allocated_at_a_trusted_prepared_origin
    call_id = "rtc_prepared_origin_123"
    creation_response = interrupted_call_response(
      location: "https://prepared.example/v1/realtime/calls/#{call_id}"
    )
    hangup_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, creation_response) do |request|
      request.url.host == "prepared.example" && request.url.path == "/v1/realtime/calls"
    end

    http.expect(:execute, hangup_response) do |request|
      request.url.host == "prepared.example" &&
        request.url.path == "/v1/realtime/calls/#{call_id}/hangup"
    end

    prepared_client = Class.new(OpenAI::Client) do
      private def prepare_request(request, redirect_count:, retry_count:)
        prepared = super
        rewritten_url = prepared.fetch(:url).dup
        rewritten_url.host = "prepared.example"
        prepared.merge(url: rewritten_url)
      end
    end

    configured = prepared_client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http
    )

    error = assert_raises(IOError) do
      configured.realtime.calls.create(sdp: "v=0\r\n")
    end

    assert_equal("synthetic SDP response interrupted", error.message)
    assert_mock(http)
  end

  def test_interrupted_call_cleanup_uses_a_bounded_timeout_and_retry_budget
    call_id = "rtc_bounded_cleanup_123"
    creation_response = interrupted_call_response(location: "/v1/realtime/calls/#{call_id}")
    failed_hangup = OpenAI::HTTPClient::Response.new(
      status: 500,
      headers: {"Content-Type" => "application/json"},
      body: JSON.generate(error: {message: "fake cleanup failure"})
    )
    requests = []
    http = Minitest::Mock.new(Object.new)
    [creation_response, failed_hangup].each do |response|
      http.expect(:execute, response) do |request|
        requests << request
        true
      end
    end

    error = assert_raises(IOError) do
      client(http_client: http, timeout: nil, max_retries: 3, initial_retry_delay: 0, max_retry_delay: 0)
        .realtime
        .calls
        .create(sdp: "v=0\r\n")
    end

    assert_equal("synthetic SDP response interrupted", error.message)
    assert_equal(2, requests.length)
    assert_nil(requests.fetch(0).timeout)
    assert_operator(requests.fetch(1).timeout, :>, 0)
    assert_operator(requests.fetch(1).timeout, :<=, 5)
    assert_equal("/v1/realtime/calls/#{call_id}/hangup", requests.fetch(1).url.path)
    assert_mock(http)
  end

  def test_interrupted_call_cleanup_bounds_the_entire_operation_across_redirects
    call_id = "rtc_cleanup_deadline_123"
    creation_response = interrupted_call_response(location: "/v1/realtime/calls/#{call_id}")
    redirect = OpenAI::HTTPClient::Response.new(
      status: 307,
      headers: {"Location" => "/v1/realtime/calls/#{call_id}/hangup"},
      body: ""
    )
    requests = []
    cleanup_deadlines = []
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, creation_response) do |request|
      requests << request
      true
    end

    20.times do |attempt|
      http.expect(:execute, redirect) do |request|
        requests << request
        raise Timeout::Error if attempt == 2

        true
      end
    end

    original_timeout = Timeout.method(:timeout)
    test_thread = Thread.current
    deadline = lambda do |duration, *arguments, &operation|
      unless Thread.current == test_thread
        next original_timeout.call(duration, *arguments, &operation)
      end

      cleanup_deadlines << duration
      operation.call
    end

    error = Timeout.stub(:timeout, deadline) do
      assert_raises(IOError) do
        client(http_client: http, timeout: 0.025).realtime.calls.create(sdp: "v=0\r\n")
      end
    end

    assert_equal("synthetic SDP response interrupted", error.message)
    assert_equal([0.025], cleanup_deadlines)
    assert_equal([0.025, 0.025, 0.025], requests.drop(1).map(&:timeout))
  end

  def test_interrupted_call_cleanup_uses_a_positive_deadline_for_zero_caller_timeouts
    call_id = "rtc_zero_timeout_cleanup_123"
    creation_response = interrupted_call_response(location: "/v1/realtime/calls/#{call_id}")
    hangup_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    requests = []
    http = Minitest::Mock.new(Object.new)
    [creation_response, hangup_response].each do |response|
      http.expect(:execute, response) do |request|
        requests << request
        true
      end
    end

    error = assert_raises(IOError) do
      client(http_client: http, timeout: 0).realtime.calls.create(sdp: "v=0\r\n")
    end

    assert_equal("synthetic SDP response interrupted", error.message)
    assert_equal(0, requests.fetch(0).timeout)
    assert_operator(requests.fetch(1).timeout, :>, 0)
    assert_operator(requests.fetch(1).timeout, :<=, 5)
    assert_mock(http)
  end

  def test_create_preserves_cancellation_and_hangs_up_when_closing_the_response_fails
    call_id = "rtc_close_failure_123"
    cancellation = Async::Stop.new("synthetic response logging cancelled")
    body = OpenAI::Internal::Util.fused_enum(["v=0\r\n"]) do
      raise IOError, "synthetic response close failed"
    end

    response = OpenAI::HTTPClient::Response.new(
      status: 201,
      headers: {
        "Content-Type" => "application/sdp",
        "Location" => "/v1/realtime/calls/#{call_id}"
      },
      body: body
    )
    hangup_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, response) { |request| request.url.path == "/v1/realtime/calls" }
    http.expect(:execute, hangup_response) do |request|
      request.url.path == "/v1/realtime/calls/#{call_id}/hangup"
    end

    logger = Logger.new(StringIO.new)
    log_response = lambda do |message|
      raise cancellation if message.include?("response received") && message.include?("status=201")
    end

    logger.stub(:debug, log_response) do
      error = assert_raises(Async::Stop) do
        client(http_client: http, logger: logger, log_level: :debug)
          .realtime
          .calls
          .create(sdp: "v=0\r\n")
      end

      assert_same(cancellation, error)
    end

    assert_mock(http)
  end

  def test_create_preserves_the_original_failure_when_hangup_fails
    call_id = "rtc_cleanup_failure_123"
    creation_response = interrupted_call_response(location: "/v1/realtime/calls/#{call_id}")
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, creation_response) { |request| request.url.path == "/v1/realtime/calls" }
    http.expect(:execute, nil) do |request|
      raise "synthetic hangup failure" if request.url.path == "/v1/realtime/calls/#{call_id}/hangup"
    end

    error = assert_raises(IOError) do
      client(http_client: http).realtime.calls.create(sdp: "v=0\r\n")
    end

    assert_equal("synthetic SDP response interrupted", error.message)
    assert_mock(http)
  end

  def test_create_hangs_up_an_allocated_call_when_its_async_task_is_cancelled
    call_id = "rtc_cancelled_123"
    cancellation = Async::Stop.new("synthetic SDP response cancelled")
    creation_response = interrupted_call_response(
      location: "/v1/realtime/calls/#{call_id}",
      exception: cancellation
    )
    hangup_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, creation_response) { |request| request.url.path == "/v1/realtime/calls" }
    http.expect(:execute, hangup_response) do |request|
      request.url.path == "/v1/realtime/calls/#{call_id}/hangup" &&
        Async::Task.current.stop_deferred?
    end

    Sync do
      error = assert_raises(Async::Stop) do
        client(http_client: http).realtime.calls.create(sdp: "v=0\r\n")
      end

      assert_same(cancellation, error)
    end

    assert_mock(http)
  end

  def test_create_supports_legacy_async_tasks_that_only_defer_stop
    call_id = "rtc_legacy_async_123"
    response = interrupted_call_response(location: "/v1/realtime/calls/#{call_id}")
    hangup_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, response) { |request| request.url.path == "/v1/realtime/calls" }
    http.expect(:execute, hangup_response) do |request|
      request.url.path == "/v1/realtime/calls/#{call_id}/hangup"
    end

    legacy_task = Minitest::Mock.new(Object.new)
    legacy_task.expect(:defer_stop, nil) do |&cleanup|
      cleanup.call
      true
    end

    Async::Task.stub(:current?, legacy_task) do
      error = assert_raises(IOError) do
        client(http_client: http).realtime.calls.create(sdp: "v=0\r\n")
      end

      assert_equal("synthetic SDP response interrupted", error.message)
    end

    assert_mock(legacy_task)
    assert_mock(http)
  end

  def test_create_preserves_the_original_failure_when_cancellation_arrives_during_hangup
    call_id = "rtc_cleanup_cancelled_123"
    response = interrupted_call_response(location: "/v1/realtime/calls/#{call_id}")
    hangup_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, response) { |request| request.url.path == "/v1/realtime/calls" }
    http.expect(:execute, hangup_response) do |request|
      Async::Task.current.stop
      request.url.path == "/v1/realtime/calls/#{call_id}/hangup"
    end

    Sync do
      error = assert_raises(IOError) do
        client(http_client: http).realtime.calls.create(sdp: "v=0\r\n")
      end

      assert_equal("synthetic SDP response interrupted", error.message)
    end

    assert_mock(http)
  end

  def test_create_preserves_the_original_failure_when_hangup_is_cancelled_without_an_async_task
    call_id = "rtc_cleanup_cancelled_without_task_123"
    response = interrupted_call_response(location: "/v1/realtime/calls/#{call_id}")
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, response) { |request| request.url.path == "/v1/realtime/calls" }
    http.expect(:execute, nil) do |request|
      if request.url.path == "/v1/realtime/calls/#{call_id}/hangup"
        raise Async::Stop, "synthetic hangup cancellation"
      end
    end

    assert_nil(Async::Task.current?)
    error = assert_raises(IOError) do
      client(http_client: http).realtime.calls.create(sdp: "v=0\r\n")
    end

    assert_equal("synthetic SDP response interrupted", error.message)
    assert_mock(http)
  end

  def test_create_hangs_up_when_cancellation_interrupts_completion_logging
    call_id = "rtc_completion_cancelled_123"
    response = OpenAI::HTTPClient::Response.new(
      status: 201,
      headers: {
        "Content-Type" => "application/sdp",
        "Location" => "/v1/realtime/calls/#{call_id}"
      },
      body: "v=0\r\n"
    )
    hangup_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, response) { |request| request.url.path == "/v1/realtime/calls" }
    http.expect(:execute, hangup_response) do |request|
      request.url.path == "/v1/realtime/calls/#{call_id}/hangup"
    end

    cancellation = Async::Stop.new("synthetic completion cancelled")
    logger = Logger.new(StringIO.new)
    log_completion = lambda do |message|
      raise cancellation if message.include?("path=/v1/realtime/calls status=")
    end

    logger.stub(:info, log_completion) do
      error = assert_raises(Async::Stop) do
        client(http_client: http, logger: logger, log_level: :info)
          .realtime
          .calls
          .create(sdp: "v=0\r\n")
      end

      assert_same(cancellation, error)
    end

    assert_mock(http)
  end

  def test_create_hangs_up_when_cancellation_interrupts_response_received_logging
    call_id = "rtc_response_logging_cancelled_123"
    released = false
    body = OpenAI::Internal::Util.fused_enum(["v=0\r\n"]) { released = true }
    response = OpenAI::HTTPClient::Response.new(
      status: 201,
      headers: {
        "Content-Type" => "application/sdp",
        "Location" => "/v1/realtime/calls/#{call_id}"
      },
      body: body
    )
    hangup_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, response) { |request| request.url.path == "/v1/realtime/calls" }
    http.expect(:execute, hangup_response) do |request|
      released && request.url.path == "/v1/realtime/calls/#{call_id}/hangup"
    end

    cancellation = Async::Stop.new("synthetic response logging cancelled")
    logger = Logger.new(StringIO.new)
    log_response = lambda do |message|
      if message.include?("response received") && message.include?("status=201")
        raise cancellation
      end
    end

    logger.stub(:debug, log_response) do
      error = assert_raises(Async::Stop) do
        client(http_client: http, logger: logger, log_level: :debug)
          .realtime
          .calls
          .create(sdp: "v=0\r\n")
      end

      assert_same(cancellation, error)
    end

    assert(released, "response cancellation must release the pooled connection before hangup")
    assert_mock(http)
  end

  def test_interrupted_call_cleanup_redacts_sensitive_request_and_location_data
    call_id = "rtc_fake_private_call_identifier"
    location_secret = "fake-private-location-token"
    offer = "v=0\r\no=- fake private SDP offer\r\n"
    response = interrupted_call_response(
      location: "/v1/realtime/calls/#{call_id}?access_token=#{location_secret}"
    )
    hangup_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
    output = StringIO.new
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, response) { |request| request.url.path == "/v1/realtime/calls" }
    http.expect(:execute, hangup_response) do |request|
      request.url.path == "/v1/realtime/calls/#{call_id}/hangup"
    end

    assert_raises(IOError) do
      client(http_client: http, logger: Logger.new(output), log_level: :debug)
        .realtime
        .calls
        .create(sdp: offer)
    end

    assert_includes(output.string, "/realtime/calls/%5BREDACTED%5D")
    refute_includes(output.string, call_id)
    refute_includes(output.string, location_secret)
    refute_includes(output.string, "test-key")
    refute_includes(output.string, "fake private SDP offer")
    assert_mock(http)
  end

  def test_create_never_cleans_up_missing_malformed_or_untrusted_locations
    locations = [
      nil,
      "",
      "%",
      "https://evil.example/v1/realtime/calls/rtc_stolen",
      "//evil.example/v1/realtime/calls/rtc_stolen",
      "http://example.com/v1/realtime/calls/rtc_downgraded",
      "https://fake-user@example.com/v1/realtime/calls/rtc_userinfo",
      "/v1/realtime/calls/rtc_fragment#unsafe",
      "/v1/realtime/calls/rtc_nested/extra",
      "/v1/realtime/calls/rtc%2Fencoded",
      "/v1/realtime/calls/../rtc_traversal",
      "/v1/other/calls/rtc_wrong_endpoint",
      "/v1/realtime/calls/rtc.invalid",
      "/v1/realtime/calls/"
    ]

    locations.each do |location|
      response = interrupted_call_response(location: location)
      http = Minitest::Mock.new(Object.new)
      http.expect(:execute, response) { |request| request.url.path == "/v1/realtime/calls" }

      error = assert_raises(IOError, "Location: #{location.inspect}") do
        client(http_client: http).realtime.calls.create(sdp: "v=0\r\n")
      end

      assert_equal("synthetic SDP response interrupted", error.message)
      assert_mock(http)
    end
  end

  def test_create_never_trusts_allocations_received_after_a_cross_origin_redirect
    call_id = "rtc_attacker_selected_123"
    redirect = OpenAI::HTTPClient::Response.new(
      status: 303,
      headers: {"Location" => "https://evil.example/v1/realtime/calls"},
      body: ""
    )
    response = interrupted_call_response(location: "/v1/realtime/calls/#{call_id}")
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, redirect) do |request|
      request.url.host == "example.com" && request.headers.key?("authorization")
    end

    http.expect(:execute, response) do |request|
      request.url.host == "evil.example" && !request.headers.key?("authorization")
    end

    configured = client(http_client: http)
    hangup_attempted = false
    unexpected_hangup = lambda do |*_args, **_options|
      hangup_attempted = true
      nil
    end

    configured.realtime.calls.stub(:hangup, unexpected_hangup) do
      error = assert_raises(IOError) do
        configured.realtime.calls.create(sdp: "v=0\r\n")
      end

      assert_equal("synthetic SDP response interrupted", error.message)
    end

    refute(hangup_attempted, "an untrusted redirect must never trigger an authenticated hangup")
    assert_mock(http)
  end

  def test_create_recognizes_equivalent_ipv6_origins_without_trusting_other_addresses
    locations = {
      "https://[0:0:0:0:0:0:0:1]:8443/v1/realtime/calls/rtc_ipv6_123" => true,
      "https://[::2]:8443/v1/realtime/calls/rtc_ipv6_123" => false
    }

    locations.each do |location, trusted|
      response = interrupted_call_response(location: location)
      http = Minitest::Mock.new(Object.new)
      http.expect(:execute, response) { |request| request.url.path == "/v1/realtime/calls" }
      if trusted
        hangup_response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: "")
        http.expect(:execute, hangup_response) do |request|
          request.url.host == "[::1]" && request.url.path == "/v1/realtime/calls/rtc_ipv6_123/hangup"
        end
      end

      configured = OpenAI::Client.new(
        api_key: "test-key",
        base_url: "https://[::1]:8443/v1",
        http_client: http
      )
      error = assert_raises(IOError, "Location: #{location}") do
        configured.realtime.calls.create(sdp: "v=0\r\n")
      end

      assert_equal("synthetic SDP response interrupted", error.message)
      assert_mock(http)
    end
  end

  def test_request_preserves_existing_validation_for_non_hash_inputs
    [nil, Object.new, "invalid", []].each do |request|
      error = assert_raises(ArgumentError, "request: #{request.inspect}") do
        client.request(request)
      end

      assert_match(/Request `req` must be a Hash or RequestOptions/, error.message)
    end
  end

  def test_create_does_not_hang_up_a_successfully_delivered_call
    call_id = "rtc_delivered_123"
    response = OpenAI::HTTPClient::Response.new(
      status: 201,
      headers: {
        "Content-Type" => "application/sdp",
        "Location" => "/v1/realtime/calls/#{call_id}"
      },
      body: "v=0\r\n"
    )
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, response) { |request| request.url.path == "/v1/realtime/calls" }

    result = client(http_client: http).realtime.calls.create(sdp: "v=0\r\n")

    assert_instance_of(OpenAI::HTTPClient::Response, result)
    assert_equal("/v1/realtime/calls/#{call_id}", result.headers.fetch("location"))
    assert_equal("v=0\r\n", result.body.to_a.join)
    assert_mock(http)
  end

  def test_interrupted_ordinary_raw_responses_do_not_trigger_call_cleanup
    response = interrupted_call_response(location: "/v1/realtime/calls/rtc_unrelated")
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, response) { |request| request.url.path == "/v1/custom/raw" }

    error = assert_raises(IOError) do
      client(http_client: http).request(method: :post, path: "custom/raw", model: OpenAI::HTTPClient::Response)
    end

    assert_equal("synthetic SDP response interrupted", error.message)
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

  def test_existing_zero_argument_transport_context_callbacks_remain_compatible
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"Content-Type" => "application/octet-stream"},
      body: "synthetic binary response"
    )
    http = Minitest::Mock.new(Object.new)
    http.expect(:execute, response) { |request| request.url.path == "/v1/files/file_existing_123/content" }
    strict_client = Class.new(OpenAI::Client) do
      private def send_request(request, redirect_count:, retry_count:, send_retry_header:, &context_provider)
        strict_context = -> { context_provider.call }
        super(request, redirect_count:, retry_count:, send_retry_header:, &strict_context)
      end
    end

    configured = strict_client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http
    )

    result = configured.files.content("file_existing_123")

    assert_equal("synthetic binary response", result.read)
    assert_mock(http)
  end

  private def interrupted_call_response(
    location:,
    exception: IOError.new("synthetic SDP response interrupted"),
    &on_close
  )
    body = Enumerator.new do |chunks|
      chunks << "v=0\r\n"
      raise exception
    end

    body = OpenAI::Internal::Util.fused_enum(body, &on_close) if on_close
    headers = {"Content-Type" => "application/sdp"}
    headers["Location"] = location unless location.nil?

    OpenAI::HTTPClient::Response.new(status: 201, headers: headers, body: body)
  end
end
