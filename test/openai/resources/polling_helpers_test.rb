# frozen_string_literal: true

require_relative "../test_helper"
require "timeout"

class OpenAI::Test::Resources::PollingHelpersTest < Minitest::Test
  RequestRecord = Data.define(:http_method, :path, :headers, :body, :timeout)

  class ScriptedHTTPClient
    attr_reader :requests

    def initialize(&handler)
      @handler = handler
      @mutex = Mutex.new
      @requests = []
    end

    def execute(request)
      body = request.body.is_a?(String) || request.body.nil? ? request.body : request.body.to_a.join
      record = RequestRecord.new(request.method, request.url.path, request.headers, body, request.timeout)
      @mutex.synchronize { @requests << record }
      status, headers, response_body = @handler.call(record)
      response_body = JSON.generate(response_body) unless response_body.is_a?(String)

      OpenAI::HTTPClient::Response.new(
        status: status,
        headers: {"content-type" => "application/json", **headers},
        body: response_body
      )
    end
  end

  class ScriptedWorkloadIdentityAuth
    attr_reader :deadlines, :invalidations, :token_requests

    def initialize(slow_token_requests:)
      @slow_token_requests = slow_token_requests
      @deadlines = []
      @invalidations = 0
      @token_requests = 0
    end

    def get_token(deadline: nil)
      @token_requests += 1
      @deadlines << deadline
      sleep(5) if @slow_token_requests.include?(@token_requests)
      "token-#{@token_requests}"
    end

    def invalidate_token
      @invalidations += 1
    end
  end

  class SlowSubjectTokenProvider
    attr_reader :calls, :completed_calls

    def initialize(delay:)
      @delay = delay
      @calls = 0
      @completed_calls = 0
    end

    def get_token
      @calls += 1
      sleep(@delay)
      @completed_calls += 1
      "subject-token"
    end

    def token_type = OpenAI::Auth::TokenType::JWT
  end

  def test_files_wait_for_processing_uses_server_interval_and_preserves_options
    responses = [file_object(status: "uploaded"), file_object(status: "processed")]
    transport = scripted_transport do
      [200, {"openai-poll-after-ms" => "25"}, responses.shift]
    end

    client = build_client(transport)

    result, sleeps = capture_sleep do
      client.files.wait_for_processing(
        "file_123",
        request_options: {extra_headers: {"X-Test" => "yes"}, max_retries: 0}
      )
    end

    assert_equal(:processed, result.status)
    assert_equal([0.025], sleeps)
    assert_equal(2, transport.requests.length)
    transport.requests.each do |request|
      assert_equal("yes", request.headers["x-test"])
      assert_equal("true", request.headers["x-stainless-poll-helper"])
      refute(request.headers.key?("x-stainless-custom-poll-interval"))
    end
  end

  def test_files_wait_for_processing_uses_custom_interval
    responses = [file_object(status: "uploaded"), file_object(status: "error")]
    transport = scripted_transport do
      [200, {"openai-poll-after-ms" => "500"}, responses.shift]
    end

    result, sleeps = capture_sleep do
      build_client(transport).files.wait_for_processing("file_123", poll_interval: 0.01)
    end

    assert_equal(:error, result.status)
    assert_equal([0.01], sleeps)
    assert_equal("10", transport.requests.first.headers["x-stainless-custom-poll-interval"])
  end

  def test_files_wait_for_processing_falls_back_for_invalid_server_interval
    responses = [file_object(status: "uploaded"), file_object(status: "processed")]
    transport = scripted_transport do
      [200, {"openai-poll-after-ms" => "invalid"}, responses.shift]
    end

    _result, sleeps = capture_sleep do
      build_client(transport).files.wait_for_processing("file_123")
    end

    assert_equal([OpenAI::Internal::Poller::DEFAULT_INTERVAL], sleeps)
  end

  def test_poller_falls_back_without_response_metadata_or_a_deadline
    resources = [
      Data.define(:last_response).new(nil),
      Data.define(:last_response).new(Data.define(:headers).new(nil)),
      Data.define(:last_response).new(Data.define(:headers).new({})),
      Data.define(:last_response).new(
        Data.define(:headers).new({"openai-poll-after-ms" => "0"})
      )
    ]
    poller = OpenAI::Internal::Poller.new(operation: "test resource", timeout: nil)

    _result, sleeps = capture_sleep { resources.each { poller.wait(_1) } }

    assert_equal([OpenAI::Internal::Poller::DEFAULT_INTERVAL] * resources.length, sleeps)
  end

  def test_files_wait_for_processing_allows_an_unbounded_request_without_a_deadline
    responses = [
      [429, {"retry-after" => "0"}, {error: {message: "retry", type: "rate_limit_error"}}],
      [200, {}, file_object(status: "processed")]
    ]
    transport = scripted_transport { responses.shift }

    result, sleeps = capture_sleep do
      build_client(transport, max_retries: 1).files.wait_for_processing(
        "file_123",
        timeout: nil,
        request_options: {timeout: nil}
      )
    end

    assert_equal(:processed, result.status)
    assert_nil(transport.requests.fetch(0).timeout)
    assert_equal(2, transport.requests.length)
    assert_equal([0.0], sleeps)
  end

  def test_finite_polling_deadline_disables_transport_retries
    transport = scripted_transport do
      [429, {"retry-after" => "60"}, {error: {message: "retry", type: "rate_limit_error"}}]
    end

    assert_raises(OpenAI::Errors::RateLimitError) do
      build_client(transport, max_retries: 2).files.wait_for_processing(
        "file_123",
        timeout: 10,
        request_options: {max_retries: 2}
      )
    end

    assert_equal(1, transport.requests.length)
  end

  def test_polling_deadline_bounds_workload_identity_token_refresh
    transport = scripted_transport { flunk("request should not be sent") }
    auth = ScriptedWorkloadIdentityAuth.new(slow_token_requests: [1])
    client = build_workload_identity_client(transport, auth)
    started_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    error = assert_raises(OpenAI::Errors::PollingTimeoutError) do
      client.files.wait_for_processing("file_123", timeout: 0.02)
    end

    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started_at
    assert_operator(elapsed, :<, 1)
    assert_nil(error.resource)
    assert_equal(1, auth.token_requests)
    assert_instance_of(Float, auth.deadlines.fetch(0))
    assert_empty(transport.requests)
  end

  def test_polling_deadline_bounds_workload_identity_401_replay
    transport = scripted_transport do
      [401, {}, {error: {message: "expired token", type: "authentication_error"}}]
    end

    auth = ScriptedWorkloadIdentityAuth.new(slow_token_requests: [2])
    client = build_workload_identity_client(transport, auth)
    started_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    error = assert_raises(OpenAI::Errors::PollingTimeoutError) do
      client.files.wait_for_processing("file_123", timeout: 0.02)
    end

    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started_at
    assert_operator(elapsed, :<, 1)
    assert_nil(error.resource)
    assert_equal(2, auth.token_requests)
    assert_equal(1, auth.deadlines.uniq.length)
    assert_instance_of(Float, auth.deadlines.fetch(0))
    assert_equal(1, auth.invalidations)
    assert_equal(1, transport.requests.length)
  end

  def test_unbounded_polling_preserves_a_nil_workload_identity_deadline
    transport = scripted_transport { [200, {}, file_object(status: "processed")] }
    auth = ScriptedWorkloadIdentityAuth.new(slow_token_requests: [])
    client = build_workload_identity_client(transport, auth)

    result = client.files.wait_for_processing(
      "file_123",
      timeout: nil,
      request_options: {timeout: nil}
    )

    assert_equal(:processed, result.status)
    assert_nil(auth.deadlines.fetch(0))
    assert_nil(transport.requests.fetch(0).timeout)
  end

  def test_unbounded_workload_identity_preserves_an_inner_timeout_error
    transport = scripted_transport { raise Timeout::Error, "inner timeout" }
    auth = ScriptedWorkloadIdentityAuth.new(slow_token_requests: [])
    client = build_workload_identity_client(transport, auth)

    error = assert_raises(Timeout::Error) do
      client.files.retrieve("file_123", request_options: {timeout: nil})
    end

    assert_equal("inner timeout", error.message)
    assert_nil(auth.deadlines.fetch(0))
    assert_equal(1, transport.requests.length)
  end

  def test_workload_identity_authentication_consumes_the_request_timeout
    transport = scripted_transport { flunk("request should not be sent") }
    auth = Class
      .new do
        attr_reader(:deadline)

        def get_token(deadline:)
          @deadline = deadline
          sleep(0.03)
          "token"
        end

        def invalidate_token = nil
      end
      .new
    client = build_workload_identity_client(transport, auth)

    error = assert_raises(OpenAI::Errors::APITimeoutError) do
      client.files.retrieve("file_123", request_options: {timeout: 0.01})
    end

    assert_match("workload identity authentication", error.message)
    assert_instance_of(Timeout::Error, error.cause)
    assert_instance_of(Float, auth.deadline)
    assert_empty(transport.requests)
  end

  def test_workload_identity_api_retries_preserve_the_original_authentication_deadline
    responses = [
      [429, {"retry-after" => "0"}, {error: {message: "retry", type: "rate_limit_error"}}],
      [200, {}, file_object(status: "processed")]
    ]
    transport = scripted_transport { responses.shift }
    auth = ScriptedWorkloadIdentityAuth.new(slow_token_requests: [])
    client = build_workload_identity_client(transport, auth)

    result = client.files.retrieve("file_123", request_options: {timeout: 1})

    assert_equal(:processed, result.status)
    assert_equal(2, transport.requests.length)
    assert_equal(2, auth.token_requests)
    assert_equal(1, auth.deadlines.uniq.length)
    assert_instance_of(Float, auth.deadlines.fetch(0))
  end

  def test_workload_identity_retry_deadline_redacts_the_timeout_error_url
    transport = scripted_transport do
      [429, {"retry-after" => "1"}, {error: {message: "retry", type: "rate_limit_error"}}]
    end

    auth = ScriptedWorkloadIdentityAuth.new(slow_token_requests: [])
    client = build_workload_identity_client(transport, auth)

    error = assert_raises(OpenAI::Errors::APITimeoutError) do
      client.files.retrieve(
        "file_123",
        request_options: {timeout: 0.01, extra_query: {"signature" => "fake-sensitive-query"}}
      )
    end

    assert_nil(error.url.query)
    assert_nil(error.url.fragment)
    refute_match(/fake-sensitive-query/, error.inspect)
    assert_equal(1, transport.requests.length)
  end

  def test_workload_identity_timeout_uses_the_sdk_error_and_retry_contract
    transport = scripted_transport { flunk("request should not be sent") }
    provider = SlowSubjectTokenProvider.new(delay: 0.1)
    retries = []
    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: config,
      organization: "org-123",
      base_url: "http://example.test/v1",
      http_client: transport,
      max_retries: 2,
      initial_retry_delay: 0,
      max_retry_delay: 0,
      on_retry: -> (event) { retries << event }
    )

    error = assert_raises(OpenAI::Errors::APITimeoutError) do
      client.files.retrieve(
        "file_123",
        request_options: {timeout: 0.005, extra_query: {"signature" => "fake-sensitive-query"}}
      )
    end

    assert_instance_of(Timeout::Error, error.cause)
    assert_nil(error.url.query)
    assert_nil(error.url.fragment)
    refute_match(/fake-sensitive-query/, error.inspect)
    assert_equal(1, provider.calls)
    assert_equal(0, provider.completed_calls)
    assert_empty(retries)
    assert_empty(transport.requests)
  end

  def test_poller_preserves_an_inner_timeout_before_its_deadline
    poller = OpenAI::Internal::Poller.new(operation: "test resource", timeout: 10)

    error = assert_raises(Timeout::Error) do
      poller.request({}) { raise Timeout::Error, "inner timeout" }
    end

    assert_equal("inner timeout", error.message)
  end

  def test_files_wait_for_processing_raises_before_request_when_deadline_elapsed
    transport = scripted_transport { flunk("request should not be sent") }

    error = assert_raises(OpenAI::Errors::PollingTimeoutError) do
      build_client(transport).files.wait_for_processing("file_123", timeout: 0)
    end

    assert_equal("file file_123", error.operation)
    assert_equal(0.0, error.timeout)
    assert_nil(error.resource)
    assert_match("Timed out waiting for file file_123", error.message)
    assert_empty(transport.requests)
  end

  def test_files_wait_for_processing_bounds_retrieval_by_polling_deadline
    transport = scripted_transport do |request|
      assert_operator(request.timeout, :positive?)
      assert_operator(request.timeout, :<=, 0.02)
      sleep(request.timeout + 0.01)
      raise OpenAI::Errors::APITimeoutError.new(url: URI("http://example.test/v1/files/file_123"))
    end

    error = assert_raises(OpenAI::Errors::PollingTimeoutError) do
      build_client(transport).files.wait_for_processing("file_123", timeout: 0.02)
    end

    assert_nil(error.resource)
    assert_equal(1, transport.requests.length)
  end

  def test_polling_helpers_preserve_a_shorter_request_timeout_error
    polls = [
      -> (client) do
        client.files.wait_for_processing("file_123", timeout: 10, request_options: {timeout: 0.01})
      end,
      -> (client) do
        client.vector_stores.files.poll(
          "file_123",
          vector_store_id: "vs_123",
          timeout: 10,
          request_options: {timeout: 0.01}
        )
      end,
      -> (client) do
        client.vector_stores.file_batches.poll(
          "batch_123",
          vector_store_id: "vs_123",
          timeout: 10,
          request_options: {timeout: 0.01}
        )
      end
    ]

    polls.each do |poll|
      transport = scripted_transport do |request|
        assert_equal(0.01, request.timeout)
        raise OpenAI::Errors::APITimeoutError.new(url: URI("http://example.test/v1/resource"))
      end

      assert_raises(OpenAI::Errors::APITimeoutError) { poll.call(build_client(transport)) }
      assert_equal(1, transport.requests.length)
    end
  end

  def test_polling_timeout_does_not_start_a_request_after_the_deadline
    requests = 0
    transport = scripted_transport do
      requests += 1
      flunk("a second request started after the polling deadline") if requests > 1

      [200, {}, file_object(status: "uploaded")]
    end

    error, sleeps = capture_sleep do
      assert_raises(OpenAI::Errors::PollingTimeoutError) do
        build_client(transport).files.wait_for_processing(
          "file_123",
          poll_interval: 60,
          timeout: 1
        )
      end
    end

    assert_equal(:uploaded, error.resource.status)
    assert_equal(1, transport.requests.length)
    assert_equal(1, sleeps.length)
    assert_operator(sleeps.first, :positive?)
    assert_operator(sleeps.first, :<=, 1)
  end

  def test_files_wait_for_processing_rejects_invalid_durations_before_requesting
    transport = scripted_transport { flunk("request should not be sent") }
    files = build_client(transport).files

    assert_raises(ArgumentError) { files.wait_for_processing("file_123", poll_interval: 0) }
    assert_raises(ArgumentError) { files.wait_for_processing("file_123", timeout: -1) }
    assert_raises(ArgumentError) { files.wait_for_processing("file_123", poll_interval: Float::NAN) }
    assert_raises(ArgumentError) { files.wait_for_processing("file_123", timeout: "1") }
    assert_empty(transport.requests)
  end

  def test_files_wait_for_processing_accepts_deleted_as_terminal
    transport = scripted_transport { [200, {}, file_object(status: "deleted")] }

    result = build_client(transport).files.wait_for_processing("file_123")

    assert_equal("deleted", result.status)
  end

  def test_files_wait_for_processing_rejects_an_unknown_status
    transport = scripted_transport { [200, {}, file_object(status: "mystery")] }

    error = assert_raises(OpenAI::Errors::PollingError) do
      build_client(transport).files.wait_for_processing("file_123")
    end

    assert_match("\"mystery\"", error.message)
  end

  def test_vector_store_file_poll_handles_all_terminal_states
    %w[completed failed cancelled].each do |status|
      transport = scripted_transport { [200, {}, vector_file(status: status)] }
      result = build_client(transport).vector_stores.files.poll(
        "file_123",
        vector_store_id: "vs_123"
      )

      assert_equal(status.to_sym, result.status)
      assert_equal(1, transport.requests.length)
    end
  end

  def test_vector_store_file_poll_uses_explicit_interval_and_request_options_object
    responses = [vector_file(status: "in_progress"), vector_file(status: "completed")]
    transport = scripted_transport do
      [200, {"openai-poll-after-ms" => "500"}, responses.shift]
    end

    options = OpenAI::RequestOptions.new(extra_headers: {"X-Test" => "yes"})

    result, sleeps = capture_sleep do
      build_client(transport).vector_stores.files.poll(
        "file_123",
        vector_store_id: "vs_123",
        poll_interval: 0.02,
        request_options: options
      )
    end

    assert_equal(:completed, result.status)
    assert_equal([0.02], sleeps)
    assert_equal("20", transport.requests.first.headers["x-stainless-custom-poll-interval"])
    assert_equal("yes", transport.requests.first.headers["x-test"])
    assert_equal("assistants=v2", transport.requests.first.headers["openai-beta"])
  end

  def test_vector_store_file_poll_rejects_an_unknown_status
    transport = scripted_transport { [200, {}, vector_file(status: "mystery")] }

    error = assert_raises(OpenAI::Errors::PollingError) do
      build_client(transport).vector_stores.files.poll("file_123", vector_store_id: "vs_123")
    end

    assert_match("\"mystery\"", error.message)
  end

  def test_vector_store_file_create_and_poll_forwards_creation_parameters
    created_body = nil
    request_options = {extra_headers: {"X-Test" => "yes"}}
    transport = scripted_transport do |request|
      case [request.http_method, request.path]
      in [:post, "/v1/vector_stores/vs_123/files"]
        created_body = JSON.parse(request.body)
        [200, {}, vector_file(status: "in_progress")]
      in [:get, "/v1/vector_stores/vs_123/files/file_123"]
        [200, {}, vector_file(status: "completed")]
      else
        flunk("unexpected request: #{request.http_method} #{request.path}")
      end
    end

    result = build_client(transport).vector_stores.files.create_and_poll(
      "vs_123",
      file_id: "file_123",
      attributes: {department: "engineering"},
      chunking_strategy: {type: :auto},
      request_options: request_options
    )

    assert_equal(:completed, result.status)
    assert_equal(
      {
        "file_id" => "file_123",
        "attributes" => {"department" => "engineering"},
        "chunking_strategy" => {"type" => "auto"}
      },
      created_body
    )
    assert_equal("assistants=v2", transport.requests.first.headers["openai-beta"])
    assert_equal("yes", transport.requests.first.headers["x-test"])
    assert_equal({extra_headers: {"X-Test" => "yes"}}, request_options)
  end

  def test_composite_helpers_validate_polling_before_requesting
    transport = scripted_transport { flunk("request should not be sent") }
    client = build_client(transport)

    assert_raises(ArgumentError) do
      client.vector_stores.files.create_and_poll("vs_123", file_id: "file_123", timeout: -1)
    end

    assert_raises(ArgumentError) do
      client.vector_stores.files.upload_and_poll(
        "vs_123",
        file: StringIO.new("file"),
        poll_interval: 0
      )
    end

    assert_raises(ArgumentError) do
      client.vector_stores.file_batches.create_and_poll(
        "vs_123",
        file_ids: ["file_123"],
        timeout: -1
      )
    end

    assert_raises(ArgumentError) do
      client.vector_stores.file_batches.upload_and_poll(
        "vs_123",
        files: [StringIO.new("file")],
        poll_interval: 0
      )
    end

    assert_empty(transport.requests)
  end

  def test_vector_store_file_upload_and_poll_uploads_attaches_and_waits
    request_bodies = {}
    transport = scripted_transport do |request|
      request_bodies[request.path] = request.body
      case [request.http_method, request.path]
      in [:post, "/v1/files"]
        [200, {}, file_object(id: "file_uploaded", status: "processed")]
      in [:post, "/v1/vector_stores/vs_123/files"]
        [200, {}, vector_file(id: "file_uploaded", status: "in_progress")]
      in [:get, "/v1/vector_stores/vs_123/files/file_uploaded"]
        [200, {}, vector_file(id: "file_uploaded", status: "completed")]
      else
        flunk("unexpected request: #{request.http_method} #{request.path}")
      end
    end

    result = build_client(transport).vector_stores.files.upload_and_poll(
      "vs_123",
      file: OpenAI::FilePart.new("contents", filename: "handbook.md", content_type: "text/markdown"),
      attributes: {department: "engineering"},
      request_options: {extra_headers: {"X-Test" => "yes"}}
    )

    assert_equal(:completed, result.status)
    assert_includes(request_bodies.fetch("/v1/files"), "name=\"purpose\"")
    assert_includes(request_bodies.fetch("/v1/files"), "assistants")
    assert_includes(request_bodies.fetch("/v1/files"), "filename=\"handbook.md\"")
    attached = JSON.parse(request_bodies.fetch("/v1/vector_stores/vs_123/files"))
    assert_equal("file_uploaded", attached.fetch("file_id"))
    assert_equal({"department" => "engineering"}, attached.fetch("attributes"))
    transport.requests.each { assert_equal("yes", _1.headers["x-test"]) }
    assert_equal("assistants=v2", transport.requests[1].headers["openai-beta"])
    assert_equal("true", transport.requests.last.headers["x-stainless-poll-helper"])
  end

  def test_vector_store_file_upload_prefers_an_explicit_idempotency_header
    transport = scripted_transport do |request|
      case request.path
      when "/v1/files"
        [200, {}, file_object(id: "file_uploaded", status: "processed")]
      when "/v1/vector_stores/vs_123/files"
        [200, {}, vector_file(id: "file_uploaded", status: "completed")]
      else
        flunk("unexpected request: #{request.http_method} #{request.path}")
      end
    end

    result = build_client(transport).vector_stores.files.upload(
      "vs_123",
      file: "contents",
      request_options: {
        idempotency_key: "structured-key",
        extra_headers: {"IDEMPOTENCY-KEY" => "header-key"}
      }
    )

    assert_equal(:completed, result.status)
    keys = transport.requests.map { _1.headers.fetch("idempotency-key") }
    expected = %w[file-upload vector-store-file].map do |operation|
      "stainless-ruby-#{Digest::SHA256.hexdigest("header-key\0#{operation}")}"
    end

    assert_equal(expected, keys)
  end

  def test_vector_store_batch_poll_handles_all_terminal_states
    %w[completed failed cancelled].each do |status|
      transport = scripted_transport { [200, {}, vector_batch(status: status)] }
      result = build_client(transport).vector_stores.file_batches.poll(
        "batch_123",
        vector_store_id: "vs_123"
      )

      assert_equal(status.to_sym, result.status)
      assert_equal(1, transport.requests.length)
    end
  end

  def test_vector_store_batch_poll_uses_server_interval
    responses = [vector_batch(status: "in_progress"), vector_batch(status: "completed")]
    transport = scripted_transport do
      [200, {"openai-poll-after-ms" => "30"}, responses.shift]
    end

    result, sleeps = capture_sleep do
      build_client(transport).vector_stores.file_batches.poll(
        "batch_123",
        vector_store_id: "vs_123"
      )
    end

    assert_equal(:completed, result.status)
    assert_equal([0.03], sleeps)
    assert_equal("true", transport.requests.first.headers["x-stainless-poll-helper"])
    assert_equal("assistants=v2", transport.requests.first.headers["openai-beta"])
  end

  def test_vector_store_batch_poll_rejects_an_unknown_status
    transport = scripted_transport { [200, {}, vector_batch(status: "mystery")] }

    error = assert_raises(OpenAI::Errors::PollingError) do
      build_client(transport).vector_stores.file_batches.poll(
        "batch_123",
        vector_store_id: "vs_123"
      )
    end

    assert_match("\"mystery\"", error.message)
  end

  def test_vector_store_batch_create_and_poll
    created_body = nil
    request_options = {extra_headers: {"X-Test" => "yes"}}
    transport = scripted_transport do |request|
      case [request.http_method, request.path]
      in [:post, "/v1/vector_stores/vs_123/file_batches"]
        created_body = JSON.parse(request.body)
        [200, {}, vector_batch(status: "in_progress")]
      in [:get, "/v1/vector_stores/vs_123/file_batches/batch_123"]
        [200, {}, vector_batch(status: "completed")]
      else
        flunk("unexpected request: #{request.http_method} #{request.path}")
      end
    end

    result = build_client(transport).vector_stores.file_batches.create_and_poll(
      "vs_123",
      file_ids: ["file_123"],
      attributes: {department: "engineering"},
      request_options: request_options
    )

    assert_equal(:completed, result.status)
    assert_equal(
      {"file_ids" => ["file_123"], "attributes" => {"department" => "engineering"}},
      created_body
    )
    assert_equal("assistants=v2", transport.requests.first.headers["openai-beta"])
    assert_equal("yes", transport.requests.first.headers["x-test"])
    assert_equal({extra_headers: {"X-Test" => "yes"}}, request_options)
  end

  def test_vector_store_batch_upload_and_poll_bounds_concurrency_and_combines_ids
    lock = Mutex.new
    active_uploads = 0
    maximum_uploads = 0
    upload_count = 0
    batch_body = nil
    transport = scripted_transport do |request|
      case [request.http_method, request.path]
      in [:post, "/v1/files"]
        id = lock.synchronize do
          active_uploads += 1
          maximum_uploads = [maximum_uploads, active_uploads].max
          upload_count += 1
          "file_uploaded_#{upload_count}"
        end

        sleep(0.02)
        lock.synchronize { active_uploads -= 1 }
        [200, {}, file_object(id: id, status: "processed")]
      in [:post, "/v1/vector_stores/vs_123/file_batches"]
        batch_body = JSON.parse(request.body)
        [200, {}, vector_batch(status: "in_progress")]
      in [:get, "/v1/vector_stores/vs_123/file_batches/batch_123"]
        [200, {}, vector_batch(status: "completed")]
      else
        flunk("unexpected request: #{request.http_method} #{request.path}")
      end
    end

    input = 4.times.map { StringIO.new("file #{_1}") }.each

    result = build_client(transport).vector_stores.file_batches.upload_and_poll(
      "vs_123",
      files: input,
      file_ids: ["file_existing"],
      max_concurrency: 2,
      chunking_strategy: {type: :auto},
      request_options: {extra_headers: {"X-Test" => "yes"}}
    )

    assert_equal(:completed, result.status)
    assert_equal(2, maximum_uploads)
    assert_equal("auto", batch_body.dig("chunking_strategy", "type"))
    assert_equal(
      %w[file_existing file_uploaded_1 file_uploaded_2 file_uploaded_3 file_uploaded_4].sort,
      batch_body.fetch("file_ids").sort
    )
    assert_equal(6, transport.requests.length)
    transport.requests.each { assert_equal("yes", _1.headers["x-test"]) }
    batch_request = transport.requests.find { _1.path.end_with?("/file_batches") }
    assert_equal("assistants=v2", batch_request.headers["openai-beta"])
  end

  def test_vector_store_batch_upload_preserves_raw_io_non_retry_semantics
    direct_attempts = 0
    direct_transport = scripted_transport do
      direct_attempts += 1
      [500, {}, {error: {message: "persisted before failure", type: "server_error"}}]
    end

    direct_reader, direct_writer = IO.pipe
    direct_writer.write("direct")
    direct_writer.close

    assert_raises(OpenAI::Errors::InternalServerError) do
      build_client(direct_transport, max_retries: 1).files.create(
        file: direct_reader,
        purpose: :assistants
      )
    end

    batch_attempts = 0
    batch_transport = scripted_transport do |request|
      assert_equal("/v1/files", request.path)
      batch_attempts += 1
      [500, {}, {error: {message: "persisted before failure", type: "server_error"}}]
    end

    batch_reader, batch_writer = IO.pipe
    batch_writer.write("batch")
    batch_writer.close

    assert_raises(OpenAI::Errors::InternalServerError) do
      build_client(batch_transport, max_retries: 1).vector_stores.file_batches.upload_and_poll(
        "vs_123",
        files: [batch_reader]
      )
    end

    assert_equal(1, direct_attempts)
    assert_equal(1, batch_attempts)
  ensure
    direct_reader&.close
    direct_writer&.close unless direct_writer&.closed?
    batch_reader&.close
    batch_writer&.close unless batch_writer&.closed?
  end

  def test_vector_store_batch_upload_derives_stable_per_operation_idempotency_keys
    persisted = {}
    post_keys = Hash.new { |hash, path| hash[path] = [] }
    next_file = 0
    transport = scripted_transport do |request|
      if request.http_method == :get
        next [200, {}, vector_batch(status: "completed")]
      end

      key = request.headers.fetch("idempotency-key")
      post_keys[request.path] << key
      next persisted.fetch(key) if persisted.key?(key)

      success = case request.path
      when "/v1/files"
        next_file += 1
        [200, {}, file_object(id: "file_uploaded_#{next_file}", status: "processed")]
      when "/v1/vector_stores/vs_123/file_batches"
        [200, {}, vector_batch(status: "in_progress")]
      else
        flunk("unexpected request: #{request.http_method} #{request.path}")
      end

      persisted[key] = success
      [500, {}, {error: {message: "persisted before failure", type: "server_error"}}]
    end

    result = build_client(transport, max_retries: 1).vector_stores.file_batches.upload_and_poll(
      "vs_123",
      files: %w[ALPHA BRAVO],
      max_concurrency: 2,
      request_options: {idempotency_key: "operation-key"}
    )

    assert_equal(:completed, result.status)
    upload_keys = post_keys.fetch("/v1/files")
    batch_keys = post_keys.fetch("/v1/vector_stores/vs_123/file_batches")
    assert_equal([2, 2], upload_keys.tally.values.sort)
    expected_upload_keys = 2.times.map do |index|
      "stainless-ruby-#{Digest::SHA256.hexdigest("operation-key\0file-upload-#{index}")}"
    end

    expected_batch_key = "stainless-ruby-#{Digest::SHA256.hexdigest("operation-key\0file-batch")}"
    assert_equal(expected_upload_keys.sort, upload_keys.uniq.sort)
    assert_equal([expected_batch_key, expected_batch_key], batch_keys)
  end

  def test_vector_store_batch_upload_and_poll_validates_inputs_before_requesting
    transport = scripted_transport { flunk("request should not be sent") }
    batches = build_client(transport).vector_stores.file_batches

    assert_raises(ArgumentError) { batches.upload_and_poll("vs_123", files: []) }
    assert_raises(ArgumentError) do
      batches.upload_and_poll("vs_123", files: [StringIO.new("file")], max_concurrency: 0)
    end

    assert_raises(ArgumentError) do
      batches.upload_and_poll("vs_123", files: [StringIO.new("file")], max_concurrency: 1.5)
    end

    assert_empty(transport.requests)
  end

  def test_vector_store_batch_upload_rejects_oversized_inputs_before_uploading
    transport = scripted_transport { flunk("request should not be sent") }
    batches = build_client(transport).vector_stores.file_batches

    assert_raises(ArgumentError) do
      batches.upload_and_poll("vs_123", files: Array.new(2_001, "file.txt"))
    end

    enumerated = 0
    unbounded_files = Enumerator.new do |yielder|
      loop do
        enumerated += 1
        yielder << "file.txt"
      end
    end

    assert_raises(ArgumentError) do
      batches.upload_and_poll(
        "vs_123",
        files: unbounded_files,
        file_ids: Array.new(1_999, "file_existing")
      )
    end

    assert_equal(2, enumerated)
    assert_empty(transport.requests)
  end

  def test_vector_store_batch_upload_rejects_too_many_existing_ids_without_enumerating
    transport = scripted_transport { flunk("request should not be sent") }
    files = Enumerator.new { flunk("files should not be enumerated") }

    assert_raises(ArgumentError) do
      build_client(transport).vector_stores.file_batches.upload_and_poll(
        "vs_123",
        files: files,
        file_ids: Array.new(2_001, "file_existing")
      )
    end

    assert_empty(transport.requests)
  end

  def test_vector_store_batch_upload_and_poll_does_not_create_batch_after_upload_failure
    transport = scripted_transport do |request|
      if request.path == "/v1/files"
        [400, {}, {error: {message: "upload failed", type: "invalid_request_error"}}]
      else
        flunk("batch should not be created after an upload failure")
      end
    end

    assert_raises(OpenAI::Errors::BadRequestError) do
      build_client(transport).vector_stores.file_batches.upload_and_poll(
        "vs_123",
        files: [StringIO.new("file")],
        request_options: {max_retries: 0}
      )
    end

    assert_equal(["/v1/files"], transport.requests.map(&:path))
  end

  private def scripted_transport(&handler) = ScriptedHTTPClient.new(&handler)

  private def build_client(transport, max_retries: 0)
    OpenAI::Client.new(
      api_key: "test-key",
      base_url: "http://example.test/v1",
      http_client: transport,
      max_retries: max_retries
    )
  end

  private def build_workload_identity_client(transport, auth)
    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: Object.new
    )

    OpenAI::Auth::WorkloadIdentityAuth.stub(:new, auth) do
      OpenAI::Client.new(
        api_key: nil,
        workload_identity: config,
        organization: "org-123",
        project: "proj-456",
        base_url: "http://example.test/v1",
        http_client: transport
      )
    end
  end

  private def capture_sleep
    sleeps = []
    Thread.current.thread_variable_set(:mock_sleep, sleeps)
    [yield, sleeps]
  ensure
    Thread.current.thread_variable_set(:mock_sleep, nil)
  end

  private def file_object(status:, id: "file_123")
    {
      id: id,
      bytes: 4,
      created_at: 1,
      filename: "file.txt",
      object: "file",
      purpose: "assistants",
      status: status
    }
  end

  private def vector_file(status:, id: "file_123")
    {
      id: id,
      created_at: 1,
      last_error: nil,
      object: "vector_store.file",
      status: status,
      usage_bytes: 4,
      vector_store_id: "vs_123"
    }
  end

  private def vector_batch(status:)
    {
      id: "batch_123",
      created_at: 1,
      file_counts: {
        cancelled: status == "cancelled" ? 1 : 0,
        completed: status == "completed" ? 1 : 0,
        failed: status == "failed" ? 1 : 0,
        in_progress: status == "in_progress" ? 1 : 0,
        total: 1
      },
      object: "vector_store.files_batch",
      status: status,
      vector_store_id: "vs_123"
    }
  end
end
