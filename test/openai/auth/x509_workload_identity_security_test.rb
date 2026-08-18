# frozen_string_literal: true

require_relative "../test_helper"

class X509WorkloadIdentitySecurityTest < Minitest::Test
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

  def test_x509_identity_snapshot_remains_bound_to_the_cached_token
    identity_provider_id = +"tenant-a"
    config = OpenAI::Auth::X509WorkloadIdentity.new(
      identity_provider_id: identity_provider_id,
      service_account_id: "service-account"
    )
    exchange_bodies = []
    api_authorizations = []
    http_client = StubHTTPClient.new do |request|
      if request.url.host == "mtls.auth.openai.com"
        exchange_bodies << JSON.parse(request.body)
        http_response(status: 200, body: {"access_token" => "tenant-a-token", "expires_in" => 60})
      else
        api_authorizations << request.headers.fetch("authorization")
        http_response(status: 200, body: {"ok" => true})
      end
    end
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: config,
      http_client: http_client,
      max_retries: 0
    )

    client.request(method: :get, path: "first", model: OpenAI::Internal::Type::Unknown)
    identity_provider_id.replace("tenant-b")
    client.request(method: :get, path: "second", model: OpenAI::Internal::Type::Unknown)

    assert_equal(["tenant-a"], exchange_bodies.map { _1.fetch("identity_provider_id") })
    assert_equal(["Bearer tenant-a-token", "Bearer tenant-a-token"], api_authorizations)
    assert_equal("tenant-a", config.identity_provider_id)
  end

  def test_token_exchange_snapshots_identity_from_a_mutable_configuration_subclass
    mutable_identity = {identity_provider_id: "tenant-a"}
    config_class =
      Class.new(OpenAI::Auth::X509WorkloadIdentity) do
        def initialize(mutable_identity)
          @mutable_identity = mutable_identity
          super(
            identity_provider_id: mutable_identity.fetch(:identity_provider_id),
            service_account_id: "service-account"
          )
        end

        def identity_provider_id = @mutable_identity.fetch(:identity_provider_id)
      end
    config = config_class.new(mutable_identity)
    exchange_bodies = []
    http_client = StubHTTPClient.new do |request|
      exchange_bodies << JSON.parse(request.body)
      http_response(status: 200, body: {"access_token" => "token", "expires_in" => 60})
    end
    auth = OpenAI::Auth::WorkloadIdentityAuth.new(config, nil, http_client: http_client)

    mutable_identity[:identity_provider_id] = "tenant-b"

    assert_equal("token", auth.get_token)
    assert_equal("tenant-a", exchange_bodies.fetch(0).fetch("identity_provider_id"))
  end

  def test_x509_token_caches_are_isolated_by_client_transport
    config = x509_config
    authorizations = []
    clients = %w[transport-a transport-b].map do |transport_name|
      http_client = StubHTTPClient.new do |request|
        if request.url.host == "mtls.auth.openai.com"
          http_response(
            status: 200,
            body: {"access_token" => "#{transport_name}-token", "expires_in" => 60}
          )
        else
          authorizations << request.headers.fetch("authorization")
          http_response(status: 200, body: {"ok" => true})
        end
      end
      OpenAI::Client.new(api_key: nil, workload_identity: config, http_client: http_client)
    end

    clients.each do |client|
      client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)
    end

    assert_equal(["Bearer transport-a-token", "Bearer transport-b-token"], authorizations)
    assert_equal([2, 2], clients.map { _1.requester.requests.length })
  end

  def test_x509_token_exchange_respects_the_api_request_deadline
    http_client = StubHTTPClient.new do |request|
      if request.url.host == "mtls.auth.openai.com"
        http_response(status: 200, body: {"access_token" => "token", "expires_in" => 60})
      else
        http_response(status: 200, body: {"ok" => true})
      end
    end
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: x509_config,
      http_client: http_client,
      timeout: 0.25
    )

    client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)

    assert_operator(http_client.requests.fetch(0).timeout, :>, 0)
    assert_operator(http_client.requests.fetch(0).timeout, :<=, 0.25)
  end

  def test_x509_exchange_caps_transient_retry_waits_to_the_authentication_deadline
    [:response, :connection].each do |failure|
      delays = []
      http_client = StubHTTPClient.new do |request|
        if failure == :connection
          raise OpenAI::Errors::APIConnectionError.new(url: request.url)
        end

        http_response(status: 429, headers: {"Retry-After" => "3"}, body: {"error" => "busy"})
      end
      exchange = OpenAI::Auth::TokenExchange::X509.new(
        x509_config,
        token_exchange_url: OpenAI::Auth::TokenExchange::DEFAULT_URL,
        http_client: http_client,
        sleeper: ->(delay) { delays << delay; sleep(delay) }
      )

      assert_raises(Timeout::Error) { exchange.fetch(timeout: 0.05) }

      assert_equal(1, http_client.requests.length, "#{failure} retried after the deadline")
      assert_operator(delays.fetch(0), :<=, 0.05)
      assert_operator(http_client.requests.fetch(0).timeout, :<=, 0.05)
    end
  end

  def test_x509_exchange_recreates_retry_requests_with_the_remaining_timeout
    http_client = StubHTTPClient.new do |_request|
      if http_client.requests.length == 1
        http_response(status: 429, headers: {"Retry-After" => "0.05"}, body: {"error" => "busy"})
      else
        http_response(status: 200, body: {"access_token" => "token", "expires_in" => 60})
      end
    end
    exchange = OpenAI::Auth::TokenExchange::X509.new(
      x509_config,
      token_exchange_url: OpenAI::Auth::TokenExchange::DEFAULT_URL,
      http_client: http_client,
      sleeper: ->(delay) { sleep(delay) }
    )

    assert_equal("token", exchange.fetch(timeout: 0.25).fetch(:id))

    assert_equal(2, http_client.requests.length)
    first_timeout, second_timeout = http_client.requests.map(&:timeout)
    assert_operator(first_timeout, :<=, 0.25)
    assert_operator(second_timeout, :<, first_timeout - 0.04)
  end

  def test_x509_exchange_discards_signed_url_headers_from_authentication_errors
    [302, 403].each do |status|
      http_client = StubHTTPClient.new do |_request|
        http_response(
          status: status,
          headers: {
            "Location" => "https://example.invalid/redirect?token=location-secret",
            "LiNk" => "https://example.invalid/next?signature=link-secret",
            "REFRESH" => "https://example.invalid/retry?key=refresh-secret",
            "x-request-id" => "safe-request-id"
          },
          body: {"error" => "invalid_grant"}
        )
      end

      error = assert_raises(OpenAI::Errors::APIError) { x509_auth(http_client).get_token }

      assert_equal("safe-request-id", error.request_id)
      assert_empty(error.headers.keys & %w[location link refresh])
      %w[location-secret link-secret refresh-secret].each do |secret|
        refute_includes(error.headers.inspect, secret)
        refute_includes(error.inspect, secret)
      end
    end
  end

  def test_x509_client_copy_rejects_provider_owned_origins_before_exchange
    http_client = StubHTTPClient.new { raise "client copy performed network I/O" }
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: x509_config,
      http_client: http_client
    )

    error = assert_raises(ArgumentError) do
      client.with_options(base_url: "https://attacker-controlled.openai.azure.com/openai/v1")
    end

    assert_match(/provider-owned API origin/, error.message)
    assert_empty(http_client.requests)
  end

  def test_late_invalidation_during_retry_backoff_does_not_strand_waiters
    retry_started = Queue.new
    release_retry = Queue.new
    calls = 0
    http_client = StubHTTPClient.new do |_request|
      calls += 1
      case calls
      when 1
        http_response(status: 200, body: {"access_token" => "rejected-token", "expires_in" => 60})
      when 2
        http_response(status: 503, body: {"error" => "busy"})
      else
        http_response(status: 200, body: {"access_token" => "fresh-token", "expires_in" => 60})
      end
    end
    sleeper = lambda do |_delay|
      retry_started << true
      release_retry.pop
    end
    auth = x509_auth(http_client, sleeper: sleeper)
    rejected_token = auth.get_token
    auth.invalidate_token(rejected_token)
    leader = Thread.new { auth.get_token }
    retry_started.pop
    waiter = Thread.new { auth.get_token }
    sleep(0.05)

    auth.invalidate_token(rejected_token)
    release_retry << true

    assert(leader.join(2), "refresh leader did not finish")
    assert(waiter.join(2), "refresh waiter did not finish")
    assert_equal(["fresh-token"], [leader.value, waiter.value].uniq)
    assert_equal(3, calls)
  ensure
    release_retry << true if release_retry
    leader&.kill if leader&.alive?
    waiter&.kill if waiter&.alive?
  end

  def test_longer_deadline_waiter_refreshes_after_short_deadline_leader_times_out
    started = Queue.new
    release = Queue.new
    http_client = StubHTTPClient.new do |_request|
      if http_client.requests.length == 1
        started << true
        release.pop
      end
      http_response(status: 200, body: {"access_token" => "winner-token", "expires_in" => 60})
    end
    auth = x509_auth(http_client)
    deadline = OpenAI::Internal::Util.monotonic_secs + 0.05
    leader = Thread.new { auth.get_token(deadline: deadline) }
    leader.report_on_exception = false
    started.pop
    waiter = Thread.new { auth.get_token(deadline: OpenAI::Internal::Util.monotonic_secs + 2) }
    waiter.report_on_exception = false
    Timeout.timeout(1) { Thread.pass until waiter.status == "sleep" }
    sleep(0.06)
    release << true

    assert_raises(Timeout::Error) { leader.value }
    assert_equal("winner-token", waiter.value)
    assert_equal(2, http_client.requests.length)
  ensure
    release << true if release
    leader&.kill if leader&.alive?
    waiter&.kill if waiter&.alive?
  end

  def test_api_retry_does_not_resend_a_bearer_invalidated_during_backoff
    retry_scheduled = Queue.new
    continue_retry = Queue.new
    exchange_count = 0
    authorizations = Hash.new { |hash, path| hash[path] = [] }
    http_client = StubHTTPClient.new do |request|
      if request.url.host == "mtls.auth.openai.com"
        exchange_count += 1
        http_response(
          status: 200,
          body: {"access_token" => "token-#{exchange_count}", "expires_in" => 60}
        )
      else
        path = request.url.path
        authorizations[path] << request.headers.fetch("authorization")
        if path.end_with?("/retry") && authorizations.fetch(path).length == 1
          http_response(status: 503, body: {"error" => "busy"})
        elsif path.end_with?("/reject") && authorizations.fetch(path).length == 1
          http_response(status: 401, body: {"error" => {"message" => "rejected"}})
        else
          http_response(status: 200, body: {"ok" => true})
        end
      end
    end
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: x509_config,
      http_client: http_client,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0,
      on_retry: lambda do |event|
        next unless event.status == 503

        retry_scheduled << true
        continue_retry.pop
      end
    )
    retry_request = Thread.new do
      client.request(method: :get, path: "retry", model: OpenAI::Internal::Type::Unknown)
    end
    retry_scheduled.pop

    rejected_request = client.request(
      method: :get,
      path: "reject",
      model: OpenAI::Internal::Type::Unknown
    )
    continue_retry << true

    assert(retry_request.join(2), "backing-off API request did not finish")
    assert_equal(true, retry_request.value[:ok])
    assert_equal(true, rejected_request[:ok])
    assert_equal(["Bearer token-1", "Bearer token-2"], authorizations.fetch("/v1/retry"))
    assert_equal(["Bearer token-1", "Bearer token-2"], authorizations.fetch("/v1/reject"))
    assert_equal(2, exchange_count)
  ensure
    continue_retry << true if continue_retry
    retry_request&.kill if retry_request&.alive?
  end

  def test_api_retry_401_invalidates_the_bearer_selected_after_concurrent_rotation
    retry_scheduled = Queue.new
    continue_retry = Queue.new
    exchange_count = 0
    authorizations = Hash.new { |hash, path| hash[path] = [] }
    http_client = StubHTTPClient.new do |request|
      if request.url.host == "mtls.auth.openai.com"
        exchange_count += 1
        http_response(
          status: 200,
          body: {"access_token" => "token-#{exchange_count}", "expires_in" => 60}
        )
      else
        path = request.url.path
        authorization = request.headers.fetch("authorization")
        authorizations[path] << authorization
        if path.end_with?("/retry")
          case authorizations.fetch(path).length
          when 1
            http_response(status: 503, body: {"error" => "busy"})
          when 2
            http_response(status: 401, body: {"error" => {"message" => "rejected"}})
          else
            http_response(status: 200, body: {"ok" => true})
          end
        elsif path.end_with?("/rotate") && authorizations.fetch(path).length == 1
          http_response(status: 401, body: {"error" => {"message" => "rejected"}})
        else
          http_response(status: 200, body: {"ok" => true})
        end
      end
    end
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: x509_config,
      http_client: http_client,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0,
      on_retry: lambda do |event|
        next unless event.status == 503

        retry_scheduled << true
        continue_retry.pop
      end
    )
    retry_request = Thread.new do
      client.request(method: :get, path: "retry", model: OpenAI::Internal::Type::Unknown)
    end
    retry_scheduled.pop

    rotated_request = client.request(
      method: :get,
      path: "rotate",
      model: OpenAI::Internal::Type::Unknown
    )
    continue_retry << true

    assert(retry_request.join(2), "backing-off API request did not finish")
    assert_equal(true, retry_request.value[:ok])
    assert_equal(true, rotated_request[:ok])
    assert_equal(
      ["Bearer token-1", "Bearer token-2", "Bearer token-3"],
      authorizations.fetch("/v1/retry")
    )
    assert_equal(["Bearer token-1", "Bearer token-2"], authorizations.fetch("/v1/rotate"))
    assert_equal(3, exchange_count)
  ensure
    continue_retry << true if continue_retry
    retry_request&.kill if retry_request&.alive?
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

  def test_api_401_invalidates_the_failed_replay_without_replaying_twice
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
        if api_count <= 2
          http_response(status: 401, body: {"error" => {"message" => "rejected"}})
        else
          http_response(status: 200, body: {"ok" => true})
        end
      end
    end
    client = x509_client(http_client)

    assert_raises(OpenAI::Errors::AuthenticationError) do
      client.request(method: :post, path: "probe", body: {value: "replayable"})
    end
    result = client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)

    assert_equal(true, result[:ok])
    assert_equal(3, exchange_count)
    assert_equal(3, api_count)
    assert_equal(
      ["Bearer token-1", "Bearer token-2", "Bearer token-3"],
      api_authorizations
    )
  end

  def test_x509_rejects_prepare_hook_url_rewrites_at_final_dispatch
    http_client = StubHTTPClient.new do |request|
      raise "API request reached transport" unless request.url.host == "mtls.auth.openai.com"

      http_response(status: 200, body: {"access_token" => "token", "expires_in" => 60})
    end
    client_class =
      Class.new(OpenAI::Client) do
        private def prepare_request(request, **context)
          super.merge(url: URI("https://attacker.invalid/probe"))
        end
      end
    client = client_class.new(api_key: nil, workload_identity: x509_config, http_client: http_client)

    error = assert_raises(OpenAI::Errors::Error) do
      client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)
    end

    assert_match(/configured API origin/, error.message)
    assert_equal(1, http_client.requests.length)
    assert_equal("mtls.auth.openai.com", http_client.requests.fetch(0).url.host)
  end

  def test_x509_rejects_duck_typed_url_rewrites_at_final_dispatch
    misleading_url = Struct.new(:scheme, :host, :port) do
      def to_s = "https://mtls.api.openai.com/v1/probe"
    end
    http_client = StubHTTPClient.new do |request|
      raise "API request reached transport" unless request.url.host == "mtls.auth.openai.com"

      http_response(status: 200, body: {"access_token" => "token", "expires_in" => 60})
    end
    client_class =
      Class.new(OpenAI::Client) do
        define_method(:prepare_request) do |request, **context|
          super(request, **context).merge(url: misleading_url.new("https", "attacker.invalid", 443))
        end
        private :prepare_request
      end
    client = client_class.new(api_key: nil, workload_identity: x509_config, http_client: http_client)

    error = assert_raises(OpenAI::Errors::Error) do
      client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)
    end

    assert_match(/configured API origin/, error.message)
    assert_equal(1, http_client.requests.length)
    assert_equal("mtls.auth.openai.com", http_client.requests.fetch(0).url.host)
  end

  def test_x509_rejects_prepare_hook_credential_overrides_at_final_dispatch
    http_client = StubHTTPClient.new do |request|
      raise "API request reached transport" unless request.url.host == "mtls.auth.openai.com"

      http_response(status: 200, body: {"access_token" => "token", "expires_in" => 60})
    end
    client_class =
      Class.new(OpenAI::Client) do
        private def prepare_request(request, **context)
          headers = request.fetch(:headers).merge(
            "Authorization" => "Bearer hook-override",
            "Cookie" => "hook-session=sensitive",
            "Set-Cookie" => "hook-response-session=sensitive"
          )
          super.merge(headers: headers)
        end
      end
    client = client_class.new(api_key: nil, workload_identity: x509_config, http_client: http_client)

    error = assert_raises(OpenAI::Errors::Error) do
      client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)
    end

    assert_match(/credential headers/, error.message)
    assert_equal(1, http_client.requests.length)
    refute_includes(error.inspect, "hook-override")
    refute_includes(error.inspect, "hook-session")
    refute_includes(error.inspect, "hook-response-session")
  end

  def test_x509_rejects_prepare_hook_mutating_both_context_token_and_authorization
    http_client = StubHTTPClient.new do |request|
      if request.url.host == "mtls.auth.openai.com"
        http_response(status: 200, body: {"access_token" => "server-issued-token", "expires_in" => 60})
      else
        http_response(status: 200, body: {"ok" => true})
      end
    end
    client_class =
      Class.new(OpenAI::Client) do
        private def prepare_request(request, **context)
          prepared = super
          prepared.fetch(:workload_identity_context)[:token] = "hook-injected-token"
          prepared.merge(headers: prepared.fetch(:headers).merge("authorization" => "Bearer hook-injected-token"))
        end
      end
    client = client_class.new(api_key: nil, workload_identity: x509_config, http_client: http_client)

    error = assert_raises(OpenAI::Errors::Error) do
      client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)
    end

    assert_match(/authentication context|credential headers/, error.message)
    assert_equal(1, http_client.requests.length)
    refute_includes(error.inspect, "server-issued-token")
    refute_includes(error.inspect, "hook-injected-token")
    assert_nil(error.cause)
  end

  def test_x509_rejects_prepare_hook_mutating_the_selected_token_in_place
    http_client = StubHTTPClient.new do |request|
      if request.url.host == "mtls.auth.openai.com"
        http_response(status: 200, body: {"access_token" => "server-issued-token", "expires_in" => 60})
      else
        http_response(status: 200, body: {"ok" => true})
      end
    end
    client_class =
      Class.new(OpenAI::Client) do
        private def prepare_request(request, **context)
          prepared = super
          prepared.fetch(:workload_identity_context).fetch(:token).replace("hook-injected-token")
          prepared.merge(headers: prepared.fetch(:headers).merge("authorization" => "Bearer hook-injected-token"))
        end
      end
    client = client_class.new(api_key: nil, workload_identity: x509_config, http_client: http_client)

    error = assert_raises(OpenAI::Errors::Error) do
      client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)
    end

    assert_match(/authentication context/, error.message)
    assert_equal(1, http_client.requests.length)
    refute_includes(error.inspect, "server-issued-token")
    refute_includes(error.inspect, "hook-injected-token")
    assert_nil(error.cause)
    assert_equal("server-issued-token", client.workload_identity_auth.get_token)
  end

  def test_x509_rejects_api_key_injected_by_a_prepare_hook
    %w[Api-Key x-API-kEy api_key API_KEY x_api_key X_API_KEY X_API-Key X-API_Key].each do |header|
      http_client = StubHTTPClient.new do |request|
        raise "API request reached transport" unless request.url.host == "mtls.auth.openai.com"

        http_response(status: 200, body: {"access_token" => "token", "expires_in" => 60})
      end
      client_class = Class.new(OpenAI::Client) do
        attr_writer :injected_header

        private def prepare_request(request, **context)
          headers = request.fetch(:headers).merge(@injected_header => "hook-api-key")
          super.merge(headers: headers)
        end
      end
      client = client_class.new(
        api_key: nil,
        workload_identity: x509_config,
        http_client: http_client
      ).tap do |client|
        client.injected_header = header
      end

      error = assert_raises(OpenAI::Errors::Error) do
        client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)
      end

      assert_match(/API-key header/, error.message)
      assert_equal(1, http_client.requests.length)
      refute_includes(error.inspect, "hook-api-key")
    end
  end

  def test_x509_rejects_proxy_authorization_injected_by_a_prepare_hook
    %w[Proxy-Authorization proxy_authorization PROXY_AUTHORIZATION].each do |header|
      http_client = StubHTTPClient.new do |request|
        raise "API request reached transport" unless request.url.host == "mtls.auth.openai.com"

        http_response(status: 200, body: {"access_token" => "token", "expires_in" => 60})
      end
      client_class = Class.new(OpenAI::Client) do
        attr_writer :injected_header

        private def prepare_request(request, **context)
          headers = request.fetch(:headers).merge(@injected_header => "Basic hook-proxy-secret")
          super.merge(headers: headers)
        end
      end
      client = client_class.new(
        api_key: nil,
        workload_identity: x509_config,
        http_client: http_client
      ).tap do |client|
        client.injected_header = header
      end

      error = assert_raises(OpenAI::Errors::Error) do
        client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)
      end

      assert_match(/Proxy-Authorization/, error.message)
      assert_equal(1, http_client.requests.length)
      refute_includes(error.inspect, "hook-proxy-secret")
    end
  end

  def test_x509_preserves_noncredential_prepare_hook_mutations
    http_client = StubHTTPClient.new do |request|
      if request.url.host == "mtls.auth.openai.com"
        http_response(status: 200, body: {"access_token" => "token", "expires_in" => 60})
      else
        http_response(status: 200, body: {"ok" => true})
      end
    end
    client_class =
      Class.new(OpenAI::Client) do
        private def prepare_request(request, **context)
          prepared = super
          prepared.merge(headers: prepared.fetch(:headers).merge("X-Request-Hook" => "preserved"))
        end
      end
    client = client_class.new(api_key: nil, workload_identity: x509_config, http_client: http_client)

    result = client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)

    assert_equal(true, result[:ok])
    assert_equal("preserved", http_client.requests.fetch(1).headers.fetch("X-Request-Hook"))
    assert_equal("Bearer token", http_client.requests.fetch(1).headers.fetch("authorization"))
  end

  def test_x509_rejects_prepare_hook_replacement_of_admin_authorization
    http_client = StubHTTPClient.new { raise "request reached transport" }
    client_class =
      Class.new(OpenAI::Client) do
        private def prepare_request(request, **context)
          headers = request.fetch(:headers).merge("Authorization" => "Basic customer-secret")
          super.merge(headers: headers)
        end
      end
    client = client_class.new(
      api_key: nil,
      admin_api_key: "admin-key",
      workload_identity: x509_config,
      http_client: http_client
    )

    error = assert_raises(OpenAI::Errors::Error) do
      client.request(
        method: :get,
        path: "admin/probe",
        model: OpenAI::Internal::Type::Unknown,
        security: {admin_api_key_auth: true}
      )
    end

    assert_match(/credential headers/, error.message)
    assert_empty(http_client.requests)
    refute_includes(error.inspect, "customer-secret")
  end

  def test_x509_rejects_prepare_hook_authorization_on_a_headerless_request
    http_client = StubHTTPClient.new { raise "request reached transport" }
    client_class =
      Class.new(OpenAI::Client) do
        private def prepare_request(request, **context)
          headers = request.fetch(:headers).merge("Authorization" => "Basic customer-secret")
          super.merge(headers: headers)
        end
      end
    client = client_class.new(api_key: nil, workload_identity: x509_config, http_client: http_client)

    error = assert_raises(OpenAI::Errors::Error) do
      client.request(
        method: :get,
        path: "probe",
        model: OpenAI::Internal::Type::Unknown,
        security: {}
      )
    end

    assert_match(/credential headers/, error.message)
    assert_empty(http_client.requests)
    refute_includes(error.inspect, "customer-secret")
  end

  def test_x509_refuses_cross_origin_api_redirects
    http_client = StubHTTPClient.new do |request|
      case request.url.host
      when "mtls.auth.openai.com"
        http_response(status: 200, body: {"access_token" => "token", "expires_in" => 60})
      when "mtls.api.openai.com"
        http_response(
          status: 302,
          headers: {"location" => "https://attacker.invalid/probe"},
          body: "redirect"
        )
      else
        raise "redirect reached unexpected transport origin"
      end
    end
    client = x509_client(http_client)

    error = assert_raises(OpenAI::Errors::Error) do
      client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)
    end

    assert_match(/configured API origin/, error.message)
    assert_equal(2, http_client.requests.length)
  end

  def test_x509_allows_same_origin_api_redirects
    api_count = 0
    http_client = StubHTTPClient.new do |request|
      if request.url.host == "mtls.auth.openai.com"
        http_response(status: 200, body: {"access_token" => "token", "expires_in" => 60})
      elsif (api_count += 1) == 1
        http_response(status: 302, headers: {"location" => "/v1/final"}, body: "redirect")
      else
        http_response(status: 200, body: {"ok" => true})
      end
    end
    client = x509_client(http_client)

    result = client.request(method: :get, path: "probe", model: OpenAI::Internal::Type::Unknown)

    assert_equal(true, result[:ok])
    assert_equal(3, http_client.requests.length)
    assert_equal(
      ["Bearer token", "Bearer token"],
      http_client.requests.drop(1).map { _1.headers.fetch("authorization") }
    )
  end

  def test_x509_rejects_provider_authentication_mode_mixing
    providers = [
      OpenAI::Providers.azure(
        endpoint: "https://example-resource.openai.azure.com",
        api_key: "azure-key"
      ),
      OpenAI::Providers.bedrock(region: "us-east-1", api_key: "bedrock-token")
    ]

    providers.each do |provider|
      error = assert_raises(ArgumentError) do
        OpenAI::Client.new(provider: provider, workload_identity: x509_config)
      end

      assert_match(/`workload_identity`/, error.message)
    end
  end

  def test_x509_rejects_ambient_api_key_mode_mixing
    original_api_key = ENV["OPENAI_API_KEY"]
    ENV["OPENAI_API_KEY"] = "ambient-api-key"

    error = assert_raises(ArgumentError) do
      OpenAI::Client.new(
        workload_identity: x509_config,
        http_client: StubHTTPClient.new { raise "request reached transport" }
      )
    end

    assert_match(/mutually exclusive/, error.message)
    refute_includes(error.inspect, "ambient-api-key")
  ensure
    original_api_key.nil? ? ENV.delete("OPENAI_API_KEY") : ENV["OPENAI_API_KEY"] = original_api_key
  end

  def test_x509_rejects_a_per_request_override_of_admin_authorization
    http_client = StubHTTPClient.new { raise "request reached transport" }
    client = OpenAI::Client.new(
      api_key: nil,
      admin_api_key: "admin-key",
      workload_identity: x509_config,
      http_client: http_client
    )

    error = assert_raises(OpenAI::Errors::Error) do
      client.request(
        method: :get,
        path: "admin/probe",
        model: OpenAI::Internal::Type::Unknown,
        security: {admin_api_key_auth: true},
        options: {extra_headers: {"Authorization" => "Bearer api-key-downgrade"}}
      )
    end

    assert_match(/custom Authorization/, error.message)
    assert_empty(http_client.requests)
    refute_includes(error.inspect, "admin-key")
    refute_includes(error.inspect, "api-key-downgrade")
  end

  def test_x509_rejects_authorization_downgrade_when_endpoint_auth_is_disabled
    http_client = StubHTTPClient.new { raise "request reached transport" }
    client = x509_client(http_client)

    error = assert_raises(OpenAI::Errors::Error) do
      client.request(
        method: :get,
        path: "probe",
        model: OpenAI::Internal::Type::Unknown,
        security: {},
        options: {extra_headers: {"Authorization" => "Bearer api-key-downgrade"}}
      )
    end

    assert_match(/custom Authorization/, error.message)
    assert_empty(http_client.requests)
    refute_includes(error.inspect, "api-key-downgrade")
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
