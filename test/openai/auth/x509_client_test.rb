# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../support/mtls_wire_harness"
require "open3"
require "rbconfig"

class OpenAI::Test::X509ClientTest < Minitest::Test
  extend Minitest::Serial

  Harness = OpenAI::Test::MTLSWireHarness
  WIRE_SUBPROCESS = "OPENAI_RUBY_X509_CLIENT_WIRE_SUBPROCESS"

  def setup
    super
    @native = OpenAI::NetHTTPClient.new
    @transport = OpenAI::Auth::X509Transport.new(http_client: @native, certificate_identity: :static)
    @identity = OpenAI::Auth::X509WorkloadIdentity.new(
      identity_provider_id: "idp_fake",
      service_account_id: "svc_acct_fake"
    )
  end

  def teardown
    @native.close
    super
  end

  def test_x509_client_defaults_to_its_attested_mtls_origin
    client = OpenAI::Client.new(api_key: nil, workload_identity: @identity, http_client: @transport)

    assert_equal("https://mtls.api.openai.com/v1", client.base_url.to_s)
    assert_same(@transport, client.requester)
    refute_nil(client.workload_identity_auth)
  end

  def test_api_key_clients_default_to_their_attested_mtls_transport_origin
    origins = ["https://mtls.api.openai.com", "https://mtls-eu.api.openai.com"]

    origins.each do |origin|
      transport = OpenAI::Auth::X509Transport.new(
        http_client: @native,
        certificate_identity: :static,
        api_origin: origin
      )
      client = OpenAI::Client.new(api_key: "fake-api-key", http_client: transport)
      observed = nil
      response = OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: [JSON.generate(id: "fake-model", created: 1, object: "model", owned_by: "openai")]
      )

      @native.stub(
        :execute,
        -> (request) {
          observed = request
          response
        }
      ) do
        assert_equal("fake-model", client.models.retrieve("fake-model").id)
      end

      assert_equal("#{origin}/v1", client.base_url.to_s)
      assert_equal("#{origin}/v1/models/fake-model", observed.url.to_s)
      assert_equal("Bearer fake-api-key", observed.headers.fetch("authorization"))
    end
  end

  def test_x509_client_requires_the_explicit_transport_capability
    [nil, @native, Object.new].each do |http_client|
      error = assert_raises(ArgumentError) do
        OpenAI::Client.new(api_key: nil, workload_identity: @identity, http_client: http_client)
      end

      assert_match(/attested X509Transport/, error.message)
    end
  end

  def test_x509_client_rejects_unapproved_endpoints_before_exchange
    endpoints = [
      "https://api.openai.com/v1",
      "https://tenant.openai.azure.com/openai/v1",
      "https://mtls-eu.api.openai.com/v1",
      "http://mtls.api.openai.com/v1",
      "https://mtls.api.openai.com:8443/v1",
      "https://user:password@mtls.api.openai.com/v1",
      "https://user@mtls.api.openai.com/v1"
    ]

    @native.stub(:execute, -> (_request) { flunk("invalid origin must fail before exchange") }) do
      endpoints.each do |endpoint|
        assert_raises(ArgumentError) do
          OpenAI::Client.new(
            api_key: nil,
            workload_identity: @identity,
            http_client: @transport,
            base_url: endpoint
          )
        end
      end
    end
  end

  def test_x509_client_copies_preserve_capability_and_reject_origin_substitution
    client = OpenAI::Client.new(api_key: nil, workload_identity: @identity, http_client: @transport)
    copy = client.with_options(timeout: 3.0)

    assert_same(@transport, copy.requester)
    assert_equal("https://mtls.api.openai.com/v1", copy.base_url.to_s)
    assert_raises(ArgumentError) { client.with_options(base_url: "https://attacker.invalid/v1") }
  end

  def test_replacing_transport_recomputes_the_matching_api_origin
    global = OpenAI::Client.new(api_key: nil, workload_identity: @identity, http_client: @transport)
    european_transport = OpenAI::Auth::X509Transport.new(
      http_client: @native,
      certificate_identity: :static,
      api_origin: "https://mtls-eu.api.openai.com"
    )

    european = global.with_options(http_client: european_transport)
    assert_equal("https://mtls-eu.api.openai.com/v1", european.base_url.to_s)
    assert_same(european_transport, european.requester)
    assert_equal("https://mtls.api.openai.com/v1", european.with_options(http_client: @transport).base_url.to_s)

    ordinary = global.with_options(api_key: "fake-api-key", http_client: @native)
    assert_equal("https://api.openai.com/v1", ordinary.base_url.to_s)
    assert_same(@native, ordinary.requester)

    reattested = ordinary.with_options(http_client: european_transport)
    assert_equal("https://mtls-eu.api.openai.com/v1", reattested.base_url.to_s)
    assert_same(european_transport, reattested.requester)
    assert_equal("fake-api-key", reattested.api_key)

    explicit = global.with_options(http_client: european_transport, base_url: "https://mtls-eu.api.openai.com/v2")
    assert_equal("https://mtls-eu.api.openai.com/v2", explicit.base_url.to_s)
    assert_raises(ArgumentError) do
      global.with_options(http_client: european_transport, base_url: "https://mtls.api.openai.com/v1")
    end
  end

  def test_switching_to_an_api_key_preserves_the_attested_regional_transport
    origin = "https://mtls-eu.api.openai.com"
    transport = OpenAI::Auth::X509Transport.new(
      http_client: @native,
      certificate_identity: :static,
      api_origin: origin
    )
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: @identity,
      http_client: transport,
      data_residency: :eu
    )

    copied = client.with_options(api_key: "fake-api-key", data_residency: :eu)

    assert_equal("#{origin}/v1", copied.base_url.to_s)
    assert_equal("fake-api-key", copied.api_key)
    assert_nil(copied.workload_identity_auth)
    assert_same(transport, copied.requester)
    assert_raises(ArgumentError) { client.with_options(api_key: "fake-api-key", data_residency: :us) }

    replaced = client.with_options(api_key: "fake-api-key", data_residency: :eu, http_client: @native)
    assert_equal("https://eu.api.openai.com/v1", replaced.base_url.to_s)
    assert_same(@native, replaced.requester)
  end

  def test_api_key_client_can_adopt_x509_identity_without_inheriting_its_endpoint
    ordinary = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://ordinary.example.invalid/v1",
      http_client: @native
    )

    copied = ordinary.with_options(workload_identity: @identity, http_client: @transport)

    assert_equal("https://mtls.api.openai.com/v1", copied.base_url.to_s)
    assert_same(@transport, copied.requester)
    refute_nil(copied.workload_identity_auth)
    assert_equal("https://ordinary.example.invalid/v1", ordinary.base_url.to_s)
    assert_raises(ArgumentError) do
      ordinary.with_options(
        workload_identity: @identity,
        http_client: @transport,
        base_url: "https://ordinary.example.invalid/v1"
      )
    end
  end

  def test_x509_data_residency_uses_only_the_matching_attested_mtls_origin
    origins = {
      global: "https://mtls.api.openai.com",
      us: "https://mtls-us.api.openai.com",
      eu: "https://mtls-eu.api.openai.com"
    }

    origins.each do |region, origin|
      transport = OpenAI::Auth::X509Transport.new(
        http_client: @native,
        certificate_identity: :static,
        api_origin: origin
      )
      client = OpenAI::Client.new(
        api_key: nil,
        workload_identity: @identity,
        http_client: transport,
        data_residency: region
      )

      assert_equal("#{origin}/v1", client.base_url.to_s)
      assert_equal("#{origin}/v1", client.with_options(data_residency: region).base_url.to_s)
      assert_equal("#{origin}/v1", client.with_options(data_residency: region, api_key: nil).base_url.to_s)
      assert_raises(ArgumentError) do
        client.with_options(data_residency: region, base_url: "#{origin}/v1")
      end

      mismatched = (origins.keys - [region]).first
      assert_raises(ArgumentError) { client.with_options(data_residency: mismatched) }
    end

    assert_raises(ArgumentError) do
      OpenAI::Client.new(
        api_key: nil,
        workload_identity: @identity,
        http_client: @transport,
        data_residency: :ae
      )
    end
  end

  def test_x509_bearer_overrides_are_rejected_before_any_token_exchange
    client = OpenAI::Client.new(api_key: nil, workload_identity: @identity, http_client: @transport)
    malicious_headers = [
      {"authorization" => "Bearer fake-attacker-token"},
      {"Authorization" => "Bearer fake-attacker-token"}
    ]

    @native.stub(:execute, -> (_request) { flunk("bearer override must fail before token exchange") }) do
      malicious_headers.each do |headers|
        error = assert_raises(OpenAI::Errors::Error) do
          client.models.retrieve("fake-model", request_options: {extra_headers: headers})
        end

        assert_match(/cannot override the selected authorization credential/, error.message)
      end
    end
  end

  def test_x509_selected_bearer_cannot_be_removed_before_token_exchange
    client = OpenAI::Client.new(api_key: nil, workload_identity: @identity, http_client: @transport)

    @native.stub(:execute, -> (_request) { flunk("missing bearer must fail before token exchange") }) do
      [nil, "", " \t"].each do |value|
        error = assert_raises(OpenAI::Errors::Error) do
          client.models.retrieve(
            "fake-model",
            request_options: {extra_headers: {"authorization" => value}}
          )
        end

        assert_match(/cannot override the selected authorization credential/, error.message)
      end
    end
  end

  def test_x509_effective_credential_headers_are_rejected_before_any_token_exchange
    client = OpenAI::Client.new(api_key: nil, workload_identity: @identity, http_client: @transport)
    malicious_headers = [
      {"x-api-key" => "fake-provider-key"},
      {"X_API_KEY" => "fake-provider-key"},
      {"proxy-authorization" => "Basic fake-proxy-secret"},
      {"Proxy_Authorization" => "Basic fake-proxy-secret"},
      {"host" => "attacker.invalid"}
    ]

    @native.stub(:execute, -> (_request) { flunk("unsafe headers must fail before token exchange") }) do
      malicious_headers.each do |headers|
        assert_raises(ArgumentError) do
          client.models.retrieve("fake-model", request_options: {extra_headers: headers})
        end

        configured = client.with_options(default_headers: headers)
        assert_raises(ArgumentError) { configured.models.retrieve("fake-model") }
      end
    end
  end

  def test_prepared_x509_requests_dispatch_the_immutable_validated_header_snapshot
    mutable_header = Class.new(String) do
      attr_reader(:comparisons)

      def to_s = self

      def ==(other)
        @comparisons = (@comparisons || 0) + 1
        matches = super
        replace("Bearer fake-mutated-after-validation") if matches
        matches
      end
    end

    retained_headers = []
    client_class = Class.new(OpenAI::Client) do
      define_method(:prepare_request) do |request, redirect_count:, retry_count:|
        prepared = super(request, redirect_count: redirect_count, retry_count: retry_count)
        retained = mutable_header.new(prepared.fetch(:headers).fetch("authorization"))
        retained_headers << retained
        prepared.merge(headers: prepared.fetch(:headers).merge("authorization" => retained))
      end

      private(:prepare_request)
    end

    client = client_class.new(api_key: nil, workload_identity: @identity, http_client: @transport)
    observed = nil
    dispatch = lambda do |request|
      payload = if request.url.host == "mtls.auth.openai.com"
        {
          access_token: "fake-issued-token",
          issued_token_type: "urn:ietf:params:oauth:token-type:access_token",
          token_type: "Bearer",
          expires_in: 120
        }
      else
        observed = request
        {id: "fake-model", created: 1, object: "model", owned_by: "openai"}
      end

      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: [JSON.generate(payload)]
      )
    end

    @native.stub(:execute, dispatch) do
      assert_equal("fake-model", client.models.retrieve("fake-model").id)
    end

    assert_equal("Bearer fake-issued-token", observed.headers.fetch("authorization"))
    assert_instance_of(String, observed.headers.fetch("authorization"))
    assert_predicate(observed.headers, :frozen?)
    assert_nil(retained_headers.fetch(0).comparisons)
  end

  def test_realtime_is_rejected_before_any_x509_exchange
    client = OpenAI::Client.new(api_key: nil, workload_identity: @identity, http_client: @transport)

    @native.stub(:execute, -> (_request) { flunk("Realtime must not exchange an X.509 credential") }) do
      error = assert_raises(OpenAI::Errors::Error) do
        client.realtime_connection_request(path: "/v1/realtime", query: {})
      end

      assert_match(/X\.509.*Realtime/, error.message)
    end
  end

  def test_api_key_mtls_transport_can_prepare_a_separate_realtime_connection
    client = OpenAI::Client.new(api_key: "fake-realtime-key", http_client: @transport)

    @native.stub(:execute, -> (_request) { flunk("Realtime request preparation must not use HTTP transport") }) do
      request = client.realtime_connection_request(path: "/v1/realtime", query: {})

      assert_equal("Bearer fake-realtime-key", request.fetch(:headers).fetch("authorization"))
      assert_equal("wss", request.fetch(:url).scheme)
    end
  end

  def test_x509_client_retries_transient_issuer_statuses_before_dispatching_the_api_request
    [408, 409, 429, 500, 503].each do |status|
      client = OpenAI::Client.new(
        api_key: nil,
        workload_identity: @identity,
        http_client: @transport,
        max_retries: 2,
        initial_retry_delay: 0,
        max_retry_delay: 0
      )
      issuer_attempts = 0
      api_attempts = 0
      dispatch = lambda do |request|
        if request.url.host == "mtls.auth.openai.com"
          issuer_attempts += 1
          issuer_attempts == 1 ? x509_issuer_failure(status) : x509_issuer_success
        else
          api_attempts += 1
          x509_model_response
        end
      end

      @native.stub(:execute, dispatch) do
        assert_equal("fake-model", client.models.retrieve("fake-model").id)
      end

      assert_equal(2, issuer_attempts)
      assert_equal(1, api_attempts)
    end
  end

  def test_x509_issuer_retries_honor_configured_budget_and_explicit_server_opt_out
    cases = [
      [503, {}, 2, 3, OpenAI::Errors::APIError],
      [503, {"x-should-retry" => "false"}, 2, 1, OpenAI::Errors::APIError],
      [400, {"retry-after" => "0"}, 2, 1, OpenAI::Errors::OAuthError],
      [401, {"retry-after" => "0"}, 2, 1, OpenAI::Errors::OAuthError],
      [403, {"retry-after" => "0"}, 2, 1, OpenAI::Errors::OAuthError],
      [404, {"x-should-retry" => "true"}, 2, 1, OpenAI::Errors::APIError]
    ]

    cases.each do |status, headers, retries, expected_attempts, expected_error|
      client = OpenAI::Client.new(
        api_key: nil,
        workload_identity: @identity,
        http_client: @transport,
        max_retries: retries,
        initial_retry_delay: 0,
        max_retry_delay: 0
      )
      attempts = 0
      dispatch = lambda do |_request|
        attempts += 1
        x509_issuer_failure(status, headers: headers)
      end

      @native.stub(:execute, dispatch) do
        error = assert_raises(expected_error) { client.models.retrieve("fake-model") }
        assert_equal(status, error.status)
      end

      assert_equal(expected_attempts, attempts)
    end
  end

  def test_x509_issuer_retries_honor_per_request_retry_budget
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 0,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )
    issuer_attempts = 0
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        issuer_attempts += 1
        issuer_attempts == 1 ? x509_issuer_failure(503) : x509_issuer_success
      else
        x509_model_response
      end
    end

    @native.stub(:execute, dispatch) do
      result = client.models.retrieve("fake-model", request_options: {max_retries: 1})
      assert_equal("fake-model", result.id)
    end

    assert_equal(2, issuer_attempts)
  end

  def test_x509_issuer_retries_connection_failures_without_exceeding_its_budget
    reader = Class.new do
      def initialize(source) = @source = source
      def read(*) = @source.read(*)
    end

    [OpenAI::Errors::APIConnectionError, OpenAI::Errors::APITimeoutError].each do |error_class|
      events = []
      client = OpenAI::Client.new(
        api_key: nil,
        workload_identity: @identity,
        http_client: @transport,
        max_retries: 1,
        initial_retry_delay: 0,
        max_retry_delay: 0,
        on_retry: -> (event) {
          events << event
          raise "fake retry observer failure"
        }
      )
      issuer_attempts = 0
      api_attempts = 0
      source = StringIO.new("fake-sensitive-nonreplayable-upload")
      dispatch = lambda do |request|
        if request.url.host == "mtls.auth.openai.com"
          issuer_attempts += 1
          if issuer_attempts == 1
            raise error_class.new(url: request.url, message: "fake-sensitive-network-secret")
          end

          x509_issuer_success
        else
          api_attempts += 1
          x509_model_response
        end
      end

      @native.stub(:execute, dispatch) do
        result = client.request(method: :post, path: "/v1/upload", body: reader.new(source))
        assert_equal("fake-model", result.fetch(:id))
      end

      assert_equal(2, issuer_attempts)
      assert_equal(1, api_attempts)
      assert_equal(0, source.pos)
      assert_equal(1, events.length)
      event = events.fetch(0)
      assert_instance_of(error_class, event.error)
      assert_nil(event.response)
      assert_nil(event.status)
      assert_equal(2, event.attempt)
      assert_equal(2, event.max_attempts)
      assert_equal("https://mtls.auth.openai.com/oauth/token", event.error.url.to_s)
      refute_includes(event.error.message, "fake-sensitive-network-secret")
      assert_nil(event.error.cause)
    end
  end

  def test_x509_terminal_issuer_connection_failure_is_not_retried_again_by_api_transport
    events = []
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0,
      on_retry: -> (event) { events << event }
    )
    attempts = 0
    dispatch = lambda do |request|
      attempts += 1
      raise OpenAI::Errors::APIConnectionError.new(url: request.url)
    end

    @native.stub(:execute, dispatch) do
      assert_raises(OpenAI::Errors::APIConnectionError) { client.models.retrieve("fake-model") }
    end

    assert_equal(2, attempts)
    assert_equal(1, events.length)
    assert_instance_of(OpenAI::Errors::APIConnectionError, events.fetch(0).error)
  end

  def test_x509_issuer_connection_retry_consumes_the_shared_api_retry_budget
    events = []
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0,
      on_retry: -> (event) { events << event }
    )
    issuer_attempts = 0
    api_attempts = 0
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        issuer_attempts += 1
        if issuer_attempts == 1
          raise OpenAI::Errors::APIConnectionError.new(url: request.url)
        end

        x509_issuer_success
      else
        api_attempts += 1
        x509_issuer_failure(503)
      end
    end

    @native.stub(:execute, dispatch) do
      error = assert_raises(OpenAI::Errors::APIError) { client.models.retrieve("fake-model") }
      assert_equal(503, error.status)
    end

    assert_equal(2, issuer_attempts)
    assert_equal(1, api_attempts)
    assert_equal(1, events.length)
    assert_instance_of(OpenAI::Errors::APIConnectionError, events.fetch(0).error)
  end

  def test_x509_issuer_connection_retry_cannot_exceed_the_absolute_request_deadline
    events = []
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 1,
      timeout: 0.05,
      initial_retry_delay: 1,
      max_retry_delay: 1,
      on_retry: -> (event) { events << event }
    )
    attempts = 0
    dispatch = lambda do |request|
      attempts += 1
      raise OpenAI::Errors::APIConnectionError.new(url: request.url)
    end

    @native.stub(:execute, dispatch) do
      assert_raises(OpenAI::Errors::APITimeoutError) { client.models.retrieve("fake-model") }
    end

    assert_equal(1, attempts)
    assert_empty(events)
  end

  def test_x509_issuer_status_retries_emit_safe_standard_callback_and_logging_events
    events = []
    log_output = StringIO.new
    logger = Logger.new(log_output)
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 2,
      initial_retry_delay: 0,
      max_retry_delay: 0,
      logger: logger,
      log_level: :debug,
      on_retry: -> (event) { events << event }
    )
    issuer_attempts = 0
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        issuer_attempts += 1
        if issuer_attempts == 1
          x509_issuer_failure(
            429,
            headers: {
              "x-request-id" => "req_fake_issuer",
              "retry-after" => "0",
              "authorization" => "Bearer fake-sensitive-header",
              "set-cookie" => "fake-sensitive-cookie"
            }
          )
        else
          x509_issuer_success
        end
      else
        x509_model_response
      end
    end

    @native.stub(:execute, dispatch) do
      assert_equal("fake-model", client.models.retrieve("fake-model").id)
    end

    assert_equal(1, events.length)
    event = events.fetch(0)
    assert_equal(2, event.attempt)
    assert_equal(3, event.max_attempts)
    assert_equal(0.0, event.delay)
    assert_equal(429, event.status)
    assert_equal("req_fake_issuer", event.request_id)
    assert_equal({"x-request-id" => "req_fake_issuer", "retry-after" => "0"}, event.response.headers)
    assert_nil(event.error)
    assert_predicate(event, :frozen?)
    log = log_output.string
    assert_includes(log, "request retry")
    assert_includes(log, "status=429")
    refute_includes(log, "fake-sensitive-header")
    refute_includes(log, "fake-sensitive-cookie")
    refute_includes(log, "idp_fake")
    refute_includes(log, "svc_acct_fake")
  end

  def test_x509_issuer_and_api_share_one_request_retry_budget
    cases = [
      [1, 1, 1, false, 2, 1],
      [2, 1, 1, true, 2, 2],
      [2, 1, 2, false, 2, 2],
      [1, 0, 1, true, 1, 2],
      [2, 2, 1, false, 3, 1]
    ]

    cases.each do |max_retries, issuer_failures, api_failures, succeeds, expected_issuer, expected_api|
      client = OpenAI::Client.new(
        api_key: nil,
        workload_identity: @identity,
        http_client: @transport,
        max_retries: max_retries,
        initial_retry_delay: 0,
        max_retry_delay: 0
      )
      issuer_attempts = 0
      api_attempts = 0
      dispatch = lambda do |request|
        if request.url.host == "mtls.auth.openai.com"
          issuer_attempts += 1
          issuer_attempts <= issuer_failures ? x509_issuer_failure(503) : x509_issuer_success
        else
          api_attempts += 1
          api_attempts <= api_failures ? x509_issuer_failure(503) : x509_model_response
        end
      end

      @native.stub(:execute, dispatch) do
        if succeeds
          assert_equal("fake-model", client.models.retrieve("fake-model").id)
        else
          error = assert_raises(OpenAI::Errors::APIError) { client.models.retrieve("fake-model") }
          assert_equal(503, error.status)
        end
      end

      assert_equal(expected_issuer, issuer_attempts)
      assert_equal(expected_api, api_attempts)
    end
  end

  def test_nonreplayable_request_retries_issuer_without_replaying_or_reading_its_body
    cases = [
      [2, nil, 408, true, 2, 1],
      [2, nil, 429, true, 2, 1],
      [2, nil, 503, true, 2, 1],
      [2, 0, 503, false, 1, 0],
      [0, 1, 503, true, 2, 1]
    ]
    reader_class = Class.new do
      def initialize(source) = @source = source
      def read(*) = @source.read(*)
    end

    cases.each do |configured_retries, request_retries, status, succeeds, expected_issuer, expected_api|
      client = OpenAI::Client.new(
        api_key: nil,
        workload_identity: @identity,
        http_client: @transport,
        max_retries: configured_retries,
        initial_retry_delay: 0,
        max_retry_delay: 0
      )
      source = StringIO.new("fake-nonreplayable-upload")
      issuer_attempts = 0
      api_attempts = 0
      dispatch = lambda do |request|
        if request.url.host == "mtls.auth.openai.com"
          issuer_attempts += 1
          issuer_attempts == 1 ? x509_issuer_failure(status) : x509_issuer_success
        else
          api_attempts += 1
          x509_model_response
        end
      end

      options = {}
      options[:max_retries] = request_retries unless request_retries.nil?

      @native.stub(:execute, dispatch) do
        if succeeds
          result = client.request(method: :post, path: "/v1/upload", body: reader_class.new(source), options: options)
          assert_equal("fake-model", result.fetch(:id))
        else
          error = assert_raises(OpenAI::Errors::APIError) do
            client.request(method: :post, path: "/v1/upload", body: reader_class.new(source), options: options)
          end

          assert_equal(status, error.status)
        end
      end

      assert_equal(expected_issuer, issuer_attempts)
      assert_equal(expected_api, api_attempts)
      assert_equal(0, source.pos)
    end
  end

  def test_nonreplayable_request_never_retries_api_after_safe_issuer_retry
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 2,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )
    reader = Class.new do
      def initialize(source) = @source = source
      def read(*) = @source.read(*)
    end

    source = StringIO.new("fake-nonreplayable-upload")
    issuer_attempts = 0
    api_attempts = 0
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        issuer_attempts += 1
        issuer_attempts == 1 ? x509_issuer_failure(503) : x509_issuer_success
      else
        api_attempts += 1
        x509_issuer_failure(503)
      end
    end

    @native.stub(:execute, dispatch) do
      error = assert_raises(OpenAI::Errors::APIError) do
        client.request(method: :post, path: "/v1/upload", body: reader.new(source))
      end

      assert_equal(503, error.status)
    end

    assert_equal(2, issuer_attempts)
    assert_equal(1, api_attempts)
    assert_equal(0, source.pos)
  end

  def test_x509_issuer_retries_honor_safe_seconds_and_millisecond_headers
    delays = [
      [{"retry-after" => "0.25"}, 0.25],
      [{"retry-after-ms" => "125", "retry-after" => "2"}, 0.125],
      [{"retry-after" => "NaN"}, 0.0],
      [{"retry-after" => "-10"}, 0.0],
      [{"retry-after" => "999999999999999999999"}, 5.0],
      [{"retry-after-ms" => "Infinity", "retry-after" => "0.2"}, 0.2]
    ]

    delays.each do |headers, expected_delay|
      client = OpenAI::Client.new(
        api_key: nil,
        workload_identity: @identity,
        http_client: @transport,
        max_retries: 1,
        initial_retry_delay: 0,
        max_retry_delay: 5
      )
      issuer_attempts = 0
      dispatch = lambda do |request|
        if request.url.host == "mtls.auth.openai.com"
          issuer_attempts += 1
          issuer_attempts == 1 ? x509_issuer_failure(429, headers: headers) : x509_issuer_success
        else
          x509_model_response
        end
      end

      sleeps = []
      previous_sleep = Thread.current.thread_variable_get(:mock_sleep)
      Thread.current.thread_variable_set(:mock_sleep, sleeps)

      @native.stub(:execute, dispatch) do
        assert_equal("fake-model", client.models.retrieve("fake-model").id)
      end

      assert_equal([expected_delay], sleeps)
      assert_equal(2, issuer_attempts)
    ensure
      Thread.current.thread_variable_set(:mock_sleep, previous_sleep)
    end
  end

  def test_x509_issuer_retry_after_cannot_exceed_the_original_request_deadline
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 2,
      timeout: 0.05,
      initial_retry_delay: 0,
      max_retry_delay: 5
    )
    attempts = 0
    sleeps = []
    previous_sleep = Thread.current.thread_variable_get(:mock_sleep)
    Thread.current.thread_variable_set(:mock_sleep, sleeps)
    dispatch = lambda do |_request|
      attempts += 1
      x509_issuer_failure(429, headers: {"retry-after" => "1"})
    end

    @native.stub(:execute, dispatch) do
      error = assert_raises(OpenAI::Errors::APITimeoutError) { client.models.retrieve("fake-model") }
      assert_match(/timed out during workload identity authentication/, error.message)
    end

    assert_equal(1, attempts)
    assert_empty(sleeps)
  ensure
    Thread.current.thread_variable_set(:mock_sleep, previous_sleep)
  end

  def test_public_client_completes_real_mtls_exchange_and_model_request
    unless ENV[WIRE_SUBPROCESS] == "1"
      output, status = Open3.capture2e(
        {WIRE_SUBPROCESS => "1"},
        RbConfig.ruby,
        File.expand_path(__FILE__),
        "--name",
        name
      )
      return assert_predicate(status, :success?, output)
    end

    hostnames = %w[mtls.auth.openai.com mtls.api.openai.com]
    pki = Harness::PKI.new(hostnames: hostnames)
    issuer = Harness::MTLSServer.new(
      hostname: hostnames.fetch(0),
      pki: pki,
      body: {
        access_token: "fake-real-wire-bearer",
        issued_token_type: "urn:ietf:params:oauth:token-type:access_token",
        token_type: "Bearer",
        expires_in: 120
      }
    )
    api = Harness::MTLSServer.new(
      hostname: hostnames.fetch(1),
      pki: pki,
      body: {id: "fake-model", created: 1, object: "model", owned_by: "openai"}
    )
    proxy = Harness::ConnectProxy.new(
      authority_ports: {
        "#{issuer.hostname}:443" => issuer.local_port,
        "#{api.hostname}:443" => api.local_port
      },
      expected_connections: 2
    )
    identity = pki.client_identity
    configured_client = OpenAI::NetHTTPClient.new(size: 1) do |connection|
      Harness.configure_http_connect_proxy(connection, proxy.uri)
      connection.cert_store = pki.trust_store
      connection.cert = identity.certificate
      connection.extra_chain_cert = [pki.intermediate_certificate]
      connection.key = identity.key
    end

    transport = OpenAI::Auth::X509Transport.new(
      http_client: configured_client,
      certificate_identity: :static,
      proxy: :http_connect
    )
    client = OpenAI::Client.new(api_key: nil, workload_identity: @identity, http_client: transport)

    Harness.with_proxy_environment(proxy.uri) do
      model = client.models.retrieve("fake-model")
      assert_equal("fake-model", model.id)
    end

    configured_client.close
    issuer_record = issuer.finish.fetch(0)
    api_record = api.finish.fetch(0)
    proxy_records = proxy.finish

    assert_equal("POST /oauth/token HTTP/1.1", issuer_record.request_line)
    assert_equal("GET /v1/models/fake-model HTTP/1.1", api_record.request_line)
    assert_equal(identity.certificate.to_der, issuer_record.peer_certificate.to_der)
    assert_equal(identity.certificate.to_der, api_record.peer_certificate.to_der)
    refute_includes(issuer_record.headers, "authorization")
    assert_equal("Bearer fake-real-wire-bearer", api_record.headers.fetch("authorization"))
    proxy_records.each { refute_includes(_1.headers, "authorization") }
  ensure
    configured_client&.close
    proxy&.close
    issuer&.close
    api&.close
  end

  private def x509_issuer_success
    OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: JSON.generate(
        access_token: "fake-issued-token",
        issued_token_type: "urn:ietf:params:oauth:token-type:access_token",
        token_type: "Bearer",
        expires_in: 120
      )
    )
  end

  private def x509_issuer_failure(status, headers: {})
    OpenAI::HTTPClient::Response.new(
      status: status,
      headers: {"x-request-id" => "req_fake"}.merge(headers),
      body: ""
    )
  end

  private def x509_model_response
    OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: JSON.generate(id: "fake-model", created: 1, object: "model", owned_by: "openai")
    )
  end
end
