# frozen_string_literal: true

require_relative "../test_helper"

class X509WorkloadIdentityTest < Minitest::Test
  extend Minitest::Serial

  class StubHTTPClient < OpenAI::HTTPClient
    attr_reader :requests

    def initialize(&execute)
      super()
      @execute = execute
      @requests = []
      @mutex = Mutex.new
    end

    def execute(request)
      @mutex.synchronize { @requests << request }
      @execute.call(request)
    end
  end

  def setup
    super
    @environment_names = %w[
      IDENTITY_PROVIDER_ID
      SERVICE_ACCOUNT_ID
      OPENAI_API_KEY
      OPENAI_BASE_URL
    ]
    @environment = @environment_names.to_h { [_1, ENV[_1]] }
    @environment_names.each { ENV.delete(_1) }
  end

  def teardown
    @environment.each { |name, value| value.nil? ? ENV.delete(name) : ENV[name] = value }
    super
  end

  def test_configuration_defaults_to_environment_without_a_subject_token_provider
    ENV["IDENTITY_PROVIDER_ID"] = "environment-provider"
    ENV["SERVICE_ACCOUNT_ID"] = "environment-account"

    config = OpenAI::Auth::X509WorkloadIdentity.new

    assert_equal("environment-provider", config.identity_provider_id)
    assert_equal("environment-account", config.service_account_id)
    assert_equal(1200, config.refresh_buffer_seconds)
    refute_respond_to(config, :provider)
    refute_respond_to(config, :client_id)
    refute_respond_to(config, :certificate)
    refute_respond_to(config, :private_key)
    refute_respond_to(config, :private_key_password)
  end

  def test_configuration_validates_identifiers_and_refresh_buffer
    assert_raises(ArgumentError) do
      OpenAI::Auth::X509WorkloadIdentity.new(
        identity_provider_id: " ",
        service_account_id: "service-account"
      )
    end
    assert_raises(ArgumentError) do
      OpenAI::Auth::X509WorkloadIdentity.new(
        identity_provider_id: "identity-provider",
        service_account_id: ""
      )
    end
    assert_raises(ArgumentError) do
      x509_config(refresh_buffer_seconds: -1)
    end
    assert_raises(ArgumentError) do
      OpenAI::Auth::X509WorkloadIdentity.new(
        identity_provider_id: "identity-provider",
        service_account_id: "service-account",
        certificate: "transport-owned"
      )
    end
  end

  def test_client_is_lazy_and_defaults_only_x509_mode_to_the_mtls_api
    http_client = StubHTTPClient.new { raise "constructor performed network I/O" }

    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: x509_config,
      http_client: http_client
    )
    api_key_client = OpenAI::Client.new(api_key: "test-key")

    assert_empty(http_client.requests)
    assert_equal("https://mtls.api.openai.com/v1", client.base_url.to_s)
    assert_equal("https://api.openai.com/v1", api_key_client.base_url.to_s)
  end

  def test_x509_mode_preserves_environment_and_explicit_base_urls
    ENV["OPENAI_BASE_URL"] = "https://environment.example/v1"
    environment_client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: x509_config,
      http_client: StubHTTPClient.new { raise "unexpected request" }
    )
    explicit_client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: x509_config,
      base_url: "https://explicit.example/v1",
      http_client: StubHTTPClient.new { raise "unexpected request" }
    )

    assert_equal("https://environment.example/v1", environment_client.base_url.to_s)
    assert_equal("https://explicit.example/v1", explicit_client.base_url.to_s)
  end

  def test_api_key_auth_remains_on_the_standard_api_path
    http_client = StubHTTPClient.new do |_request|
      http_response(status: 200, body: {"ok" => true})
    end
    client = OpenAI::Client.new(api_key: "api-key", http_client: http_client)

    result = client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)

    assert_equal(true, result[:ok])
    assert_equal(1, http_client.requests.length)
    request = http_client.requests.fetch(0)
    assert_equal("https://api.openai.com/v1/probe", request.url.to_s)
    assert_equal("Bearer api-key", request.headers.fetch("authorization"))
  end

  def test_x509_exchange_uses_effective_transport_and_exact_request_shape
    http_client = StubHTTPClient.new do |request|
      if request.url.host == "mtls.auth.openai.com"
        http_response(
          status: 200,
          body: {"access_token" => "x509-access-token", "expires_in" => 3600}
        )
      else
        http_response(status: 200, body: {"ok" => true})
      end
    end
    log_output = StringIO.new
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: x509_config,
      http_client: http_client,
      logger: Logger.new(log_output)
    )

    result = client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)

    assert_equal(true, result[:ok])
    assert_equal(2, http_client.requests.length)
    exchange, api_request = http_client.requests
    assert_equal(:post, exchange.method)
    assert_equal("https://mtls.auth.openai.com/oauth/token", exchange.url.to_s)
    assert_equal("application/json", exchange.headers.fetch("content-type"))
    assert_equal(OpenAI::Auth::TokenExchange::TIMEOUT_SECONDS, exchange.timeout)
    assert_equal(
      {
        "grant_type" => "urn:ietf:params:oauth:grant-type:token-exchange",
        "subject_token_type" => "urn:openai:params:oauth:token-type:x509",
        "identity_provider_id" => "idp-123",
        "service_account_id" => "sa-456"
      },
      JSON.parse(exchange.body)
    )
    refute_includes(JSON.parse(exchange.body), "subject_token")
    assert_equal("https://mtls.api.openai.com/v1/probe", api_request.url.to_s)
    assert_equal("Bearer x509-access-token", api_request.headers.fetch("authorization"))
    refute_includes(log_output.string, "x509-access-token")
    refute_includes(log_output.string, "idp-123")
    refute_includes(log_output.string, "sa-456")
  end

  def test_x509_exchange_refuses_redirects_without_forwarding_the_request
    http_client = StubHTTPClient.new do |_request|
      http_response(
        status: 302,
        headers: {"location" => "https://attacker.example/token"},
        body: "redirect"
      )
    end
    auth = x509_auth(http_client)

    error = assert_raises(OpenAI::Errors::APIError) { auth.get_token }

    assert_equal(302, error.status)
    assert_match(/refused redirect/, error.message)
    assert_equal(1, http_client.requests.length)
    assert_equal("mtls.auth.openai.com", http_client.requests.fetch(0).url.host)
  end

  def test_x509_exchange_url_cannot_be_overridden
    error = assert_raises(ArgumentError) do
      OpenAI::Auth::WorkloadIdentityAuth.new(
        x509_config,
        nil,
        token_exchange_url: "https://attacker.example/token",
        http_client: StubHTTPClient.new { raise "unexpected request" }
      )
    end

    assert_match(/cannot be overridden/, error.message)
  end

  def test_x509_exchange_requires_positive_numeric_expires_in_without_leaking_token
    [nil, 0, -1, "3600", 10**400].each do |expires_in|
      http_client = StubHTTPClient.new do |_request|
        http_response(
          status: 200,
          body: {"access_token" => "sensitive-access-token", "expires_in" => expires_in}
        )
      end

      error = assert_raises(OpenAI::Errors::APIError) { x509_auth(http_client).get_token }

      assert_match(/expires_in must be a positive number/, error.message)
      refute_includes(error.inspect, "sensitive-access-token")
    end
  end

  def test_x509_exchange_rejects_a_non_object_token_response
    http_client = StubHTTPClient.new do |_request|
      http_response(status: 200, body: "[]")
    end

    error = assert_raises(OpenAI::Errors::APIError) { x509_auth(http_client).get_token }

    assert_match(/access_token must be a non-empty string/, error.message)
  end

  def test_x509_exchange_honors_retry_after_for_transient_responses
    calls = 0
    delays = []
    http_client = StubHTTPClient.new do |_request|
      calls += 1
      if calls == 1
        http_response(status: 429, headers: {"Retry-After" => "3"}, body: {"error" => "busy"})
      else
        http_response(status: 200, body: {"access_token" => "token", "expires_in" => 60})
      end
    end

    token = x509_auth(http_client, sleeper: ->(delay) { delays << delay }).get_token

    assert_equal("token", token)
    assert_equal(2, calls)
    assert_equal([3.0], delays)
  end

  def test_x509_exchange_retries_connection_errors_with_bounded_backoff
    calls = 0
    delays = []
    http_client = StubHTTPClient.new do |request|
      calls += 1
      if calls < 3
        raise OpenAI::Errors::APIConnectionError.new(url: request.url)
      end

      http_response(status: 200, body: {"access_token" => "token", "expires_in" => 60})
    end

    token = x509_auth(http_client, sleeper: ->(delay) { delays << delay }).get_token

    assert_equal("token", token)
    assert_equal(3, calls)
    assert_equal([0.5, 1.0], delays)
  end

  def test_x509_exchange_bounds_transient_response_retries_and_discards_error_body
    calls = 0
    delays = []
    http_client = StubHTTPClient.new do |_request|
      calls += 1
      http_response(status: 503, body: "sensitive upstream response")
    end

    error = assert_raises(OpenAI::Errors::APIError) do
      x509_auth(http_client, sleeper: ->(delay) { delays << delay }).get_token
    end

    assert_equal(503, error.status)
    assert_equal(3, calls)
    assert_equal([0.5, 1.0], delays)
    assert_nil(error.body)
    refute_includes(error.inspect, "sensitive upstream response")
  end

  def test_x509_oauth_errors_are_not_retried_or_retained_verbatim
    calls = 0
    http_client = StubHTTPClient.new do |_request|
      calls += 1
      http_response(
        status: 403,
        body: {
          "error" => "invalid_grant",
          "error_description" => "sensitive mapping diagnostics"
        }
      )
    end

    error = assert_raises(OpenAI::Errors::OAuthError) { x509_auth(http_client).get_token }

    assert_equal(1, calls)
    assert_equal(:invalid_grant, error.error_code)
    assert_equal(URI("https://mtls.auth.openai.com/oauth/token"), error.url)
    refute_includes(error.inspect, "sensitive mapping diagnostics")
  end

  def test_x509_oauth_errors_discard_untrusted_error_values
    [
      {"message" => "sensitive mapping diagnostics", "token" => "sensitive-token"},
      ["sensitive-token"],
      "sensitive-token"
    ].each do |error_value|
      http_client = StubHTTPClient.new do |_request|
        http_response(status: 403, body: {"error" => error_value})
      end

      error = assert_raises(OpenAI::Errors::OAuthError) { x509_auth(http_client).get_token }

      assert_nil(error.error_code)
      assert_nil(error.body)
      assert_equal("OAuth2 authentication error", error.message)
      refute_includes(error.inspect, "sensitive-token")
      refute_includes(error.inspect, "sensitive mapping diagnostics")
    end
  end

  def test_refresh_buffer_is_clamped_to_half_of_short_token_ttl
    now = 0.0
    tokens = %w[first-token second-token]
    calls = 0
    http_client = StubHTTPClient.new do |_request|
      token = tokens.fetch(calls)
      calls += 1
      http_response(status: 200, body: {"access_token" => token, "expires_in" => 10})
    end
    auth = x509_auth(http_client, monotonic_clock: -> { now })

    assert_equal("first-token", auth.get_token)
    now = 4.99
    assert_equal("first-token", auth.get_token)
    now = 5.0
    assert_equal("second-token", auth.get_token)
    assert_equal(2, calls)
  end

  def test_token_is_refreshed_at_monotonic_expiration
    now = 0.0
    tokens = %w[first-token second-token]
    calls = 0
    http_client = StubHTTPClient.new do |_request|
      token = tokens.fetch(calls)
      calls += 1
      http_response(status: 200, body: {"access_token" => token, "expires_in" => 10})
    end
    auth = x509_auth(
      http_client,
      monotonic_clock: -> { now },
      refresh_buffer_seconds: 0
    )

    assert_equal("first-token", auth.get_token)
    now = 9.99
    assert_equal("first-token", auth.get_token)
    now = 10.0
    assert_equal("second-token", auth.get_token)
    assert_equal(2, calls)
  end

  def test_concurrent_cold_requests_share_one_exchange
    started = Queue.new
    release = Queue.new
    mutex = Mutex.new
    calls = 0
    http_client = StubHTTPClient.new do |_request|
      mutex.synchronize { calls += 1 }
      started << true
      release.pop
      http_response(status: 200, body: {"access_token" => "shared-token", "expires_in" => 60})
    end
    auth = x509_auth(http_client)
    gate = Queue.new
    threads = 100.times.map do
      Thread.new do
        gate.pop
        auth.get_token
      end
    end
    100.times { gate << true }

    started.pop
    sleep(0.05)
    100.times { release << true }
    threads.each { assert(_1.join(2), "concurrent token waiter did not finish") }

    assert_equal(["shared-token"], threads.map(&:value).uniq)
    assert_equal(1, calls)
  ensure
    100.times { release << true } if release
    threads&.each { _1.kill if _1.alive? }
  end

  def test_canceling_a_waiter_does_not_cancel_or_poison_shared_refresh
    started = Queue.new
    release = Queue.new
    http_client = StubHTTPClient.new do |_request|
      started << true
      release.pop
      http_response(status: 200, body: {"access_token" => "winner-token", "expires_in" => 60})
    end
    auth = x509_auth(http_client)
    leader = Thread.new { auth.get_token }
    started.pop
    waiter = Thread.new { auth.get_token }
    sleep(0.05)

    waiter.kill
    assert(waiter.join(1), "canceled waiter did not terminate")
    release << true
    assert(leader.join(2), "refresh leader did not finish")

    assert_equal("winner-token", leader.value)
    assert_equal("winner-token", auth.get_token)
    assert_equal(1, http_client.requests.length)
  ensure
    release << true if release
    leader&.kill if leader&.alive?
    waiter&.kill if waiter&.alive?
  end

  def test_late_invalidation_of_a_rejected_token_preserves_newer_token
    tokens = %w[rejected-token fresh-token]
    calls = 0
    http_client = StubHTTPClient.new do |_request|
      token = tokens.fetch(calls)
      calls += 1
      http_response(status: 200, body: {"access_token" => token, "expires_in" => 60})
    end
    auth = x509_auth(http_client)

    rejected = auth.get_token
    auth.invalidate_token(rejected)
    assert_equal("fresh-token", auth.get_token)
    auth.invalidate_token(rejected)

    assert_equal("fresh-token", auth.get_token)
    assert_equal(2, calls)
    refute_includes(auth.inspect, "fresh-token")
  end

  def test_api_401_invalidates_and_replays_once_with_a_replayable_body
    exchange_count = 0
    api_count = 0
    api_authorizations = []
    http_client = StubHTTPClient.new do |request|
      if request.url.host == "mtls.auth.openai.com"
        exchange_count += 1
        http_response(
          status: 200,
          body: {"access_token" => "token-#{exchange_count}", "expires_in" => 60}
        )
      else
        api_count += 1
        api_authorizations << request.headers.fetch("authorization")
        if api_count == 1
          http_response(status: 401, body: {"error" => {"message" => "rejected"}})
        else
          http_response(status: 200, body: {"ok" => true})
        end
      end
    end
    client = x509_client(http_client)

    result = client.request(method: :post, path: "probe", body: {value: "replayable"})

    assert_equal(true, result[:ok])
    assert_equal(2, exchange_count)
    assert_equal(2, api_count)
    assert_equal(["Bearer token-1", "Bearer token-2"], api_authorizations)
  end

  def test_api_401_is_retried_at_most_once
    exchange_count = 0
    api_count = 0
    http_client = StubHTTPClient.new do |request|
      if request.url.host == "mtls.auth.openai.com"
        exchange_count += 1
        http_response(
          status: 200,
          body: {"access_token" => "token-#{exchange_count}", "expires_in" => 60}
        )
      else
        api_count += 1
        http_response(status: 401, body: {"error" => {"message" => "rejected"}})
      end
    end

    assert_raises(OpenAI::Errors::AuthenticationError) do
      x509_client(http_client).request(method: :post, path: "probe", body: {value: "replayable"})
    end

    assert_equal(2, exchange_count)
    assert_equal(2, api_count)
  end

  def test_api_401_invalidates_but_does_not_replay_a_non_replayable_body
    exchange_count = 0
    api_count = 0
    api_authorizations = []
    http_client = StubHTTPClient.new do |request|
      if request.url.host == "mtls.auth.openai.com"
        exchange_count += 1
        http_response(
          status: 200,
          body: {"access_token" => "token-#{exchange_count}", "expires_in" => 60}
        )
      else
        api_count += 1
        api_authorizations << request.headers.fetch("authorization")
        if api_count == 1
          http_response(status: 401, body: {"error" => {"message" => "rejected"}})
        else
          http_response(status: 200, body: {"ok" => true})
        end
      end
    end
    body = Enumerator.new { _1 << {value: "one shot"} }
    client = x509_client(http_client)

    assert_raises(OpenAI::Errors::AuthenticationError) do
      client.request(
        method: :post,
        path: "probe",
        headers: {"content-type" => "application/jsonl"},
        body: body
      )
    end

    result = client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)

    assert_equal(true, result[:ok])
    assert_equal(2, exchange_count)
    assert_equal(2, api_count)
    assert_equal(["Bearer token-1", "Bearer token-2"], api_authorizations)
  end

  private def x509_config(refresh_buffer_seconds: 1200)
    OpenAI::Auth::X509WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      refresh_buffer_seconds: refresh_buffer_seconds
    )
  end

  private def x509_auth(
    http_client,
    sleeper: ->(_delay) {},
    monotonic_clock: nil,
    refresh_buffer_seconds: 1200
  )
    kwargs = {http_client: http_client, sleeper: sleeper}
    kwargs[:monotonic_clock] = monotonic_clock unless monotonic_clock.nil?
    OpenAI::Auth::WorkloadIdentityAuth.new(
      x509_config(refresh_buffer_seconds: refresh_buffer_seconds),
      nil,
      **kwargs
    )
  end

  private def x509_client(http_client)
    OpenAI::Client.new(
      api_key: nil,
      workload_identity: x509_config,
      http_client: http_client,
      max_retries: 0
    )
  end

  private def http_response(status:, body:, headers: {})
    body = JSON.generate(body) unless body.is_a?(String)
    OpenAI::HTTPClient::Response.new(
      status: status,
      headers: {"content-type" => "application/json"}.merge(headers),
      body: body
    )
  end
end
