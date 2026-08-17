# frozen_string_literal: true

require_relative "../test_helper"

class WorkloadIdentityTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  class IDTokenProvider
    def get_token = "id-token"

    def token_type = OpenAI::Auth::TokenType::ID
  end

  def before_all
    super
    WebMock.enable!
  end

  def setup
    super
    @token_path = File.join(Dir.tmpdir, "test_k8s_token_#{SecureRandom.hex}")
    @environment = %w[IDENTITY_PROVIDER_ID SERVICE_ACCOUNT_ID OPENAI_BASE_URL].to_h { [_1, ENV[_1]] }
    @environment.each_key { ENV.delete(_1) }
  end

  def teardown
    FileUtils.rm_f(@token_path)
    WebMock.reset!
    @environment.each { |name, value| value.nil? ? ENV.delete(name) : ENV[name] = value }
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_workload_identity_defaults_to_environment_variables
    ENV["IDENTITY_PROVIDER_ID"] = "environment-provider"
    ENV["SERVICE_ACCOUNT_ID"] = "environment-account"
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new

    config = OpenAI::Auth::WorkloadIdentity.new(
      provider: provider,
      client_id: :oauth_client,
      refresh_buffer_seconds: 60
    )

    assert_equal("environment-provider", config.identity_provider_id)
    assert_equal("environment-account", config.service_account_id)
    assert_same(provider, config.provider)
    assert_equal("oauth_client", config.client_id)
    assert_equal(60, config.refresh_buffer_seconds)
  end

  def test_workload_identity_explicit_identifiers_override_environment_variables
    ENV["IDENTITY_PROVIDER_ID"] = "environment-provider"
    ENV["SERVICE_ACCOUNT_ID"] = "environment-account"

    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: :explicit_provider,
      service_account_id: :explicit_account,
      provider: OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new
    )

    assert_equal("explicit_provider", config.identity_provider_id)
    assert_equal("explicit_account", config.service_account_id)
  end

  def test_workload_identity_rejects_missing_identity_provider_id
    ENV["SERVICE_ACCOUNT_ID"] = "environment-account"

    error = assert_raises(ArgumentError) do
      OpenAI::Auth::WorkloadIdentity.new(
        provider: OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new
      )
    end

    assert_match(/identity_provider_id/, error.message)
    assert_match(/IDENTITY_PROVIDER_ID/, error.message)
  end

  def test_workload_identity_rejects_missing_service_account_id
    ENV["IDENTITY_PROVIDER_ID"] = "environment-provider"

    error = assert_raises(ArgumentError) do
      OpenAI::Auth::WorkloadIdentity.new(
        provider: OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new
      )
    end

    assert_match(/service_account_id/, error.message)
    assert_match(/SERVICE_ACCOUNT_ID/, error.message)
  end

  def test_workload_identity_rejects_blank_identity_provider_id
    ENV["IDENTITY_PROVIDER_ID"] = "environment-provider"

    [nil, "", " \t"].each do |identity_provider_id|
      error = assert_raises(ArgumentError) do
        OpenAI::Auth::WorkloadIdentity.new(
          identity_provider_id: identity_provider_id,
          service_account_id: "service-account",
          provider: OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new
        )
      end

      assert_match(/identity_provider_id/, error.message)
      assert_match(/IDENTITY_PROVIDER_ID/, error.message)
    end
  end

  def test_workload_identity_rejects_blank_service_account_id
    ENV["SERVICE_ACCOUNT_ID"] = "environment-account"

    [nil, "", " \t"].each do |service_account_id|
      error = assert_raises(ArgumentError) do
        OpenAI::Auth::WorkloadIdentity.new(
          identity_provider_id: "identity-provider",
          service_account_id: service_account_id,
          provider: OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new
        )
      end

      assert_match(/service_account_id/, error.message)
      assert_match(/SERVICE_ACCOUNT_ID/, error.message)
    end
  end

  def test_kubernetes_provider_success
    File.write(@token_path, "k8s-jwt-token\n")

    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: @token_path
    )
    assert_equal(OpenAI::Auth::TokenType::JWT, provider.token_type)
    assert_equal("k8s-jwt-token", provider.get_token)
  end

  def test_kubernetes_provider_missing_file
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: "/nonexistent/path/#{SecureRandom.hex}"
    )

    error = assert_raises(OpenAI::Errors::SubjectTokenProviderError) do
      provider.get_token
    end

    assert_equal("kubernetes", error.provider)
    assert_match(/Failed to read/, error.message)
    assert_kind_of(Errno::ENOENT, error.cause)
  end

  def test_azure_imds_provider_success
    stub_request(:get, "http://169.254.169.254/metadata/identity/oauth2/token")
      .with(
        query: hash_including("api-version" => "2018-02-01", "resource" => "https://management.azure.com/"),
        headers: {"Metadata" => "true"}
      )
      .to_return(
        status: 200,
        body: JSON.generate({"access_token" => "azure-id-token", "expires_in" => 3600}),
        headers: {"Content-Type" => "application/json"}
      )

    provider = OpenAI::Auth::SubjectTokenProviders::AzureManagedIdentityTokenProvider.new

    assert_equal(OpenAI::Auth::TokenType::JWT, provider.token_type)
    assert_equal("azure-id-token", provider.get_token)
  end

  def test_azure_imds_provider_error
    stub_request(:get, "http://169.254.169.254/metadata/identity/oauth2/token")
      .with(query: hash_including("api-version" => "2018-02-01", "resource" => "https://management.azure.com/"))
      .to_return(status: 500, body: "Internal Server Error")

    provider = OpenAI::Auth::SubjectTokenProviders::AzureManagedIdentityTokenProvider.new

    error = assert_raises(OpenAI::Errors::SubjectTokenProviderError) do
      provider.get_token
    end

    assert_equal("azure-imds", error.provider)
    assert_match(/Azure IMDS returned 500/, error.message)
  end

  def test_gcp_metadata_provider_success
    stub_request(:get, "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/identity")
      .with(
        query: hash_including("audience" => "https://api.openai.com/v1"),
        headers: {"Metadata-Flavor" => "Google"}
      )
      .to_return(status: 200, body: "gcp-jwt-token")

    provider = OpenAI::Auth::SubjectTokenProviders::GCPIDTokenProvider.new

    assert_equal(OpenAI::Auth::TokenType::ID, provider.token_type)
    assert_equal("gcp-jwt-token", provider.get_token)
  end

  def test_gcp_metadata_provider_error
    stub_request(:get, "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/identity")
      .with(query: hash_including("audience" => "https://api.openai.com/v1"))
      .to_return(status: 404, body: "Not Found")

    provider = OpenAI::Auth::SubjectTokenProviders::GCPIDTokenProvider.new

    error = assert_raises(OpenAI::Errors::SubjectTokenProviderError) do
      provider.get_token
    end

    assert_equal("gcp-metadata", error.provider)
    assert_match(/GCP Metadata Server returned 404/, error.message)
  end

  def test_workload_identity_auth_token_exchange
    File.write(@token_path, "k8s-jwt-token")
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: @token_path
    )

    stub_request(:post, "https://auth.openai.com/oauth/token")
      .with do |request|
        JSON.parse(request.body) == {
            "grant_type" => "urn:ietf:params:oauth:grant-type:token-exchange",
            "subject_token" => "k8s-jwt-token",
            "subject_token_type" => "urn:ietf:params:oauth:token-type:jwt",
            "identity_provider_id" => "idp-123",
            "service_account_id" => "sa-456"
          }
      end
      .to_return(
        status: 200,
        body: JSON.generate({"access_token" => "oauth-access-token", "expires_in" => 3600})
      )

    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )

    auth = OpenAI::Auth::WorkloadIdentityAuth.new(config, "org-123")
    token = auth.get_token

    assert_equal("oauth-access-token", token)
  end

  def test_workload_identity_refresh_cleanup_is_installed_before_interrupts_resume
    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: Object.new
    )
    auth = OpenAI::Auth::WorkloadIdentityAuth.new(config, "org-123")
    source_path = auth.method(:get_token).source_location.fetch(0)
    refresh_line = File
      .foreach(source_path)
      .with_index(1)
      .find do |line, _number|
        line.strip.start_with?("perform_refresh")
      end
      .fetch(1)
    start = Queue.new
    reached_refresh = Queue.new
    release_refresh = Queue.new
    errors = Queue.new
    armed = true
    runner = Thread.new do
      start.pop
      auth.get_token
      # rubocop:disable Lint/RescueException -- verifies fatal async cleanup
    rescue Exception => e
      errors << e
    end
    # rubocop:enable Lint/RescueException

    runner.report_on_exception = false
    trace = TracePoint.new(:line) do |event|
      next unless armed && Thread.current == runner
      next unless event.path == source_path && event.lineno == refresh_line

      armed = false
      reached_refresh << true
      release_refresh.pop
    end

    auth.stub(:fetch_token_from_exchange, -> (**) { {id: "recovered-token", expires_in: 3600} }) do
      trace.enable
      start << true
      Timeout.timeout(1) { reached_refresh.pop }
      runner.raise Timeout::Error, "cancelled refresh"
      release_refresh << true
      runner.join

      assert_instance_of(Timeout::Error, errors.pop(true))
      refute(auth.instance_variable_get(:@refreshing), "interrupted refresh remained wedged")
      assert_equal("recovered-token", auth.get_token)
    end

  ensure
    trace&.disable
    runner&.kill
    runner&.join
  end

  def test_workload_identity_returns_usable_token_during_proactive_refresh
    auth = build_workload_identity_auth
    cache_workload_identity_token(auth, token: "cached-token", expires_in: 60, refresh_in: -1)
    refresh_started = Queue.new
    release_refresh = Queue.new
    fetch = lambda do |deadline:|
      assert_nil(deadline)
      refresh_started << true
      release_refresh.pop
      {id: "refreshed-token", expires_in: 3600}
    end

    refresher = nil
    callers = []

    auth.stub(:fetch_token_from_exchange, fetch) do
      refresher = Thread.new { auth.get_token }
      refresher.report_on_exception = false
      Timeout.timeout(1) { refresh_started.pop }

      callers = 4.times.map do
        Thread
          .new do
            deadline = OpenAI::Internal::Util.monotonic_secs + 0.1
            auth.get_token(deadline: deadline)
          end
          .tap { _1.report_on_exception = false }
      end

      callers.each { |caller| assert_equal("cached-token", Timeout.timeout(1) { caller.value }) }
      assert_predicate(refresher, :alive?)
      release_refresh << true
      assert_equal("refreshed-token", refresher.value)
      assert_equal("refreshed-token", auth.get_token)
    end

  ensure
    release_refresh&.push(true) if refresher&.alive?
    refresher&.join
    callers&.each { _1.kill.join if _1.alive? }
  end

  def test_workload_identity_expired_token_waiters_observe_deadlines
    auth = build_workload_identity_auth
    cache_workload_identity_token(auth, token: "expired-token", expires_in: -1, refresh_in: -2)
    refresh_started = Queue.new
    release_refresh = Queue.new
    fetch = lambda do |deadline:|
      assert_nil(deadline)
      refresh_started << true
      release_refresh.pop
      {id: "shared-token", expires_in: 3600}
    end

    refresher = nil
    waiter = nil

    auth.stub(:fetch_token_from_exchange, fetch) do
      refresher = Thread.new { auth.get_token }
      refresher.report_on_exception = false
      Timeout.timeout(1) { refresh_started.pop }
      deadline = OpenAI::Internal::Util.monotonic_secs + 0.02

      error = assert_raises(Timeout::Error) { auth.get_token(deadline: deadline) }

      assert_match("workload identity authentication", error.message)
      waiter = Thread.new { auth.get_token }
      waiter.report_on_exception = false
      Timeout.timeout(1) { Thread.pass until waiter.status == "sleep" }
      release_refresh << true
      assert_equal("shared-token", refresher.value)
      assert_equal("shared-token", waiter.value)
      assert_equal("shared-token", auth.get_token)
    end

  ensure
    release_refresh&.push(true) if refresher&.alive?
    refresher&.join
    waiter&.join
  end

  def test_workload_identity_expired_token_waiter_observes_refresh_failure
    auth = build_workload_identity_auth
    cache_workload_identity_token(auth, token: "expired-token", expires_in: -1, refresh_in: -2)
    refresh_started = Queue.new
    release_refresh = Queue.new
    fetch = lambda do |deadline:|
      assert_nil(deadline)
      refresh_started << true
      release_refresh.pop
      raise IOError, "refresh failed"
    end

    refresher = nil
    waiter = nil

    auth.stub(:fetch_token_from_exchange, fetch) do
      refresher = Thread.new { auth.get_token }
      refresher.report_on_exception = false
      Timeout.timeout(1) { refresh_started.pop }
      waiter = Thread.new { auth.get_token }
      waiter.report_on_exception = false
      Timeout.timeout(1) { Thread.pass until waiter.status == "sleep" }
      release_refresh << true

      refresh_error = assert_raises(IOError) { refresher.value }
      waiter_error = assert_raises(OpenAI::Errors::AuthenticationError) { waiter.value }
      assert_equal("refresh failed", refresh_error.message)
      assert_match("Token refresh failed", waiter_error.message)
    end

  ensure
    release_refresh&.push(true) if refresher&.alive?
    refresher&.kill&.join if refresher&.alive?
    waiter&.kill&.join if waiter&.alive?
  end

  def test_workload_identity_invalidation_makes_proactive_refresh_mandatory
    auth = build_workload_identity_auth
    cache_workload_identity_token(auth, token: "cached-token", expires_in: 60, refresh_in: -1)
    refresh_started = Queue.new
    release_refresh = Queue.new
    fetch = lambda do |deadline:|
      assert_nil(deadline)
      refresh_started << true
      release_refresh.pop
      {id: "refreshed-token", expires_in: 3600}
    end

    refresher = nil
    waiter = nil

    auth.stub(:fetch_token_from_exchange, fetch) do
      refresher = Thread.new { auth.get_token }
      refresher.report_on_exception = false
      Timeout.timeout(1) { refresh_started.pop }
      auth.invalidate_token
      waiter = Thread.new { auth.get_token }
      waiter.report_on_exception = false
      Timeout.timeout(1) { Thread.pass until waiter.status == "sleep" }

      assert_predicate(waiter, :alive?)
      release_refresh << true
      assert_equal("refreshed-token", refresher.value)
      assert_equal("refreshed-token", waiter.value)
    end

  ensure
    release_refresh&.push(true) if refresher&.alive?
    refresher&.join
    waiter&.kill&.join if waiter&.alive?
  end

  def test_workload_identity_auth_token_exchange_with_optional_client_id
    File.write(@token_path, "k8s-jwt-token")
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: @token_path
    )

    stub_request(:post, "https://auth.openai.com/oauth/token")
      .with(
        body: hash_including(
          "grant_type" => "urn:ietf:params:oauth:grant-type:token-exchange",
          "client_id" => "test-client",
          "subject_token" => "k8s-jwt-token",
          "subject_token_type" => "urn:ietf:params:oauth:token-type:jwt",
          "identity_provider_id" => "idp-123",
          "service_account_id" => "sa-456"
        )
      )
      .to_return(
        status: 200,
        body: JSON.generate({"access_token" => "oauth-access-token", "expires_in" => 3600})
      )

    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider,
      client_id: "test-client"
    )

    auth = OpenAI::Auth::WorkloadIdentityAuth.new(config, "org-123")
    token = auth.get_token

    assert_equal("oauth-access-token", token)
  end

  def test_workload_identity_auth_id_token_exchange_remains_compatible
    stub_request(:post, "https://auth.openai.com/oauth/token")
      .with do |request|
        JSON.parse(request.body) == {
          "grant_type" => "urn:ietf:params:oauth:grant-type:token-exchange",
          "subject_token" => "id-token",
          "subject_token_type" => "urn:ietf:params:oauth:token-type:id_token",
          "identity_provider_id" => "idp-123",
          "service_account_id" => "sa-456"
        }
      end
      .to_return(
        status: 200,
        body: JSON.generate({"access_token" => "oauth-access-token", "expires_in" => 3600})
      )

    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: IDTokenProvider.new
    )

    token = OpenAI::Auth::WorkloadIdentityAuth.new(config, "org-123").get_token

    assert_equal("oauth-access-token", token)
  end

  def test_workload_identity_auth_preserves_private_exchange_subclass_overrides
    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: IDTokenProvider.new
    )
    direct_override =
      Class.new(OpenAI::Auth::WorkloadIdentityAuth) do
        private def fetch_token_from_exchange
          {id: "subclass-token", expires_in: 3600}
        end
      end

    assert_equal("subclass-token", direct_override.new(config, "org-123").get_token)

    stub_request(:post, "https://auth.openai.com/oauth/token")
      .to_return(
        status: 200,
        body: JSON.generate({"access_token" => "handled-token", "expires_in" => 3600})
      )
    response_override =
      Class.new(OpenAI::Auth::WorkloadIdentityAuth) do
        attr_reader :handled, :parsed

        private def handle_token_response(response)
          @handled = true
          super
        end

        private def parse_response_body(response)
          @parsed = true
          super
        end
      end
    auth = response_override.new(config, "org-123")

    assert_equal("handled-token", auth.get_token)
    assert_equal(true, auth.handled)
    assert_equal(true, auth.parsed)
  end

  def test_workload_identity_auth_oauth_error
    File.write(@token_path, "k8s-jwt-token")
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: @token_path
    )

    stub_request(:post, "https://auth.openai.com/oauth/token")
      .to_return(
        status: 401,
        body: JSON.generate(
          {
            "error" => "invalid_client",
            "error_description" => "Invalid client credentials"
          }
        )
      )

    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )

    auth = OpenAI::Auth::WorkloadIdentityAuth.new(config, "org-123")

    error = assert_raises(OpenAI::Errors::OAuthError) do
      auth.get_token
    end

    assert_equal(401, error.status)
    assert_equal("invalid_client", error.error_code)
    assert_match(/Invalid client credentials/, error.message)
  end

  def test_workload_identity_client_initialization
    File.write(@token_path, "k8s-jwt-token")
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: @token_path
    )

    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )

    client = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: nil,
      workload_identity: config,
      organization: "org-123",
      project: "proj-456"
    )

    refute_nil(client.workload_identity_auth)
  end

  def test_workload_identity_rejects_provider_owned_azure_origins_from_every_configuration_source
    azure_base_url = "https://attacker-controlled.openai.azure.com/openai/v1"
    providers = [
      OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: @token_path),
      IDTokenProvider.new
    ]

    providers.product(%i[environment explicit]).each do |provider, source|
      ENV["OPENAI_BASE_URL"] = azure_base_url if source == :environment
      options = {base_url: azure_base_url} if source == :explicit
      config = OpenAI::Auth::WorkloadIdentity.new(
        identity_provider_id: "idp-123",
        service_account_id: "sa-456",
        provider: provider
      )

      error = assert_raises(ArgumentError) do
        OpenAI::Client.new(api_key: nil, workload_identity: config, **options.to_h)
      end

      assert_match(/provider-owned API origin/, error.message)
      ENV.delete("OPENAI_BASE_URL")
    end
  end

  def test_workload_identity_refuses_cross_origin_redirects_for_jwt_and_id_tokens
    File.write(@token_path, "k8s-jwt-token")
    providers = [
      OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: @token_path),
      IDTokenProvider.new
    ]

    providers.each_with_index do |provider, index|
      trusted_url = "https://api#{index}.example/v1/probe"
      attacker_url = "https://attacker#{index}.invalid/collect"
      stub_request(:post, "https://auth.openai.com/oauth/token")
        .to_return(status: 200, body: JSON.generate({"access_token" => "sensitive-token", "expires_in" => 60}))
      stub_request(:get, trusted_url)
        .to_return(status: 307, headers: {"Location" => attacker_url}, body: "redirect")
      stub_request(:get, attacker_url).to_return_json(status: 200, body: {ok: true})
      config = OpenAI::Auth::WorkloadIdentity.new(
        identity_provider_id: "idp-123",
        service_account_id: "sa-456",
        provider: provider
      )
      client = OpenAI::Client.new(
        base_url: "https://api#{index}.example/v1",
        api_key: nil,
        workload_identity: config,
        max_retries: 0
      )

      error = assert_raises(OpenAI::Errors::Error) do
        client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)
      end

      assert_match(/configured API origin/, error.message)
      assert_requested(:get, trusted_url, times: 1)
      assert_not_requested(:get, attacker_url)
    end
  end

  def test_workload_identity_preserves_same_origin_redirects_for_jwt_and_id_tokens
    File.write(@token_path, "k8s-jwt-token")
    providers = [
      OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: @token_path),
      IDTokenProvider.new
    ]

    providers.each_with_index do |provider, index|
      base_url = "https://api#{index}.example/v1"
      stub_request(:post, "https://auth.openai.com/oauth/token")
        .to_return(status: 200, body: JSON.generate({"access_token" => "token-#{index}", "expires_in" => 60}))
      stub_request(:get, "#{base_url}/probe")
        .to_return(status: 307, headers: {"Location" => "#{base_url}/final"}, body: "redirect")
      stub_request(:get, "#{base_url}/final")
        .with(headers: {"Authorization" => "Bearer token-#{index}"})
        .to_return_json(status: 200, body: {ok: true})
      config = OpenAI::Auth::WorkloadIdentity.new(
        identity_provider_id: "idp-123",
        service_account_id: "sa-456",
        provider: provider
      )
      client = OpenAI::Client.new(
        base_url: base_url,
        api_key: nil,
        workload_identity: config,
        max_retries: 0
      )

      result = client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)

      assert_equal(true, result[:ok])
      assert_requested(:get, "#{base_url}/final", times: 1)
    end
  end

  def test_workload_identity_mutually_exclusive_with_api_key
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new
    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )

    error = assert_raises(ArgumentError) do
      OpenAI::Client.new(
        api_key: "my-api-key",
        workload_identity: config,
        organization: "org-123",
        project: "proj-456"
      )
    end

    assert_match(/mutually exclusive/, error.message)
  end

  def test_workload_identity_preserves_admin_auth_requests
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: @token_path
    )
    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )

    stub_request(:get, "http://localhost/admin/test")
      .with(headers: {"Authorization" => "Bearer My Admin API Key"})
      .to_return(
        status: 200,
        body: JSON.generate({"ok" => true}),
        headers: {"Content-Type" => "application/json"}
      )

    client = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: nil,
      admin_api_key: "My Admin API Key",
      workload_identity: config,
      organization: "org-123",
      project: "proj-456"
    )

    response = client.request(
      method: :get,
      path: "admin/test",
      model: OpenAI::Internal::Type::Unknown,
      security: {admin_api_key_auth: true}
    )

    assert_equal({ok: true}, response)
    assert_requested(:get, "http://localhost/admin/test", times: 1)
    assert_not_requested(:post, "https://auth.openai.com/oauth/token")
  end

  def test_401_retry_with_token_invalidation
    File.write(@token_path, "k8s-jwt-token")
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: @token_path
    )

    stub_request(:post, "https://auth.openai.com/oauth/token")
      .to_return(status: 200, body: JSON.generate({"access_token" => "first-token", "expires_in" => 3600}))
      .then
      .to_return(status: 200, body: JSON.generate({"access_token" => "second-token", "expires_in" => 3600}))

    stub_request(:post, "http://localhost/chat/completions")
      .to_return(
        {
          status: 401,
          body: JSON.generate({"error" => {"message" => "invalid_token"}}),
          headers: {"Content-Type" => "application/json"}
        },
        {
          status: 200,
          body: JSON.generate(
            {
              "id" => "chatcmpl-123",
              "choices" => [
                {
                  "finish_reason" => "stop",
                  "index" => 0,
                  "message" => {
                    "content" => "test response",
                    "role" => "assistant"
                  }
                }
              ],
              "created" => Time.now.to_i,
              "model" => "gpt-5.2",
              "object" => "chat.completion",
              "usage" => {
                "completion_tokens" => 10,
                "prompt_tokens" => 5,
                "total_tokens" => 15
              }
            }
          ),
          headers: {"Content-Type" => "application/json"}
        }
      )

    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )
    log_output = StringIO.new

    client = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: nil,
      workload_identity: config,
      organization: "org-123",
      project: "proj-456",
      logger: Logger.new(log_output)
    )

    response = client.chat.completions.create(
      messages: [{role: "user", content: "test"}],
      model: "gpt-5.2"
    )

    assert_equal("chatcmpl-123", response.id)
    assert_includes(log_output.string, "attempts=2")
    refute_includes(log_output.string, "request failed")
    assert_requested(:post, "https://auth.openai.com/oauth/token", times: 2)
    assert_requested(:post, "http://localhost/chat/completions", times: 2)
  end

  def test_workload_identity_token_caching
    File.write(@token_path, "k8s-jwt-token")
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: @token_path
    )

    stub_request(:post, "https://auth.openai.com/oauth/token")
      .to_return(
        status: 200,
        body: JSON.generate({"access_token" => "cached-token", "expires_in" => 3600})
      )

    stub_request(:post, "http://localhost/chat/completions")
      .to_return(
        status: 200,
        body: JSON.generate(
          {
            "id" => "chatcmpl-123",
            "choices" => [
              {
                "finish_reason" => "stop",
                "index" => 0,
                "message" => {"content" => "test response", "role" => "assistant"}
              }
            ],
            "created" => Time.now.to_i,
            "model" => "gpt-5.2",
            "object" => "chat.completion",
            "usage" => {
              "completion_tokens" => 10,
              "prompt_tokens" => 5,
              "total_tokens" => 15
            }
          }
        ),
        headers: {"Content-Type" => "application/json"}
      )

    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )

    client = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: nil,
      workload_identity: config,
      organization: "org-123",
      project: "proj-456"
    )

    response1 = client.chat.completions.create(messages: [{role: "user", content: "test1"}], model: "gpt-5.2")
    response2 = client.chat.completions.create(messages: [{role: "user", content: "test2"}], model: "gpt-5.2")

    assert_equal("chatcmpl-123", response1.id)
    assert_equal("chatcmpl-123", response2.id)
    assert_requested(:post, "https://auth.openai.com/oauth/token", times: 1)
    assert_requested(:post, "http://localhost/chat/completions", times: 2)
  end

  def test_existing_workload_identity_preserves_odd_integer_ttl_refresh_timing
    now = 0.0
    stub_request(:post, "https://auth.openai.com/oauth/token")
      .to_return(status: 200, body: JSON.generate({"access_token" => "first-token", "expires_in" => 5}))
      .then
      .to_return(status: 200, body: JSON.generate({"access_token" => "second-token", "expires_in" => 5}))
    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: IDTokenProvider.new
    )
    auth = OpenAI::Auth::WorkloadIdentityAuth.new(
      config,
      "org-123",
      monotonic_clock: -> { now }
    )

    assert_equal("first-token", auth.get_token)
    now = 2.75
    assert_equal("first-token", auth.get_token)
    now = 3.0
    assert_equal("second-token", auth.get_token)
    assert_requested(:post, "https://auth.openai.com/oauth/token", times: 2)
  end

  def test_failed_shared_refresh_re_elects_a_waiter_and_preserves_the_exchange_error
    started = Queue.new
    release = Queue.new
    calls = 0
    mutex = Mutex.new
    provider = Object.new
    provider.define_singleton_method(:token_type) { OpenAI::Auth::TokenType::ID }
    provider.define_singleton_method(:get_token) do
      current_call = mutex.synchronize { calls += 1 }
      if current_call == 1
        started << true
        release.pop
      end
      "id-token"
    end
    stub_request(:post, "https://auth.openai.com/oauth/token")
      .to_return(status: 503, body: "unavailable")
    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: provider
    )
    auth = OpenAI::Auth::WorkloadIdentityAuth.new(config, "org-123")
    leader = Thread.new do
      auth.get_token
    rescue StandardError => e
      e
    end
    started.pop
    waiter = Thread.new do
      auth.get_token
    rescue StandardError => e
      e
    end
    sleep(0.05)
    release << true

    [leader, waiter].each { assert(_1.join(2), "refresh caller did not finish") }
    errors = [leader.value, waiter.value]

    assert(errors.all? { _1.is_a?(OpenAI::Errors::APIError) })
    assert_equal([503, 503], errors.map(&:status))
    assert_equal(2, calls)
    assert_requested(:post, "https://auth.openai.com/oauth/token", times: 2)
  ensure
    release << true if release
    leader&.kill if leader&.alive?
    waiter&.kill if waiter&.alive?
  end

  private def build_workload_identity_auth
    config = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp-123",
      service_account_id: "sa-456",
      provider: Object.new
    )
    OpenAI::Auth::WorkloadIdentityAuth.new(config, "org-123")
  end

  private def cache_workload_identity_token(auth, token:, expires_in:, refresh_in:)
    now = OpenAI::Internal::Util.monotonic_secs
    auth.instance_variable_get(:@mutex).synchronize do
      auth.instance_variable_set(:@cached_token, token)
      auth.instance_variable_set(:@cached_token_expires_at_monotonic, now + expires_in)
      auth.instance_variable_set(:@cached_token_refresh_at_monotonic, now + refresh_in)
    end
  end
end
