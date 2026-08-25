# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::X509LifecycleTest < Minitest::Test
  def setup
    super
    @native = OpenAI::NetHTTPClient.new
    @transport = OpenAI::Auth::X509Transport.new(http_client: @native, certificate_identity: :static)
    @identity = OpenAI::Auth::X509WorkloadIdentity.new(
      identity_provider_id: "idp_fake",
      service_account_id: "svc_acct_fake"
    )
    @client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 0
    )
  end

  def teardown
    @native.close
    super
  end

  def test_successful_requests_share_one_cached_exchange
    exchanges = 0
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        exchanges += 1
        token_response("fake-token-#{exchanges}")
      else
        model_response
      end
    end

    @native.stub(:execute, dispatch) do
      assert_equal("fake-model", @client.models.retrieve("first").id)
      assert_equal("fake-model", @client.models.retrieve("second").id)
    end

    assert_equal(1, exchanges)
  end

  def test_401_invalidates_the_actual_bearer_and_replays_only_once
    exchanges = 0
    api_headers = []
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        exchanges += 1
        token_response("fake-token-#{exchanges}")
      else
        api_headers << request.headers.fetch("authorization")
        api_headers.one? ? unauthorized_response : model_response
      end
    end

    @native.stub(:execute, dispatch) do
      assert_equal("fake-model", @client.models.retrieve("fake-model").id)
    end

    assert_equal(["Bearer fake-token-1", "Bearer fake-token-2"], api_headers)
    assert_equal(2, exchanges)
  end

  def test_failed_replay_invalidates_the_second_rejected_bearer
    exchanges = 0
    api_headers = []
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        exchanges += 1
        token_response("fake-token-#{exchanges}")
      else
        api_headers << request.headers.fetch("authorization")
        api_headers.length <= 2 ? unauthorized_response : model_response
      end
    end

    @native.stub(:execute, dispatch) do
      assert_raises(OpenAI::Errors::AuthenticationError) { @client.models.retrieve("first") }
      assert_equal("fake-model", @client.models.retrieve("second").id)
    end

    assert_equal(["Bearer fake-token-1", "Bearer fake-token-2", "Bearer fake-token-3"], api_headers)
    assert_equal(3, exchanges)
  end

  def test_nonreplayable_request_invalidates_without_resending_its_body
    exchanges = 0
    requests = []
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        exchanges += 1
        token_response("fake-token-#{exchanges}")
      else
        requests << request
        requests.one? ? unauthorized_response : model_response
      end
    end

    io = StringIO.new("fake-file")
    body = Class
      .new do
        def initialize(source) = @source = source
        def read(*) = @source.read(*)
      end
      .new(io)

    @native.stub(:execute, dispatch) do
      assert_raises(OpenAI::Errors::AuthenticationError) do
        @client.request(method: :post, path: "/v1/upload", body: body)
      end

      assert_equal("fake-model", @client.models.retrieve("next").id)
    end

    assert_equal(2, requests.length)
    assert_equal(["Bearer fake-token-1", "Bearer fake-token-2"], requests.map { _1.headers["authorization"] })
  end

  def test_stale_invalidation_does_not_remove_a_newer_cached_generation
    exchanges = 0
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        exchanges += 1
        token_response("fake-token-#{exchanges}")
      else
        model_response
      end
    end

    @native.stub(:execute, dispatch) do
      auth = @client.workload_identity_auth
      assert_equal("fake-token-1", auth.get_token)
      auth.invalidate_token("fake-token-1")
      assert_equal("fake-token-2", auth.get_token)
      auth.invalidate_token("fake-token-1")
      assert_equal("fake-token-2", auth.get_token)
    end

    assert_equal(2, exchanges)
  end

  def test_concurrent_waiters_receive_the_real_exchange_failure
    auth = @client.workload_identity_auth
    refresh_started = Queue.new
    release_refresh = Queue.new
    leader = nil
    waiter = nil
    failure = OpenAI::Errors::APIError.new(
      url: URI("https://mtls.auth.openai.com/oauth/token"),
      status: 503,
      message: "identity service unavailable"
    )
    fetch = lambda do |deadline:|
      refresh_started << deadline
      release_refresh.pop
      raise failure
    end

    auth.stub(:fetch_token_from_exchange, fetch) do
      leader = Thread.new { auth.get_token }
      leader.report_on_exception = false
      Timeout.timeout(1) { refresh_started.pop }
      waiter = Thread.new { auth.get_token }
      waiter.report_on_exception = false
      Timeout.timeout(1) { Thread.pass until waiter.status == "sleep" }
      release_refresh << true

      assert_same(failure, assert_raises(OpenAI::Errors::APIError) { leader.value })
      assert_same(failure, assert_raises(OpenAI::Errors::APIError) { waiter.value })
    end

  ensure
    release_refresh&.push(true) if leader&.alive?
    leader&.kill&.join if leader&.alive?
    waiter&.kill&.join if waiter&.alive?
  end

  def test_waiter_observes_its_joined_refresh_when_a_new_generation_starts
    auth = @client.workload_identity_auth
    condition = auth.instance_variable_get(:@cond_var)
    original_wait = condition.method(:wait)
    first_started = Queue.new
    release_first = Queue.new
    waiter_awakened = Queue.new
    release_waiter = Queue.new
    second_started = Queue.new
    release_second = Queue.new
    failure = OpenAI::Errors::APIError.new(
      url: URI("https://mtls.auth.openai.com/oauth/token"),
      status: 503,
      message: "first refresh failed"
    )
    leader = nil
    waiter = nil
    successor = nil
    attempts = 0
    fetch = lambda do |deadline:|
      attempts += 1
      if attempts == 1
        first_started << deadline
        release_first.pop
        raise failure
      end

      second_started << deadline
      release_second.pop
      {id: "fake-second-generation-token", expires_in: 120}
    end

    wait = lambda do |mutex, *arguments|
      result = original_wait.call(mutex, *arguments)
      if Thread.current == waiter
        mutex.unlock
        begin
          waiter_awakened << true
          release_waiter.pop
        ensure
          mutex.lock
        end
      end

      result
    end

    auth.stub(:fetch_token_from_exchange, fetch) do
      condition.stub(:wait, wait) do
        leader = Thread.new { auth.get_token }
        leader.report_on_exception = false
        Timeout.timeout(2) { first_started.pop }

        waiter = Thread.new { auth.get_token }
        waiter.report_on_exception = false
        Timeout.timeout(2) { Thread.pass until waiter.status == "sleep" }
        release_first << true
        Timeout.timeout(2) { waiter_awakened.pop }
        assert_same(failure, assert_raises(OpenAI::Errors::APIError) { leader.value })

        successor = Thread.new { auth.get_token }
        successor.report_on_exception = false
        Timeout.timeout(2) { second_started.pop }
        release_waiter << true

        joined_failure = nil
        Timeout.timeout(2) do
          joined_failure = assert_raises(OpenAI::Errors::APIError) { waiter.value }
        end

        assert_same(failure, joined_failure)
        assert(successor.alive?, "the joined waiter must not wait for the next refresh")

        release_second << true
        assert_equal("fake-second-generation-token", Timeout.timeout(2) { successor.value })
      end
    end

  ensure
    release_first&.push(true) if leader&.alive?
    release_waiter&.push(true) if waiter&.alive?
    release_second&.push(true) if successor&.alive?
    [leader, waiter, successor].compact.each { _1.kill.join if _1.alive? }
  end

  def test_waiter_never_returns_an_expired_joined_generation_token
    auth = @client.workload_identity_auth
    condition = auth.instance_variable_get(:@cond_var)
    original_broadcast = condition.method(:broadcast)
    refresh_started = Queue.new
    release_refresh = Queue.new
    leader = nil
    waiter = nil
    fetch = lambda do |deadline:|
      refresh_started << deadline
      release_refresh.pop
      {id: "fake-expired-generation-token", expires_in: 0.01}
    end

    broadcast = lambda do
      result = original_broadcast.call
      sleep(0.05)
      result
    end

    auth.stub(:fetch_token_from_exchange, fetch) do
      condition.stub(:broadcast, broadcast) do
        leader = Thread.new { auth.get_token }
        leader.report_on_exception = false
        Timeout.timeout(2) { refresh_started.pop }

        waiter = Thread.new { auth.get_token }
        waiter.report_on_exception = false
        Timeout.timeout(2) { Thread.pass until waiter.status == "sleep" }
        release_refresh << true

        leader_error = assert_raises(OpenAI::Errors::AuthenticationError) { leader.value }
        waiter_error = assert_raises(OpenAI::Errors::AuthenticationError) { waiter.value }
        assert_equal(401, leader_error.status)
        assert_equal(401, waiter_error.status)
        assert_equal("https://mtls.auth.openai.com/oauth/token", waiter_error.url.to_s)
      end
    end

  ensure
    release_refresh&.push(true) if leader&.alive?
    leader&.kill&.join if leader&.alive?
    waiter&.kill&.join if waiter&.alive?
  end

  def test_waiter_never_returns_a_rejected_and_replaced_generation_token
    auth = @client.workload_identity_auth
    condition = auth.instance_variable_get(:@cond_var)
    original_wait = condition.method(:wait)
    first_started = Queue.new
    release_first = Queue.new
    waiter_awakened = Queue.new
    release_waiter = Queue.new
    leader = nil
    waiter = nil
    attempts = 0
    fetch = lambda do |deadline:|
      attempts += 1
      if attempts == 1
        first_started << deadline
        release_first.pop
      end

      {id: "fake-generation-#{attempts}", expires_in: 120}
    end

    wait = lambda do |mutex, *arguments|
      result = original_wait.call(mutex, *arguments)
      if Thread.current == waiter
        mutex.unlock
        begin
          waiter_awakened << true
          release_waiter.pop
        ensure
          mutex.lock
        end
      end

      result
    end

    auth.stub(:fetch_token_from_exchange, fetch) do
      condition.stub(:wait, wait) do
        leader = Thread.new { auth.get_token }
        leader.report_on_exception = false
        Timeout.timeout(2) { first_started.pop }

        waiter = Thread.new { auth.get_token }
        waiter.report_on_exception = false
        Timeout.timeout(2) { Thread.pass until waiter.status == "sleep" }
        release_first << true
        Timeout.timeout(2) { waiter_awakened.pop }

        rejected = Timeout.timeout(2) { leader.value }
        assert_equal("fake-generation-1", rejected)
        auth.invalidate_token(rejected)
        replacement = auth.get_token
        assert_equal("fake-generation-2", replacement)

        release_waiter << true
        assert_equal(replacement, Timeout.timeout(2) { waiter.value })
      end
    end

  ensure
    release_first&.push(true) if leader&.alive?
    release_waiter&.push(true) if waiter&.alive?
    leader&.kill&.join if leader&.alive?
    waiter&.kill&.join if waiter&.alive?
  end

  def test_aborted_refresh_attributes_waiter_authentication_failure_to_mtls_issuer
    auth = @client.workload_identity_auth
    refresh_started = Queue.new
    release_refresh = Queue.new
    leader = nil
    waiter = nil
    fatal_error = Interrupt
    fetch = lambda do |deadline:|
      refresh_started << deadline
      release_refresh.pop
      raise fatal_error, "fake interrupted refresh"
    end

    auth.stub(:fetch_token_from_exchange, fetch) do
      leader = Thread.new { auth.get_token }
      leader.report_on_exception = false
      Timeout.timeout(2) { refresh_started.pop }

      waiter = Thread.new { auth.get_token }
      waiter.report_on_exception = false
      Timeout.timeout(2) { Thread.pass until waiter.status == "sleep" }
      release_refresh << true

      assert_raises(fatal_error) { leader.value }
      error = assert_raises(OpenAI::Errors::AuthenticationError) { waiter.value }
      assert_equal("https://mtls.auth.openai.com/oauth/token", error.url.to_s)
      assert_equal(401, error.status)
    end

  ensure
    release_refresh&.push(true) if leader&.alive?
    leader&.kill&.join if leader&.alive?
    waiter&.kill&.join if waiter&.alive?
  end

  def test_request_credential_overrides_are_rejected_before_any_exchange
    hostile_headers = [
      {"authorization" => "Bearer attacker-token"},
      {"x_api_key" => "fake-provider-key"},
      {"proxy_authorization" => "Basic fake-proxy"},
      {"host" => "attacker.invalid"}
    ]

    @native.stub(:execute, -> (_request) { flunk("hostile headers must fail before token exchange") }) do
      hostile_headers.each do |headers|
        assert_raises(OpenAI::Errors::Error, ArgumentError) do
          @client.models.retrieve("fake-model", request_options: {extra_headers: headers})
        end
      end
    end
  end

  def test_post_preparation_hooks_cannot_replace_the_exchanged_bearer
    client_class = Class.new(OpenAI::Client) do
      private def prepare_request(request, redirect_count:, retry_count:)
        prepared = super
        prepared.merge(headers: prepared.fetch(:headers).merge("authorization" => "Bearer fake-replacement"))
      end
    end

    client = client_class.new(
      api_key: nil,
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 0
    )
    destinations = []
    dispatch = lambda do |request|
      destinations << request.url.host
      token_response("fake-issued-token")
    end

    @native.stub(:execute, dispatch) do
      error = assert_raises(OpenAI::Errors::Error) { client.models.retrieve("fake-model") }
      assert_match(/cannot override the selected authorization credential/, error.message)
    end

    assert_equal(["mtls.auth.openai.com"], destinations)
  end

  def test_safe_post_preparation_hooks_remain_supported
    client_class = Class.new(OpenAI::Client) do
      private def prepare_request(request, redirect_count:, retry_count:)
        prepared = super
        prepared.merge(headers: prepared.fetch(:headers).merge("x-fake-trace" => "fake-value"))
      end
    end

    client = client_class.new(
      api_key: nil,
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 0
    )
    api_request = nil
    dispatch = lambda do |request|
      if request.url.host == "mtls.auth.openai.com"
        token_response("fake-issued-token")
      else
        api_request = request
        model_response
      end
    end

    @native.stub(:execute, dispatch) do
      assert_equal("fake-model", client.models.retrieve("fake-model").id)
    end

    assert_equal("Bearer fake-issued-token", api_request.headers.fetch("authorization"))
    assert_equal("fake-value", api_request.headers.fetch("x-fake-trace"))
  end

  def test_post_preparation_hooks_cannot_mutate_the_trusted_original_credential
    client_class = Class.new(OpenAI::Client) do
      private def prepare_request(request, redirect_count:, retry_count:)
        prepared = super
        replacement = "Bearer fake-mutated-original"
        request.delete(:x509_request_context)
        request.fetch(:headers)["authorization"] = replacement
        prepared.merge(headers: prepared.fetch(:headers).merge("authorization" => replacement))
      end
    end

    client = client_class.new(
      api_key: nil,
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 0
    )
    destinations = []
    dispatch = lambda do |request|
      destinations << request.url.host
      token_response("fake-issued-token")
    end

    @native.stub(:execute, dispatch) do
      error = assert_raises(OpenAI::Errors::Error) { client.models.retrieve("fake-model") }
      assert_match(/cannot override the selected authorization credential/, error.message)
    end

    assert_equal(["mtls.auth.openai.com"], destinations)
  end

  def test_cached_bearer_is_redacted_from_authenticator_inspection
    dispatch = lambda do |request|
      request.url.host == "mtls.auth.openai.com" ? token_response("fake-sensitive-token") : model_response
    end

    @native.stub(:execute, dispatch) do
      assert_equal("fake-model", @client.models.retrieve("fake-model").id)
    end

    inspected = @client.workload_identity_auth.inspect
    refute_includes(inspected, "fake-sensitive-token")
    refute_includes(inspected, "idp_fake")
    refute_includes(inspected, "svc_acct_fake")
  end

  def test_disabled_security_schemes_dispatch_without_exchanging_or_sending_credentials
    client = OpenAI::Client.new(
      api_key: nil,
      admin_api_key: "fake-admin-key",
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 0
    )
    observed = []
    response = model_response
    dispatch = lambda do |request|
      observed << request
      response
    end

    @native.stub(:execute, dispatch) do
      client.request(
        method: :get,
        path: "/v1/models/fake-model",
        security: {bearer_auth: false, admin_api_key_auth: false}
      )
    end

    assert_equal(1, observed.length)
    request = observed.fetch(0)
    assert_equal("mtls.api.openai.com", request.url.host)
    refute_includes(request.headers, "authorization")
  end

  def test_disabled_security_schemes_cannot_inject_an_authorization_override
    client = OpenAI::Client.new(
      api_key: nil,
      admin_api_key: "fake-admin-key",
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 0
    )

    @native.stub(:execute, -> (_request) { flunk("unauthenticated requests cannot inject credentials") }) do
      error = assert_raises(OpenAI::Errors::Error) do
        client.request(
          method: :get,
          path: "/v1/models/fake-model",
          headers: {"authorization" => "Bearer fake-injected-token"},
          security: {bearer_auth: false, admin_api_key_auth: false}
        )
      end

      assert_match(/cannot override the selected authorization credential/, error.message)
    end
  end

  def test_selected_security_schemes_cannot_be_replaced_by_another_configured_credential
    client = OpenAI::Client.new(
      api_key: nil,
      admin_api_key: "fake-admin-key",
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 0
    )
    disabled = {bearer_auth: false, admin_api_key_auth: false}
    bearer_only = {bearer_auth: true, admin_api_key_auth: false}
    admin_only = {bearer_auth: false, admin_api_key_auth: true}
    both = {bearer_auth: true, admin_api_key_auth: true}
    overrides = [
      [disabled, "Bearer fake-admin-key"],
      [disabled, "Bearer workload-identity-auth"],
      [bearer_only, "Bearer fake-admin-key"],
      [admin_only, "Bearer workload-identity-auth"],
      [both, "Bearer fake-admin-key"],
      [nil, "Bearer fake-admin-key"]
    ]

    @native.stub(:execute, -> (_request) { flunk("incorrect security scheme must fail before token exchange") }) do
      overrides.each do |security, authorization|
        error = assert_raises(OpenAI::Errors::Error) do
          options = {
            method: :get,
            path: "/v1/models/fake-model",
            headers: {"authorization" => authorization}
          }
          options[:security] = security unless security.nil?
          client.request(**options)
        end

        assert_match(/cannot override the selected authorization credential/, error.message)
      end
    end
  end

  def test_explicit_bearer_security_uses_x509_instead_of_an_available_admin_credential
    client = OpenAI::Client.new(
      api_key: nil,
      admin_api_key: "fake-admin-key",
      workload_identity: @identity,
      http_client: @transport,
      max_retries: 0
    )
    destinations = []
    dispatch = lambda do |request|
      destinations << request
      request.url.host == "mtls.auth.openai.com" ? token_response("fake-issued-token") : model_response
    end

    @native.stub(:execute, dispatch) do
      client.request(
        method: :get,
        path: "/v1/models/fake-model",
        security: {bearer_auth: true, admin_api_key_auth: false}
      )
    end

    assert_equal(["mtls.auth.openai.com", "mtls.api.openai.com"], destinations.map { _1.url.host })
    assert_equal("Bearer fake-issued-token", destinations.fetch(1).headers.fetch("authorization"))
  end

  def test_separate_admin_bearer_is_preserved_without_token_exchange
    client = OpenAI::Client.new(
      api_key: nil,
      admin_api_key: "fake-admin-key",
      workload_identity: @identity,
      http_client: @transport
    )
    observed = nil
    response = model_response
    dispatch = lambda do |request|
      observed = request
      response
    end

    @native.stub(:execute, dispatch) do
      client.request(
        method: :get,
        path: "/v1/models/fake-model",
        security: {admin_api_key_auth: true}
      )
    end

    assert_equal("mtls.api.openai.com", observed.url.host)
    assert_equal("Bearer fake-admin-key", observed.headers.fetch("authorization"))
  end

  private def token_response(token)
    OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {},
      body: JSON.generate(
        access_token: token,
        issued_token_type: "urn:ietf:params:oauth:token-type:access_token",
        token_type: "Bearer",
        expires_in: 120
      )
    )
  end

  private def unauthorized_response
    OpenAI::HTTPClient::Response.new(
      status: 401,
      headers: {"content-type" => "application/json"},
      body: JSON.generate(error: {message: "invalid authentication"})
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
