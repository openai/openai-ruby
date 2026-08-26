# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::X509ContractTest < Minitest::Test
  def setup
    super
    @native = OpenAI::NetHTTPClient.new
    @identity_options = {identity_provider_id: "idp_fake", service_account_id: "svc_acct_fake"}
  end

  def teardown
    @native.close
    super
  end

  def test_identity_builds_its_attested_transport_without_exposing_transport_assembly
    identity = OpenAI::Auth::X509WorkloadIdentity.new(**@identity_options, http_client: @native)
    client = OpenAI::Client.new(api_key: nil, workload_identity: identity)
    requests = []
    dispatch = lambda do |request|
      requests << request
      request.url.host == "mtls.auth.openai.com" ? token_response : model_response
    end

    @native.stub(:execute, dispatch) do
      assert_equal("fake-model", client.models.retrieve("fake-model").id)
    end

    assert_instance_of(OpenAI::Auth::X509Transport, client.requester)
    assert_equal("https://mtls.api.openai.com/v1", client.base_url.to_s)
    assert_equal(%w[mtls.auth.openai.com mtls.api.openai.com], requests.map { _1.url.host })
    assert_equal("Bearer fake-issued-token", requests.fetch(1).headers.fetch("authorization"))
    assert_predicate(identity, :frozen?)
  end

  def test_identity_supports_approved_regions_and_explicit_proxy_policy
    identity = OpenAI::Auth::X509WorkloadIdentity.new(
      **@identity_options,
      http_client: @native,
      api_origin: "https://mtls-eu.api.openai.com",
      proxy: :http_connect
    )
    client = OpenAI::Client.new(api_key: nil, workload_identity: identity, data_residency: :eu)

    assert_equal("https://mtls-eu.api.openai.com/v1", client.base_url.to_s)
    assert_equal(:http_connect, client.requester.proxy_mode)
    assert_raises(ArgumentError) { client.with_options(data_residency: :us) }
    assert_raises(ArgumentError) { client.with_options(data_residency: :ae) }
  end

  def test_identity_rejects_unapproved_native_clients_and_origins
    invalid_clients = [Object.new, Class.new(OpenAI::NetHTTPClient).new]
    invalid_clients.each do |http_client|
      error = assert_raises(ArgumentError) do
        OpenAI::Auth::X509WorkloadIdentity.new(**@identity_options, http_client: http_client)
      end

      assert_match(/caller-owned OpenAI::NetHTTPClient/, error.message)
      http_client.close if http_client.respond_to?(:close)
    end

    assert_raises(ArgumentError) do
      OpenAI::Auth::X509WorkloadIdentity.new(
        **@identity_options,
        http_client: @native,
        api_origin: "https://attacker.invalid"
      )
    end

    [
      {proxy: :http_connect},
      {api_origin: "https://mtls-eu.api.openai.com"}
    ].each do |options|
      error = assert_raises(ArgumentError) do
        OpenAI::Auth::X509WorkloadIdentity.new(**@identity_options, **options)
      end

      assert_match(/requires http_client:/, error.message)
    end
  end

  def test_configured_identity_rejects_transport_substitution
    identity = OpenAI::Auth::X509WorkloadIdentity.new(**@identity_options, http_client: @native)
    substituted = OpenAI::Auth::X509Transport.new(http_client: @native, certificate_identity: :static)

    error = assert_raises(ArgumentError) do
      OpenAI::Client.new(api_key: nil, workload_identity: identity, http_client: substituted)
    end

    assert_match(/configured X\.509 transport/, error.message)
  end

  def test_identity_subclasses_fail_at_client_construction
    identity = Class.new(OpenAI::Auth::X509WorkloadIdentity).new(**@identity_options)
    transport = OpenAI::Auth::X509Transport.new(http_client: @native, certificate_identity: :static)

    error = assert_raises(ArgumentError) do
      OpenAI::Client.new(api_key: nil, workload_identity: identity, http_client: transport)
    end

    assert_match(/X509WorkloadIdentity subclasses/, error.message)
  end

  def test_scoped_copies_share_the_token_cache_and_refresh_coordinator
    identity = OpenAI::Auth::X509WorkloadIdentity.new(**@identity_options, http_client: @native)
    original = OpenAI::Client.new(api_key: nil, workload_identity: identity)
    scoped = original.with_options(timeout: 30.0)
    nested = scoped.with_options(default_headers: {"x-feature" => "scoped"})
    exchange_count = 0
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        exchange_count += 1
        token_response
      else
        model_response
      end
    end

    @native.stub(:execute, dispatch) do
      [original, scoped, nested].each do |client|
        assert_equal("fake-model", client.models.retrieve("fake-model").id)
      end
    end

    assert_same(original.workload_identity_auth, scoped.workload_identity_auth)
    assert_same(original.workload_identity_auth, nested.workload_identity_auth)
    assert_equal(1, exchange_count)
  end

  def test_scoped_regional_copies_preserve_the_same_token_cache
    identity = OpenAI::Auth::X509WorkloadIdentity.new(
      **@identity_options,
      http_client: @native,
      api_origin: "https://mtls-eu.api.openai.com"
    )
    original = OpenAI::Client.new(api_key: nil, workload_identity: identity, data_residency: :eu)

    copied = original.with_options(data_residency: :eu, timeout: 30.0)

    assert_same(original.requester, copied.requester)
    assert_same(original.workload_identity_auth, copied.workload_identity_auth)
  end

  def test_changing_identity_or_transport_never_shares_a_token_cache
    identity = OpenAI::Auth::X509WorkloadIdentity.new(**@identity_options)
    transport = OpenAI::Auth::X509Transport.new(http_client: @native, certificate_identity: :static)
    original = OpenAI::Client.new(api_key: nil, workload_identity: identity, http_client: transport)
    other_identity = OpenAI::Auth::X509WorkloadIdentity.new(
      identity_provider_id: "idp_other",
      service_account_id: "svc_acct_other"
    )
    other_transport = OpenAI::Auth::X509Transport.new(http_client: @native, certificate_identity: :static)

    refute_same(
      original.workload_identity_auth,
      original.with_options(workload_identity: other_identity).workload_identity_auth
    )
    refute_same(
      original.workload_identity_auth,
      original.with_options(http_client: other_transport).workload_identity_auth
    )
  end

  def test_issuer_exchange_honors_configured_and_disabled_request_timeouts
    [nil, 30.0, 120.0].each do |timeout|
      identity = OpenAI::Auth::X509WorkloadIdentity.new(**@identity_options, http_client: @native)
      client = OpenAI::Client.new(api_key: nil, workload_identity: identity, timeout: timeout)
      issuer_request = nil
      dispatch = lambda do |request|
        if request.url.host == "mtls.auth.openai.com"
          issuer_request = request
          token_response
        else
          model_response
        end
      end

      @native.stub(:execute, dispatch) { client.models.retrieve("fake-model") }

      if timeout.nil?
        assert_nil(issuer_request.timeout)
      else
        assert_operator(issuer_request.timeout, :>, timeout - 1)
        assert_operator(issuer_request.timeout, :<=, timeout)
      end
    end
  end

  def test_per_request_timeout_overrides_the_issuer_exchange_deadline
    identity = OpenAI::Auth::X509WorkloadIdentity.new(**@identity_options, http_client: @native)
    client = OpenAI::Client.new(api_key: nil, workload_identity: identity, timeout: 120.0)
    issuer_request = nil
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        issuer_request = request
        token_response
      else
        model_response
      end
    end

    @native.stub(:execute, dispatch) do
      client.models.retrieve("fake-model", request_options: {timeout: 30.0})
    end

    assert_operator(issuer_request.timeout, :>, 29.0)
    assert_operator(issuer_request.timeout, :<=, 30.0)
  end

  def test_api_retry_backoff_never_sleeps_past_the_original_deadline
    identity = OpenAI::Auth::X509WorkloadIdentity.new(**@identity_options, http_client: @native)
    retry_events = []
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: identity,
      timeout: 0.05,
      max_retries: 1,
      on_retry: -> (event) { retry_events << event }
    )
    api_attempts = 0
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        token_response
      else
        api_attempts += 1
        OpenAI::HTTPClient::Response.new(status: 429, headers: {"retry-after" => "1"}, body: "")
      end
    end

    delays = []
    Thread.current.thread_variable_set(:mock_sleep, delays)

    error = @native.stub(:execute, dispatch) do
      assert_raises(OpenAI::Errors::APITimeoutError) { client.models.retrieve("fake-model") }
    end

    assert_equal(1, api_attempts)
    assert_empty(delays)
    assert_empty(retry_events)
    assert_equal("https://mtls.api.openai.com/v1/models/fake-model", error.url.to_s)
    assert_nil(error.cause)
  ensure
    Thread.current.thread_variable_set(:mock_sleep, nil)
  end

  private def token_response
    OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {},
      body: JSON.generate(
        access_token: "fake-issued-token",
        issued_token_type: "urn:ietf:params:oauth:token-type:access_token",
        token_type: "Bearer",
        expires_in: 120
      )
    )
  end

  private def model_response
    OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: JSON.generate(id: "fake-model", created: 1, object: "model", owned_by: "openai")
    )
  end
end
